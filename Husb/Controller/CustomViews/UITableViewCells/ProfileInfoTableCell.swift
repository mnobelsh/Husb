//
//  ProfileQRSettingTableCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

protocol ProfileInfoTableCellDelegate: AnyObject {
    
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapProfileImageView imageView: UIImageView)
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didLongPressProfileImageView imageView: UIImageView)
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapShowQRButton button: UIButton)
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapScanQRButton button: UIButton)
    func profileInfoTableCell(_ cell: ProfileInfoTableCell, didTapSignOutButton button: UIButton)
    
}

class ProfileInfoTableCell: UITableViewCell {
    
    static let height: CGFloat = UIScreen.main.bounds.height * 0.77
    
    static let identifier: String = String(describing: ProfileInfoTableCell.self)
    
    weak var delegate: ProfileInfoTableCellDelegate?

    // MARK: - SubViews
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.dropShadow()
        imageView.backgroundColor = .pearlWhite
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onProfileImageViewDidTap(_:)))
        imageView.addGestureRecognizer(tapGesture)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.onProfileImageViewDidLongPress(_:)))
        imageView.addGestureRecognizer(longPressGesture)
        return imageView
    }()
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.isEnabled = false
        return textField
    }()
    lazy var fullnameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.isEnabled = false
        return textField
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.isEnabled = false
        return textField
    }()
    lazy var connectedUserTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "You haven't been connected"
        textField.textColor = .darkGray
        textField.isEnabled = false
        return textField
    }()
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.pearlWhite, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .heartRed
        button.layer.cornerRadius = 10
        button.dropShadow()
        button.addTarget(self, action: #selector(self.onSignOutButtonTouchUpInside(_:)), for: .touchUpInside)
        return button
    }()
    lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                ProfileInfoTableCell.makeUserInfoCellView(title: "Username", with: self.usernameTextField),
                ProfileInfoTableCell.makeUserInfoCellView(title: "Name", with: self.fullnameTextField),
                ProfileInfoTableCell.makeUserInfoCellView(title: "Email", with: self.emailTextField),
                ProfileInfoTableCell.makeUserInfoCellView(title: "Connected with", with: self.connectedUserTextField)
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    lazy var showMyQRButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show My QR", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .skyBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.onShowMyQRCodeButtonTouchUpInside(_:)), for: .touchUpInside)
        button.dropShadow()
        return button
    }()
    lazy var scanQRButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scan QR", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .funYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.onScanQRCodeButtonTouchUpInside(_:)), for: .touchUpInside)
        button.dropShadow()
        return button
    }()
    lazy var qrButtonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.scanQRButton,
                self.showMyQRButton
            ]
        )
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .ghostWhite
        self.contentView.addSubview(self.profileImageView)
        self.contentView.addSubview(self.userInfoStackView)
        self.contentView.addSubview(self.signOutButton)
        self.contentView.addSubview(self.qrButtonStackView)

        self.profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(145)
        }
        self.qrButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(55)
        }
        self.userInfoStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalTo(self.qrButtonStackView.snp.bottom).offset(35)
            make.bottom.equalTo(self.signOutButton.snp.top).offset(-20)
        }
        self.signOutButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-10)
        }

        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    @objc
    private func onProfileImageViewDidTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.profileInfoTableCell(self, didTapProfileImageView: self.profileImageView)
    }
    
    @objc
    private func onProfileImageViewDidLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            self.delegate?.profileInfoTableCell(self, didLongPressProfileImageView: self.profileImageView)
        }
    }
    
    @objc
    private func onScanQRCodeButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.profileInfoTableCell(self, didTapScanQRButton: self.scanQRButton)
    }
    
    @objc
    private func onShowMyQRCodeButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.profileInfoTableCell(self, didTapShowQRButton: self.showMyQRButton)
    }
    
    @objc
    private func onSignOutButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.profileInfoTableCell(self, didTapSignOutButton: self.signOutButton)
    }
    
    
    func fill(user: UserDomain, connectedUser: UserDomain?) {
        self.connectedUserTextField.text = connectedUser?.name
        self.emailTextField.text = user.email
        self.fullnameTextField.text = user.name
        self.usernameTextField.text = user.username
        if let profileImage = user.profileImage {
            self.profileImageView.image = profileImage
        } else {
            switch user.role.type {
            case .hubby:
                self.profileImageView.image = .hubbyIcon
            case .wife:
                self.profileImageView.image = .wifeyIcon
            default:
                break
            }
        }
    }
    
}

extension ProfileInfoTableCell {
    
    static func makeUserInfoCellView(title: String, with textField: UITextField) -> UIView {
        let view = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .jetBlack
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let textFieldContainerView = UIView()
        textFieldContainerView.backgroundColor = .pearlWhite
        textFieldContainerView.dropShadow()
        textFieldContainerView.layer.cornerRadius = 6
        textFieldContainerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }

        view.addSubview(titleLabel)
        view.addSubview(textFieldContainerView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        textFieldContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        return view
    }
    
}
