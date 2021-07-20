//
//  CalendarDateCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 09/07/21.
//

import UIKit

class CalendarDateCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: CalendarDateCollectionCell.self)
    
    private var date: Date!
    
    // MARK: - SubViews
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .jetBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    lazy var activityIndicatorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.completedChallengeIndicator,self.uncompletedChallengeIndicator])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        return stackView
    }()
    lazy var completedChallengeIndicator: UIView = {
        let view = UIView()
        let size: CGFloat = 12
        view.snp.makeConstraints { make in
            make.width.height.equalTo(size)
        }
        view.layer.cornerRadius = size/2
        view.backgroundColor = .seaBlue
        view.isHidden = true
        return view
    }()
    lazy var uncompletedChallengeIndicator: UIView = {
        let view = UIView()
        let size: CGFloat = 12
        view.snp.makeConstraints { make in
            make.width.height.equalTo(size)
        }
        view.layer.cornerRadius = size/2
        view.backgroundColor = .heartRed
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 10
        self.dropShadow(withColor: .spaceGrey, opacity: 1, offset: .init(width: 3, height: 3))
        self.backgroundColor = .pearlWhite
        
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.activityIndicatorStackView)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        self.activityIndicatorStackView.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    
    override func prepareForReuse() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.dateLabel.text = ""
        self.completedChallengeIndicator.isHidden = true
        self.uncompletedChallengeIndicator.isHidden = true
    }
    
    func fill(with date: Date, challenges: [ChallengeDomain], isSelected: Bool) {
        self.date = date
        self.dateLabel.text = date.getString(withFormat: "d")
        if isSelected {
            self.dateLabel.textColor = .seaBlue
        } else {
            self.dateLabel.textColor = .jetBlack
        }
        if Calendar.current.isDate(date, inSameDayAs: Date()) {
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.skyBlue.cgColor
        }
        
        let todayChallenges = challenges.filter { challenge in
            guard let dueDate = challenge.dueDate else { return false }
            return Calendar.current.isDate(dueDate, inSameDayAs: date)
        }
        
        if !todayChallenges.isEmpty {
            if !todayChallenges.filter({$0.isCompleted}).isEmpty {
                self.completedChallengeIndicator.isHidden = false
            }
            
            if !todayChallenges.filter({!$0.isCompleted}).isEmpty {
                self.uncompletedChallengeIndicator.isHidden = false
            }
        }
    }
    
}
