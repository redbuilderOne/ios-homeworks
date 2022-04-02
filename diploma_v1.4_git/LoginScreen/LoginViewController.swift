
import UIKit

class LoginViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let vkLogoImageView = UIImageView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let logInButton = UIButton()

    let messageLabel = UILabel()
    private let minLenght = 6
    private lazy var regularExpressions = "^(?=.*[а-я])(?=.*[А-Я])(?=.*\\d)(?=.*[$@$!%*?&#])[А-Яа-я\\d$@$!%*?&#]{\(minLenght),}$"
    private let password = "АБаб$12"

    let emailValidationMessageLabel = UILabel()
    let emailValidationText = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z.]{2,64}"

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vkLogoImageView)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)
        contentView.addSubview(messageLabel)
        contentView.addSubview(emailValidationMessageLabel)

        configureMessageLabel()
        configureEmailValidationMessageLabel()
        setupScrollView()
        configureVKLogoImageView()
        configureEmailTextField()
        configurePasswordTextField()
        configureLogInButton()
        configureTapGesture()
        fingerTap()
        registerForKeyboardNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }

    //MARK: - Email Validation
    private func isValidEmail(emailID: String) -> Bool {
        let emailRegEx = emailValidationText
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }

    // MARK: - Keyboard Moves
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func onKeyboardAppear(_ notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let contentOffset: CGPoint = notification.name == UIResponder.keyboardWillHideNotification ? .zero : CGPoint(x: 0, y: keyboardHeight)

            self.scrollView.setContentOffset(contentOffset, animated: true)
        }
    }

    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    // MARK: - View Configuration
    private func configureEmailValidationMessageLabel() {
        emailValidationMessageLabel.isHidden = true
        emailValidationMessageLabel.textColor = .red
        emailValidationMessageLabel.numberOfLines = 0
        emailValidationMessageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        emailValidationMessageLabel.anchor(top: emailTextField.topAnchor,
                                           left: contentView.leftAnchor,
                                           right: contentView.rightAnchor,
                                           paddingTop: 0,
                                           paddingLeft: 16,
                                           paddingRight: 16,
                                           height: 50)
    }


    private func configureMessageLabel() {
        messageLabel.isHidden = true
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        messageLabel.anchor(top: passwordTextField.topAnchor,
                            left: contentView.leftAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 16,
                            paddingRight: 16,
                            height: 50)
        // paddingTop: 12 - сделал специально в центре чтобы лучше смотрелось
    }

    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            vkLogoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogoImageView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            emailTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: vkLogoImageView.bottomAnchor, constant: 120),
            passwordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            logInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInButton.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 48)
        ])

        vkLogoImageView.anchor(width: 100, height: 100)

        emailTextField.anchor(left: contentView.leftAnchor,
                              right: contentView.rightAnchor,
                              paddingLeft: 16,
                              paddingRight: 16,
                              height: 50)

        passwordTextField.anchor(left: contentView.leftAnchor,
                                 right: contentView.rightAnchor,
                                 paddingLeft: 16,
                                 paddingRight: 16,
                                 height: 50)

        logInButton.anchor(left: emailTextField.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: emailTextField.rightAnchor,
                           paddingBottom: 270,
                           height: 50)
    }

    private func configureVKLogoImageView() {
        vkLogoImageView.image = ProfileImages.vkLogo
    }

    private func configureEmailTextField() {
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = CGColor(red: 211, green: 211, blue: 211, alpha: 100)
        emailTextField.textColor = .black
        emailTextField.font = .systemFont(ofSize: 16)
        emailTextField.backgroundColor = .systemGray6
        emailTextField.tintColor = .tintColor
        emailTextField.autocapitalizationType = .none
        emailTextField.text = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.delegate = self
    }

    private func configurePasswordTextField() {
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = CGColor(red: 211, green: 211, blue: 211, alpha: 100)
        passwordTextField.textColor = .black
        passwordTextField.font = .systemFont(ofSize: 16)
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.tintColor = .tintColor
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = "Password"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self

        passwordTextField.addTarget(self, action: #selector(passwordTextFieldTapped), for: .touchUpInside)
    }

    // MARK: - Buttons Configuration
    @objc func passwordTextFieldTapped() {
        passwordTextField.returnKeyType = .done
        passwordTextField.autocorrectionType = .no
    }

    private func configureLogInButton() {
        logInButton.layer.cornerRadius = 10
        logInButton.setTitle("Log in", for: .normal)
        logInButton.configuration?.image = UIImage(systemName: "blue_pixel")
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }

    // MARK: - Login Button
    @objc func logInButtonPressed() {
        lazy var profileVC = ProfileVC()

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = emailTextField.text ?? ""
            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else { return false }
            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            // make sure the result is under 16 characters
            return updatedText.count <= 16
        }

        // if the textField is empty
        guard let usersLogin = emailTextField.text, !usersLogin.isEmpty else {
            print("Ошибка - отсутствует или введен неправильно email")
            lazy var emailTextFieldReAnimation = UIViewPropertyAnimator(duration:0.5, curve: .easeIn) {
                self.emailTextField.backgroundColor = .systemGray6
                self.emailTextField.layer.opacity = 1
            }

            UIView.animate(withDuration: 0.5, animations: {
                self.emailTextField.backgroundColor = .systemRed
                self.emailTextField.layer.opacity = 0.8
            }) { (isFinished) in
                emailTextFieldReAnimation.startAnimation(afterDelay: 0.5)
            }
            return
        }

        guard let usersPassword = passwordTextField.text, !usersPassword.isEmpty else {
            print("Ошибка - отсутствует или введен неправильно password")
            lazy var passwordTextFieldReAnimation = UIViewPropertyAnimator(duration:0.5, curve: .easeIn) {
                self.passwordTextField.backgroundColor = .systemGray6
                self.passwordTextField.layer.opacity = 1
            }

            UIView.animate(withDuration: 0.5, animations: {
                self.passwordTextField.backgroundColor = .systemRed
                self.passwordTextField.layer.opacity = 0.8
            }) { (isFinished) in
                passwordTextFieldReAnimation.startAnimation(afterDelay: 0.5)
            }
            return
        }

        guard let email = emailTextField.text else {
            return
        }

        if isValidEmail(emailID: email) == false {
            self.emailTextField.text = ""
            self.emailValidationMessageLabel.isHidden = false
            self.emailValidationMessageLabel.text = "Укажите валидный email"
            return
        }

        if emailTextField.text != "admin@admin.com" {
            Alert.showLoginAlert(on: self, with: "Ошибка", message: "Email введен неверно")
            return
        }

        if passwordTextField.text != "admin" {
            Alert.showLoginAlert(on: self, with: "Ошибка", message: "Пароль введен неверно")
            return
        }

        self.show(profileVC, sender: self)
        print("Переход на страницу профиля (profileVC)")
        contentView.endEditing(true)
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
        contentView.addGestureRecognizer(tapGesture)
    }

    @objc func fingerTap() {
        print("fingerTap was called")
        emailValidationMessageLabel.isHidden = true
        emailValidationMessageLabel.text = ""
        emailTextField.text = "Email"
        passwordTextField.text = "Password"
        messageLabel.isHidden = true
        messageLabel.text = ""
        contentView.endEditing(true)
    }

    private func checkValidation(password: String) {
        guard password.count >= minLenght else {
            messageLabel.text = ""
            return
        }

        if password.match(regularExpressions) {
            // если успешно
            messageLabel.textColor = .green
            messageLabel.text = "Символы указаны верно"
        } else {
            // иначе
            messageLabel.isHidden = false
            messageLabel.textColor = .red
            messageLabel.text = "Минимум \(self.minLenght) символов"
        }
    }
}

// MARK: - LoginViewController Extension
// расширение чтобы ".delegate = self" сработал
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        let isSuccess = (textField.text == password)
        messageLabel.textColor = isSuccess ? .green : .red
        messageLabel.text = isSuccess ? "Success" : "Error"
        textField.resignFirstResponder()
        return true
    }
    
    private func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") + string
        let res: String

        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count-1)
            res = String(text[text.startIndex..<end])
        } else {
            res = text
        }

        checkValidation(password: res)
        textField.text = res
        return false
    }
}

// MARK: - Password Validation
extension String {
    //ПРОВЕРКА НА СООТВЕТСТВИЕ
    func match(_ regularExpressions: String) -> Bool {
        return self.range(of: regularExpressions, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
