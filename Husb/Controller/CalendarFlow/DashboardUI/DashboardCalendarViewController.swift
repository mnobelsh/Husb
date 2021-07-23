//
//  CalendarViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

struct DashboardCalendarViewControllerRequest {
    
}

protocol DashboardCalendarViewControllerRoute {
    
    func showDetailChallengeUI(
        navigationController: UINavigationController?,
        request: DetailChallengeViewControllerRequest
    )
    
}

class DashboardCalendarViewController: UIViewController {
    
    private var route: DashboardCalendarViewControllerRoute!
    private var request: DashboardCalendarViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    static func create(
        route: DashboardCalendarViewControllerRoute,
        request: DashboardCalendarViewControllerRequest,
        useCase: UseCaseFactory
    ) -> DashboardCalendarViewController {
        let viewController = DashboardCalendarViewController()
        viewController.route = route
        viewController.tabBarItem = .init(
            title: "Calendar",
            image: UIImage.calendarIcon.withTintColor(.skyBlue, renderingMode: .alwaysOriginal),
            selectedImage: UIImage.calendarIcon.withTintColor(.seaBlue, renderingMode: .alwaysOriginal)
        )
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    
    private var selectedMonth: Int = Int(Date().getString(withFormat: "MM")) ?? 7
    private var selectedYear: Int = Int(Date().getString(withFormat: "YYYY")) ?? 2021
    private var todayDate: Int = Int(Date().getString(withFormat: "d")) ?? 9
    private var selectedDate = Date() {
        didSet {
            MessageKit.showLoadingView()
            self.fetchUserChallenges {
                MessageKit.hideLoadingView()
            }
            self.selectedDateLabel.text = self.selectedDate.getString(withFormat: "EEEE, d MMMM YYYY")
            self.dateCollectionView.reloadData()
        }
    }
    private var dayDates: [Date] = [] {
        didSet {
            self.dateCollectionView.reloadData()
        }
    }
    
    private var currentUser: UserDomain? {
        didSet {
            MessageKit.showLoadingView()
            self.fetchUserChallenges {
                MessageKit.hideLoadingView()
            }
        }
    }
    private var allChallenges: [ChallengeDomain] = [] {
        didSet {
            self.dateCollectionView.reloadData()
        }
    }
    private var uncompletedChallenges: [ChallengeDomain] = [] {
        didSet {
            self.challengeCollectionView.reloadData()
        }
    }
    private var completedChallenges: [ChallengeDomain] = [] {
        didSet {
            self.challengeCollectionView.reloadData()
        }
    }
    
    // MARK: - SubViews
    lazy var dateCollectionView: CalendarDateCollectionView = CalendarDateCollectionView(frame: self.view.bounds)
    lazy var challengeCollectionView: CalendarChallengeCollectionView = CalendarChallengeCollectionView(frame: self.view.bounds)
    lazy var selectedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 1
        label.text = "Today Date"
        label.textColor = .jetBlack
        label.textAlignment = .left
        return label
    }()
    lazy var prevMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.chevronLeft.withTintColor(.seaBlue, renderingMode: .alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        button.addTarget(self, action: #selector(self.onPrevMonthButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    lazy var nextMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.chevronRight.withTintColor(.seaBlue, renderingMode: .alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        button.addTarget(self, action: #selector(self.onNextMonthButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    lazy var selectedMonthAndYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 1
        label.text = "Month Year"
        label.textColor = .jetBlack
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onSelectedMonthAndYearLabelDidTap(_:)))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    lazy var calendarHeaderContainerView: UIView = {
        let view = UIView()
        view.addSubview(self.prevMonthButton)
        view.addSubview(self.nextMonthButton)
        view.addSubview(self.selectedMonthAndYearLabel)
        self.prevMonthButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        self.nextMonthButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        self.selectedMonthAndYearLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.prevMonthButton.snp.trailing).offset(20)
            make.trailing.equalTo(self.nextMonthButton.snp.leading).offset(-20)
            make.top.bottom.equalTo(self.prevMonthButton)
        }
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableHero()
    }


}

// MARK: - Private Function
private extension DashboardCalendarViewController {

    func setupViewDidLoad() {
        let separatorView = UIView()
        separatorView.backgroundColor = .spaceGrey
        separatorView.dropShadow(withColor: .spaceGrey, opacity: 0.7, offset: .init(width: 1.5, height: 1.5))
        self.view.backgroundColor = .ghostWhite
        self.dateCollectionView.delegate = self
        self.dateCollectionView.dataSource = self
        self.challengeCollectionView.delegate = self
        self.challengeCollectionView.dataSource = self
        self.view.addSubview(self.calendarHeaderContainerView)
        self.view.addSubview(self.dateCollectionView)
        self.view.addSubview(self.selectedDateLabel)
        self.view.addSubview(separatorView)
        self.view.addSubview(self.challengeCollectionView)
        
        self.challengeCollectionView.refreshControl?.addTarget(
            self,
            action: #selector(self.onChallengeCollectionViewRefreshControlValueChanged(_:)),
            for: .valueChanged
        )

        self.calendarHeaderContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(25)
        }
        self.dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.calendarHeaderContainerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        self.selectedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateCollectionView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(20)
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(self.selectedDateLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(2)
        }
        self.challengeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func setupViewWillAppear() {
        MessageKit.showLoadingView()
        self.fetchCurrentUser {
            self.setCalendarToToday()
        }
        self.enableHero()
    }
    
    func configureSelectedMonthAndYear() {
        guard let selectedMonthAndYear = Calendar.current.date(from: .init(year: self.selectedYear, month: self.selectedMonth)) else { return }
        self.selectedMonthAndYearLabel.text = selectedMonthAndYear.getString(withFormat: "MMMM YYYY")
        guard let numberOfDays = Calendar.current.range(of: .day, in: .month, for: selectedMonthAndYear) else { return }
        self.dayDates = numberOfDays.map({Calendar.current.date(from: .init(year: self.selectedYear, month: self.selectedMonth, day: $0)) ?? Date() })
    }
    
    func setCalendarToToday() {
        self.selectedMonth = Int(Date().getString(withFormat: "MM")) ?? 7
        self.selectedYear = Int(Date().getString(withFormat: "YYYY")) ?? 2021
        self.configureSelectedMonthAndYear()
        self.dateCollectionView.scrollToItem(at: IndexPath(item: self.todayDate-1, section: 0), at: .centeredHorizontally, animated: true)
        self.selectedDate = Date()
    }
    
    func fetchCurrentUser(completion: @escaping() -> Void) {
        self.useCase
            .fetchUserUseCase()
            .execute(.init(parameter: .current)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.currentUser = response.user
                        completion()
                    case .failure:
                        MessageKit.showAlertMessageView(title: "Unable to perform request, please check your internet connection.", type: .failure)
                        completion()
                    }
                }
            }
    }
    
    func fetchUserChallenges(completion: @escaping() -> Void) {
        guard let userId = self.currentUser?.id else { return }
        let request = FetchUserChallengesUseCaseRequest(
            userId: userId,
            objective: .all
        )
        self.useCase
            .fetchUserChallengesUseCase()
            .execute(request) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.allChallenges = response.challenges
                        let todayChallenges = response.challenges.filter { challenge in
                            guard let dueDate = challenge.dueDate else { return false }
                            return Calendar.current.isDate(dueDate, inSameDayAs: self.selectedDate)
                        }
                        self.uncompletedChallenges = todayChallenges.filter({$0.isActive && !$0.isCompleted})
                        self.completedChallenges = todayChallenges.filter({$0.isActive && $0.isCompleted})
                        completion()
                    case .failure:
                        completion()
                        MessageKit.showAlertMessageView(title: "Unable to perform request, please check your internet connection.", type: .failure)
                    }
                }
            }
    }
    
    @objc
    func onNextMonthButtonDidTap(_ sender: UIButton) {
        self.selectedMonth += 1
        if self.selectedMonth > 12 {
            self.selectedMonth = 1
            self.selectedYear += 1
        }
        self.configureSelectedMonthAndYear()
        self.dateCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
    @objc
    func onPrevMonthButtonDidTap(_ sender: UIButton) {
        self.selectedMonth -= 1
        if selectedMonth < 1 {
            self.selectedMonth = 12
            self.selectedYear -= 1
        }
        self.configureSelectedMonthAndYear()
        self.dateCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
    @objc
    func onSelectedMonthAndYearLabelDidTap(_ sender: UITapGestureRecognizer) {
        self.setCalendarToToday()
    }
    
    @objc
    func onChallengeCollectionViewRefreshControlValueChanged(_ sender: UIRefreshControl) {
        guard self.currentUser != nil else { return }
        sender.beginRefreshing()
        self.fetchUserChallenges {
            sender.endRefreshing()
        }
    }
    
}

// MARK: - DashboardCalendarViewController+UICollectionViewDataSource
extension DashboardCalendarViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.dateCollectionView {
            return 1
        } else if collectionView == self.challengeCollectionView {
            return CalendarChallengeCollectionView.Section.allCases.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dateCollectionView {
            return self.dayDates.count
        } else if collectionView == self.challengeCollectionView {
            switch CalendarChallengeCollectionView.Section(rawValue: section) {
            case .uncompleted:
                guard !self.uncompletedChallenges.isEmpty else {
                    return 1
                }
                return self.uncompletedChallenges.count
            case .completed:
                guard !self.completedChallenges.isEmpty else {
                    return 1
                }
                return self.completedChallenges.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.dateCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDateCollectionCell.identifier, for: indexPath) as? CalendarDateCollectionCell else { return  EmptyCollectionViewCell() }
            let isSelected = Calendar.current.isDate(self.dayDates[indexPath.row], inSameDayAs: self.selectedDate)
            cell.fill(with: self.dayDates[indexPath.row], challenges: self.allChallenges, isSelected: isSelected)
            return cell
        } else if collectionView == self.challengeCollectionView {
            switch CalendarChallengeCollectionView.Section(rawValue: indexPath.section) {
            case .uncompleted:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UncompletedChallengeCollectionCell.identifier, for: indexPath) as? UncompletedChallengeCollectionCell else { return EmptyCollectionViewCell() }
                if self.uncompletedChallenges.isEmpty {
                    if self.completedChallenges.isEmpty {
                        cell.fill(title: "You don't have any uncompleted challenge on this date, you can finish your current challenge or start your saved challenge.", buttonIsHidden: true)
                    } else {
                        cell.fill(title: "Yaay! you have finished all of your challenges on this date 😉", buttonIsHidden: true)
                    }
                } else {
                    cell.fill(challenge: self.uncompletedChallenges[indexPath.row])
                }
                cell.delegate = self
                return cell
            case .completed:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompletedChallengeCollectionCell.identifier, for: indexPath) as? CompletedChallengeCollectionCell else { return EmptyCollectionViewCell() }
                if self.completedChallenges.isEmpty {
                    cell.fill(title: "You haven't been completed any challenge", description: "Finish your uncompleted challenges to make another beautiful moments with your partner ❤️")
                } else {
                    cell.fill(challenge: self.completedChallenges[indexPath.row])
                }
                return cell
            default:
                break
            }
            return EmptyCollectionViewCell()
        }
        return EmptyCollectionViewCell()
    }
    
    
}

// MARK: - DashboardCalendarViewController+UICollectionViewDelegate
extension DashboardCalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.dateCollectionView {
            self.selectedDate = self.dayDates[indexPath.row]
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        } else if collectionView == self.challengeCollectionView {
            switch CalendarChallengeCollectionView.Section(rawValue: indexPath.section) {
            case .completed:
                if self.completedChallenges.isEmpty {
                    MessageKit.showImageViewer(image: .onboardingConnect)
                } else {
                    let challenge = self.completedChallenges[indexPath.row]
                    MessageKit.showImageViewer(image: challenge.momentImage ?? .onboardingConnect, imageTitle: challenge.title)
                }
            default:
                break
            }
        }
    }
    
}


extension DashboardCalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.challengeCollectionView {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
            switch CalendarChallengeCollectionView.Section(rawValue: indexPath.section) {
            case .uncompleted:
                headerView.fill(title: "Uncompleted Challenges")
            case .completed:
                headerView.fill(title: "Completed Challenges")
            default:
                break
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.dateCollectionView {
            let height = collectionView.frame.height * 0.95
            let width = collectionView.frame.width * 0.2
            return CGSize(width: width, height: height)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.dateCollectionView {
            return CGFloat(10)
        }
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.dateCollectionView {
            return CGFloat(10)
        }
        return CGFloat(0)
    }
}

extension DashboardCalendarViewController: UncompletedChallengeCollectionCellDelegate {
    
    func uncompletedChallengeCollectionCell(
        _ cell: UncompletedChallengeCollectionCell,
        didTap goToChallengeButton: UIButton,
        challenge: ChallengeDomain
    ) {
        let request = DetailChallengeViewControllerRequest(challenge: challenge)
        self.route.showDetailChallengeUI(navigationController: self.navigationController, request: request)
    }
    
}
