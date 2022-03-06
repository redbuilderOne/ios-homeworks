//
//  LoginViewController.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 02.03.2022.
//

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
        contentView.addSubview(emailTextField)
        contentView.addSubview(logInButton)

        setupScrollView()
        configureVKLogoImageView()
        configureEmailTextField()
        configurePasswordTextField()
        configureLogInButton()
    }

    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    private func configureVKLogoImageView() {
        vkLogoImageView.clipsToBounds = true
        vkLogoImageView.image = ProfileImages.vkLogo
        vkLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        vkLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        vkLogoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               paddingTop: 120,
                               width: 100,
                               height: 100)
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
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.clipsToBounds = true

        emailTextField.anchor(top: vkLogoImageView.topAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: 220,
                              paddingLeft: 16,
                              paddingRight: 16,
                              height: 50)

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
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.clipsToBounds = true

        passwordTextField.anchor(top: vkLogoImageView.topAnchor,
                                 left: emailTextField.leftAnchor,
                                 right: emailTextField.rightAnchor,
                                 paddingTop: 271,
                                 height: 50)

        passwordTextField.delegate = self
    }

    private func configureLogInButton() {
        logInButton.layer.cornerRadius = 10
        logInButton.setTitle("Log in", for: .normal)
        logInButton.configuration?.image = UIImage(systemName: "blue_pixel")
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)

        logInButton.clipsToBounds = true

        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)

        // logInButton.configuration = .tinted()
        // logInButton.configuration?.title = title

        logInButton.anchor(top: passwordTextField.topAnchor,
                           left: emailTextField.leftAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           right: emailTextField.rightAnchor,
                           paddingTop: 62,
                           paddingLeft: 0,
                           paddingRight: 0,
                           paddingBottom: 270,
                           height: 50)
    }

    @objc func logInButtonPressed() {
        lazy var profileVC = ProfileVC()
        self.show(profileVC, sender: self)
        print("Переход на страницу профиля (profileVC)")
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
        scrollView.addGestureRecognizer(tapGesture)
    }

    @objc func fingerTap() {
        print("fingerTap was called")
        // при нажатии пальем в пустое поле экрана завершается редактирование текста self.endEditing(true)
        scrollView.endEditing(true)
    }

}



// расширение чтобы ".delegate = self" сработал
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // resign = dismiss
        textField.resignFirstResponder()
        return true
    }
}
