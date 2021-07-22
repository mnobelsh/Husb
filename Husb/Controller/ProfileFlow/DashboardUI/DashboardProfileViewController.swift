//
//  DashboardProfileViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

struct DashboardProfileViewControllerRequest {

}

protocol DashboardProfileViewControllerRoute {
    
    func makeConnectProfileViewController(
        request: ConnectProfileViewControllerRequest
    ) -> ConnectProfileViewController
    
}

class DashboardProfileViewController: UIViewController {
    
    static func create(
        route: DashboardProfileViewControllerRoute,
        request: DashboardProfileViewControllerRequest,
        useCase: UseCaseFactory
    ) -> DashboardProfileViewController {
        let viewController = DashboardProfileViewController()
        viewController.route = route
        viewController.tabBarItem = .init(
            title: "Profile",
            image: UIImage.person.withTintColor(.skyBlue, renderingMode: .alwaysOriginal),
            selectedImage: UIImage.person.withTintColor(.seaBlue, renderingMode: .alwaysOriginal)
        )
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    
    private var route: DashboardProfileViewControllerRoute!
    private var request: DashboardProfileViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    // MARK: - SubViews
    lazy var profileTableView: DashboardProfileTableView = DashboardProfileTableView(frame: self.view.bounds, style: .plain)
    private var connectedUser: UserDomain? {
        didSet {
            self.profileTableView.reloadData()
        }
    }
    private var currentUser: UserDomain? {
        didSet {
            self.profileTableView.reloadData()
            MessageKit.showLoadingView()
            guard let currentUser = self.currentUser, let connectedUserId = currentUser.connectedUserId else { return }
            self.useCase.fetchUserUseCase().execute(.init(parameter: .byId(userId: connectedUserId))) { result in
                DispatchQueue.main.async {
                    MessageKit.hideLoadingView()
                    let connectedUser = try? result.get().user
                    self.connectedUser = connectedUser
                }
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCurrentUser()
    }
    
    // MARK: - Private Function
    private func setupViewDidLoad() {
        self.view.backgroundColor = .ghostWhite
        self.profileTableView.dataSource = self
        self.profileTableView.delegate = self
        self.view.addSubview(self.profileTableView)
        self.profileTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func fetchCurrentUser() {
        MessageKit.showLoadingView()
        self.useCase.fetchUserUseCase().execute(.init(parameter: .current)) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.currentUser = response.user
                    MessageKit.hideLoadingView()
                case .failure:
                    MessageKit.hideLoadingView()
                    MessageKit.showAlertMessageView(title: "Unable to perform request, please check your internet connection.", type: .failure)
                }
            }
        }
    }
    
    
}


extension DashboardProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.currentUser != nil else { return 0 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentUser = self.currentUser else { return UITableViewCell() }
        switch DashboardProfileTableView.Items(rawValue: indexPath.row) {
        case .profileInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableCell.identifier, for: indexPath) as? ProfileInfoTableCell else { return UITableViewCell() }
            cell.delegate = self
            cell.fill(user: currentUser, connectedUser: self.connectedUser)
            return cell
        case .notificationsSetting:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
}

extension DashboardProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch DashboardProfileTableView.Items(rawValue: indexPath.row) {
        case .profileInfo:
            return CGFloat(ProfileInfoTableCell.height)
        case .notificationsSetting:
            return 0
        default:
            return 0
        }
    }
    
}

extension DashboardProfileViewController: ProfileInfoTableCellDelegate {
    
    
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapProfileImageView imageView: UIImageView) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didLongPressProfileImageView imageView: UIImageView) {
        guard let currentUser = self.currentUser else { return}
        MessageKit.showImageViewer(image: currentUser.profileImage)
    }
    
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapScanQRButton button: UIButton) {
        guard let currentUser = self.currentUser else { return }
        let messageViewId = UUID().uuidString
        let scanQRCodeAction = { (_ userId: String) in
            MessageKit.hide(id: messageViewId)
            MessageKit.showLoadingView()
            let request = FetchUserUseCaseRequest(parameter: .byId(userId: userId))
            self.useCase.fetchUserUseCase().execute(request) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        MessageKit.hideLoadingView()
                        if let connectedUser = response.user {
                            let request = ConnectProfileViewControllerRequest(
                                currentUser: currentUser,
                                connectedUser: connectedUser
                            )
                            let viewController = self.route.makeConnectProfileViewController(request: request)
                            self.present(viewController, animated: true, completion: nil)
                        } else {
                            MessageKit.hideLoadingView()
                        }
                    case .failure:
                        MessageKit.hideLoadingView()
                    }
                }
            }
        }
        MessageKit.showScanQRCodeView(withId: messageViewId, userId: currentUser.id, scanQRCodeAction: scanQRCodeAction)
    }
    
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapShowQRButton button: UIButton) {
        guard let currentUser = self.currentUser else { return }
        MessageKit.showQRCodeView(userId: currentUser.id)
    }
    
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapSignOutButton button: UIButton) {
        UserDefaultStorage.shared.setValue(nil, forKey: .currentUserId)
        AppDIContainer.shared.start(instructor: .auth)
    }
    
    
    
    
}

extension DashboardProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        MessageKit.showLoadingView()
        guard let image = info[.editedImage] as? UIImage else { return }
        if let jpegData = image.jpegData(compressionQuality: .leastNormalMagnitude) {
            guard var currentUser = self.currentUser else { return }
            currentUser.profileImage = UIImage(data: jpegData)
            self.useCase.saveUserUseCase().execute(.init(user: currentUser)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.currentUser = response.user
                        MessageKit.hideLoadingView()
                        MessageKit.showAlertMessageView(title: "Profile image has been updated.", type: .success)
                        picker.dismiss(animated: true, completion: nil)
                    }
                case .failure:
                    MessageKit.hideLoadingView()
                    MessageKit.showAlertMessageView(title: "Failed to update your profile image.", type: .failure)
                }
            }
        }
    }
    
}
