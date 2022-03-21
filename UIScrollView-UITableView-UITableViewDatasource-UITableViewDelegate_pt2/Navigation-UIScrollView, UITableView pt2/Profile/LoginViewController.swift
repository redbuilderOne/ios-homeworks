
import UIKit

class LoginViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    let vkLogoImageView = UIImageView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let logInButton = UIButton()

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vkLogoImageView)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)

        setupScrollView()
        configureVKLogoImageView()
        configureEmailTextField()
        configurePasswordTextField()
        configureLogInButton()
        configureTapGesture()
        fingerTap()
        registerForKeyboardNotifications()
    }

    // MARK: - Keyboard Appears

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func onKeyboardAppear(_ notification: NSNotification) {
        let info = notification.userInfo!
        let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let kbSize = rect.size

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets

        var aRect = self.view.frame;
        aRect.size.height -= kbSize.height;

        let activeField: UITextField? = [emailTextField, passwordTextField].first { $0.isFirstResponder }
        if let activeField = activeField {
            if !aRect.contains(activeField.frame.origin) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-kbSize.height)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }

    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

// MARK: - Setups

    func setupScrollView(){
        scrollView.alwaysBounceVertical = true
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
            emailTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        vkLogoImageView.anchor(top: contentView.topAnchor, paddingTop: 120, width: 100, height: 100)

        emailTextField.anchor(top: vkLogoImageView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 220, paddingLeft: 16, paddingRight: 16, height: 50)

        passwordTextField.anchor(top: vkLogoImageView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 272, paddingLeft: 16, paddingRight: 16, height: 50)

        logInButton.anchor(top: passwordTextField.topAnchor, left: emailTextField.leftAnchor, bottom: contentView.bottomAnchor, right: emailTextField.rightAnchor, paddingTop: 62, paddingBottom: 270, height: 50)
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
        emailTextField.text = "Email or phone"
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
        emailTextField.autocorrectionType = .no
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
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        passwordTextField.autocorrectionType = .no
    }

    private func configureLogInButton() {
        logInButton.layer.cornerRadius = 10
        logInButton.setTitle("Log in", for: .normal)
        logInButton.configuration?.image = UIImage(systemName: "blue_pixel")
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }

    @objc func logInButtonPressed() {
        lazy var profileVC = ProfileVC()
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
        contentView.endEditing(true)
    }
}

// MARK: - Extension for .delegate = self

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
