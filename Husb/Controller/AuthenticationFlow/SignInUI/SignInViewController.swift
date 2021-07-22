//
//  SignInViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

struct SignInViewControllerRequest {
    
}

protocol SignInViewControllerRoute {
    
    func showSignUpUI(
        navigationController: UINavigationController?,
        request: SignUpViewControllerRequest
    )
    
}

class SignInViewController: UIViewController {
    
    private var route: SignInViewControllerRoute!
    private var request: SignInViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    // MARK: - SubViews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Holla!\nGlad to see you again"
        return label
    }()
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.ghostWhite, for: .normal)
        button.backgroundColor = .spaceGrey
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        button.isEnabled = false
        button.addTarget(self, action: #selector(self.onSignInButtonTouchedUpInside(_:)), for: .touchUpInside)
        return button
    }()
    lazy var signInWarningLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .heartRed
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    lazy var signInImageView: UIImageView = {
        let imageView = UIImageView(image: .signInGreetings)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.placeholder = "Username"
        textField.delegate = self
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.delegate = self
        return textField
    }()
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SignInViewController.makeSignInInputContainerView(with: self.usernameTextField),
            SignInViewController.makeSignInInputContainerView(with: self.passwordTextField)
        ])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .clear
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        button.addTarget(
            self,
            action: #selector(self.onDontHaveAccountButtonTouchedUpInside(_:)),
            for: .touchUpInside
        )
        return button
    }()
    
    private var usernameIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var passwordIsValid = false {
        didSet {
            self.validateFormInput()
        }
    }
    private var username: String = "" {
        didSet {
            if !self.username.trimmingCharacters(in: .whitespaces).isEmpty && !self.username.isEmpty {
                self.usernameIsValid = true
            } else {
                self.usernameIsValid = false
            }
        }
    }
    private var password: String = "" {
        didSet {
            if !self.password.trimmingCharacters(in: .whitespaces).isEmpty && !self.password.isEmpty{
                self.passwordIsValid = true
            } else {
                self.passwordIsValid = false
            }
        }
    }
    
    static func create(
        route: SignInViewControllerRoute,
        request: SignInViewControllerRequest,
        useCase: UseCaseFactory
    ) -> SignInViewController {
        let viewController = SignInViewController()
        viewController.route = route
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.signInImageView)
        self.view.addSubview(self.signInButton)
        self.view.addSubview(self.signInWarningLabel)
        self.view.addSubview(self.inputStackView)
        self.view.addSubview(self.dontHaveAccountButton)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(55)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(75)
        }
        self.signInImageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(self.signInImageView.snp.width).multipliedBy(0.7)
        }
        self.signInButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.dontHaveAccountButton.snp.top).offset(-15)
        }
        self.signInWarningLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.signInButton.snp.top).offset(-20)
            make.height.equalTo(20)
        }
        self.inputStackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.signInImageView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.signInWarningLabel.snp.top).offset(-45)
        }
        self.dontHaveAccountButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
        }
    }
    

}

private extension SignInViewController {
    
    @objc
    func onSignInButtonTouchedUpInside(_ sender: UIButton) {
        MessageKit.showLoadingView()
        self.fetchUser()
    }
    
    @objc
    func onDontHaveAccountButtonTouchedUpInside(_ sender: UIButton) {
        let request = SignUpViewControllerRequest()
        self.route.showSignUpUI(navigationController: self.navigationController, request: request)
    }
    
    func fetchUser() {
        let request = FetchUserUseCaseRequest(
            parameter: .auth(username: self.username)
        )
        self.useCase.fetchUserUseCase().execute(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    if let user = response.user {
                        if self.password == user.password {
                            UserDefaultStorage.shared.setValue(user.id, forKey: .currentUserId)
                            AppDIContainer.shared.start(instructor: .mainApp)
                            MessageKit.hideLoadingView()
                        } else {
                            self.signInWarningLabel.text = "Invalid email address or password."
                            MessageKit.hideLoadingView()
                        }
                    } else {
                        self.signInWarningLabel.text = "User not found."
                        MessageKit.hideLoadingView()
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    MessageKit.hideLoadingView()
                    MessageKit.showAlertMessageView(title: "Failed to sign in, please check your internet connection", type: .failure)
                }
            }
        }
    }
    
    func validateFormInput() {
        if self.usernameIsValid && self.passwordIsValid {
            self.signInButton.isEnabled = true
            self.signInButton.backgroundColor = .seaBlue
        } else {
            self.signInButton.isEnabled = false
            self.signInButton.backgroundColor = .spaceGrey
        }
    }
    
}


extension SignInViewController {
    
    static func makeSignInInputContainerView(with textField: UITextField, warningLabel: UILabel? = nil) -> UIView {
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
        if let warningLabel = warningLabel {
            view.addSubview(warningLabel)
            textFieldContainerView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.7)
            }
            warningLabel.snp.makeConstraints { make in
                make.top.equalTo(textFieldContainerView.snp.bottom)
                make.bottom.leading.trailing.equalToSuperview()
            }
            
        } else {
            textFieldContainerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }

        view.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width*0.13)
        }
        return view
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        self.signInWarningLabel.text = nil
        let previousText:NSString = textField.text! as NSString
        let updatedText = previousText.replacingCharacters(in: range, with: string)
        if textField == self.usernameTextField {
            self.username = updatedText
        } else if textField == self.passwordTextField {
            self.password = updatedText
        } 
        return true
    }
    
}
