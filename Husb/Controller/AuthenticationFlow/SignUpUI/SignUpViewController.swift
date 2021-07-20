//
//  SignUpViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

struct SignUpViewControllerRequest {
    
}

protocol SignUpViewControllerRoute {
    
    
}

class SignUpViewController: UIViewController {
    
    private var route: SignUpViewControllerRoute!
    private var request: SignUpViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    // MARK: - SubViews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "Create an Account"
        return label
    }()
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.placeholder = "Username"
        textField.delegate = self
        return textField
    }()
    lazy var usernameWarningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .heartRed
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    lazy var fullnameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.placeholder = "Full Name"
        textField.delegate = self
        return textField
    }()
    lazy var fullnameWarningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .heartRed
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.delegate = self
        return textField
    }()
    lazy var emailWarningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .heartRed
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.delegate = self
        return textField
    }()
    lazy var passwordWarningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .heartRed
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.isSecureTextEntry = true
        textField.placeholder = "Confirm Password"
        textField.delegate = self
        return textField
    }()
    lazy var confirmPasswordWarningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .heartRed
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SignUpViewController.makeSignUpInputContainerView(with: self.fullnameTextField, warningLabel: self.fullnameWarningLabel),
            SignUpViewController.makeSignUpInputContainerView(with: self.usernameTextField, warningLabel: self.usernameWarningLabel),
            SignUpViewController.makeSignUpInputContainerView(with: self.emailTextField, warningLabel: self.emailWarningLabel),
            SignUpViewController.makeSignUpInputContainerView(with: self.passwordTextField, warningLabel: self.passwordWarningLabel),
            SignUpViewController.makeSignUpInputContainerView(with: self.confirmPasswordTextField, warningLabel: self.confirmPasswordWarningLabel),
        ])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.ghostWhite, for: .normal)
        button.backgroundColor = .spaceGrey
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        button.isEnabled = false
        button.addTarget(self, action: #selector(self.onSignUpButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    lazy var hubbyOption: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.seaBlue.cgColor
        view.backgroundColor = .ghostWhite
        view.layer.cornerRadius = 10
        view.tag = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onRoleOptionDidTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        let imageView = UIImageView(image: .hubbyIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let titleLabel = UILabel()
        titleLabel.text = "Hubby"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.6
        titleLabel.textColor = .jetBlack
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(imageView.snp.width)
            make.bottom.greaterThanOrEqualTo(titleLabel.snp.top).offset(-10)
        }
        
        return view
    }()
    lazy var wifeyOption: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.spaceGrey.cgColor
        view.backgroundColor = .ghostWhite
        view.layer.cornerRadius = 10
        view.tag = 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onRoleOptionDidTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        let imageView = UIImageView(image: .wifeyIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let titleLabel = UILabel()
        titleLabel.text = "Wifey"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.6
        titleLabel.textColor = .jetBlack
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(imageView.snp.width)
            make.bottom.greaterThanOrEqualTo(titleLabel.snp.top).offset(-10)
        }

        return view
    }()
    lazy var roleSelectionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.dropShadow()
        view.layer.cornerRadius = 15
        
        let titleLabel = UILabel()
        titleLabel.text = "Which one are you?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.6
        titleLabel.textColor = .jetBlack
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        view.addSubview(self.hubbyOption)
        view.addSubview(self.wifeyOption)
        
        self.hubbyOption.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(view.snp.width).dividedBy(2).offset(-15)
        }
        
        self.wifeyOption.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(view.snp.width).dividedBy(2).offset(-15)
        }
        
        return view
    }()
    
    private var fullNameIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var usernameIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var emailIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var passwordIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var confirmPasswordIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var fullName: String = "" {
        didSet {
            self.validateFullName()
        }
    }
    private var username: String = "" {
        didSet {
            self.validateUsername()
        }
    }
    private var email: String = ""
    private var password: String = "" {
        didSet {
            self.validatePassword()
        }
    }
    private var confirmPassword: String = ""
    private var selectedRole: RoleDomain.RoleType = .hubby {
        didSet {
            self.validateSelectedRole()
        }
    }

    
    static func create(
        route: SignUpViewControllerRoute,
        request: SignUpViewControllerRequest,
        useCase: UseCaseFactory
    ) -> SignUpViewController {
        let viewController = SignUpViewController()
        viewController.route = route
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
        self.activateTapViewEndEditingWithGesture()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableHero()
    }
}

private extension SignUpViewController {
    
    func setupViewDidLoad() {
        self.configureBackButton(with: .chevronLeft)
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.inputStackView)
        self.view.addSubview(self.signUpButton)
        self.view.addSubview(self.roleSelectionContainerView)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(55)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(25)
        }
        self.inputStackView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.greaterThanOrEqualTo(self.roleSelectionContainerView.snp.top).offset(-25)
        }
        self.signUpButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-25)
        }
        self.roleSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.inputStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.signUpButton.snp.top).offset(-20)
        }
    }
    
    func fetchUser(
        username: String,
        completion: @escaping(UserDomain?)->Void
    ) {
        self.useCase
            .fetchUserUseCase()
            .execute(
                .init(parameter: .auth(username: username)
            )) { result in
                switch result {
                case .success(let response):
                    completion(response.user)
                case .failure:
                    completion(nil)
                }
            }
    }
    
    @objc
    func onRoleOptionDidTap(_ sender: UITapGestureRecognizer) {
        guard let selectedView = sender.view else { return }
        if selectedView == self.hubbyOption {
            self.selectedRole = .hubby
        } else if selectedView == self.wifeyOption {
            self.selectedRole = .wife
        }
    }
    
    @objc
    func onSignUpButtonDidTap(_ sender: UIButton) {
        MessageKit.showLoadingView()
        let newUser = UserDomain(
            id: UUID().uuidString,
            username: self.username,
            email: self.email,
            name: self.fullName,
            role: RoleDomain(type: self.selectedRole),
            connectedUserId: nil,
            challenges: [],
            profileImage: nil,
            password: self.password
        )
        let request = SaveUserUseCaseRequest(user: newUser)
        self.useCase.saveUserUseCase().execute(request) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    MessageKit.hideLoadingView()
                    AppDIContainer.shared.start(instructor: .mainApp)
                }
            case .failure:
                MessageKit.hideLoadingView()
                break
            }
            
        }
    }
    
}



extension SignUpViewController {
    
    static func makeSignUpInputContainerView(with textField: UITextField, warningLabel: UILabel) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
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
        
        view.addSubview(textFieldContainerView)
        view.addSubview(warningLabel)
        textFieldContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldContainerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width*0.13)
        }
        
        return view
    }
    
}

// MARK: - SignUpViewController+UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let previousText:NSString = textField.text! as NSString
        let updatedText = previousText.replacingCharacters(in: range, with: string)
        if textField == self.fullnameTextField {
            self.fullName = updatedText
        } else if textField == self.usernameTextField {
            self.username = updatedText
        } else if textField == self.emailTextField {
            self.email = updatedText
        } else if textField == self.passwordTextField {
            self.password = updatedText
        } else if textField == self.confirmPasswordTextField {
            self.confirmPassword = updatedText
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.usernameTextField, self.usernameIsValid {
            self.validateUsernameOnDoneEditing()
        } else if textField == self.emailTextField {
            self.validateEmail()
        } else if textField == self.confirmPasswordTextField {
            self.validateConfirmPassword()
        }
    }
    
}


// MARK: - Input Validations
private extension SignUpViewController {
    
    func validateFullName() {
        if !self.fullName.isLength(minimum: 5, maximum: 150) {
            self.fullnameWarningLabel.text = "Name should atleast have 5 characters."
            self.fullNameIsValid = false
        } else {
            self.fullnameWarningLabel.text = nil
            self.fullNameIsValid = true
        }
    }
    
    func validateSelectedRole() {
        switch self.selectedRole {
        case .hubby:
            self.wifeyOption.layer.borderColor = UIColor.spaceGrey.cgColor
            self.wifeyOption.setNeedsLayout()
            self.wifeyOption.layoutIfNeeded()
            self.hubbyOption.layer.borderColor = UIColor.seaBlue.cgColor
            self.hubbyOption.setNeedsLayout()
            self.hubbyOption.layoutIfNeeded()
        case .wife:
            self.wifeyOption.layer.borderColor = UIColor.seaBlue.cgColor
            self.wifeyOption.setNeedsLayout()
            self.wifeyOption.layoutIfNeeded()
            self.hubbyOption.layer.borderColor = UIColor.spaceGrey.cgColor
            self.hubbyOption.setNeedsLayout()
            self.hubbyOption.layoutIfNeeded()
        default:
            break
        }
    }
    
    
    func validateUsername() {
        if !self.username.isLength(minimum: 5, maximum: 150) {
            self.usernameWarningLabel.text = "Username should atleast have 5 characters."
            self.usernameIsValid = false
        } else if self.username.contains([.whiteSpace]) {
            self.usernameWarningLabel.text = "Username should not contain whitespaces."
            self.usernameIsValid = false
        } else {
            self.usernameWarningLabel.text = nil
            self.usernameIsValid = true
        }
    }
    
    func validateEmail() {
        if !self.email.isEmail() {
            self.emailWarningLabel.text = "Invalid email address."
            self.emailIsValid = false
        } else {
            self.emailWarningLabel.text = nil
            self.emailIsValid = true
        }
    }
    
    func validatePassword() {
        if !self.password.isLength(minimum: 6, maximum: 100) {
            self.passwordWarningLabel.text = "Password should atleast have 6 characters."
            self.passwordIsValid = false
        } else if self.password.contains([.whiteSpace]) {
            self.passwordWarningLabel.text = "Password should not contain whitespaces."
            self.passwordIsValid = false
        } else if !self.password.contains([.lowercaseLetter,.uppercaseLetter,.number]) {
            self.passwordWarningLabel.text = "Password should contain capital letters and numbers."
            self.passwordIsValid = false
        } else {
            self.passwordWarningLabel.text = nil
            self.passwordIsValid = true
        }
    }
    
    func validateConfirmPassword() {
        if self.password != self.confirmPassword {
            self.confirmPasswordWarningLabel.text = "Confirmation password doen't match."
            self.confirmPasswordIsValid = false
        } else {
            self.confirmPasswordWarningLabel.text = nil
            self.confirmPasswordIsValid = true
        }
    }
    
    func validateFormInput() {
        if self.fullNameIsValid && self.usernameIsValid && self.emailIsValid && self.passwordIsValid && self.confirmPasswordIsValid {
            self.signUpButton.isEnabled = true
            self.signUpButton.backgroundColor = .seaBlue
        } else {
            self.signUpButton.isEnabled = false
            self.signUpButton.backgroundColor = .spaceGrey
        }
    }
    
    
    func validateUsernameOnDoneEditing() {
        MessageKit.showLoadingView()
        self.fetchUser(username: self.usernameTextField.text ?? "") { result in
            DispatchQueue.main.async {
                if result != nil {
                    self.usernameWarningLabel.text = "Username already exist"
                    self.usernameWarningLabel.textColor = .heartRed
                    self.usernameIsValid = false
                    MessageKit.hideLoadingView()
                } else {
                    self.usernameWarningLabel.text = nil
                    self.usernameIsValid = true
                    MessageKit.hideLoadingView()
                }
            }
        }
    }
}
