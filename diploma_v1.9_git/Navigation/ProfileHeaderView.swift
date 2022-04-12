
import UIKit

class ProfileHeaderView: UIView {

    static var profileImageView = UIImageView()
    static var profileLabel = UILabel()
    static var statusLabel = UILabel()
    static var showStatusButton = StatusButton(color: .blue, title: "Show status")
    static var textField = UITextField()

    private var statusText = String()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(ProfileHeaderView.profileImageView)
        addSubview(ProfileHeaderView.showStatusButton)
        addSubview(ProfileHeaderView.profileLabel)
        addSubview(ProfileHeaderView.statusLabel)
        addSubview(ProfileHeaderView.textField)

        configureProfileImageView()
        configureShowStatusButton()
        configureProfileLabel()
        configureStatusLabel()
        configureTextField()

        ProfileHeaderView.textField.isHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -LAYOUT
    override func layoutSubviews() {
        super.layoutSubviews()

        ProfileHeaderView.profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                                  left: safeAreaLayoutGuide.leftAnchor,
                                                  paddingTop: 16,
                                                  paddingLeft: 16,
                                                  width: 150,
                                                  height: 150)

        ProfileHeaderView.showStatusButton.anchor(top: ProfileHeaderView.profileImageView.topAnchor,
                                                  left: safeAreaLayoutGuide.leftAnchor,
                                                  bottom: safeAreaLayoutGuide.bottomAnchor,
                                                  right: safeAreaLayoutGuide.rightAnchor,
                                                  paddingTop: 180,
                                                  paddingLeft: 16,
                                                  paddingRight: 16,
                                                  paddingBottom: 980,
                                                  width: 150,
                                                  height: 50)

        ProfileHeaderView.showStatusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        ProfileHeaderView.statusLabel.anchor(top: ProfileHeaderView.profileLabel.topAnchor,
                                             left: ProfileHeaderView.profileImageView.leftAnchor,
                                             bottom: ProfileHeaderView.showStatusButton.bottomAnchor,
                                             right: safeAreaLayoutGuide.rightAnchor,
                                             paddingTop: 80,
                                             paddingLeft: 160,
                                             paddingRight: 16,
                                             paddingBottom: 80,
                                             width: 150,
                                             height: 50)

        ProfileHeaderView.statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        ProfileHeaderView.profileLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                                              left: ProfileHeaderView.profileImageView.leftAnchor,
                                              right: safeAreaLayoutGuide.rightAnchor,
                                              paddingTop: 16,
                                              paddingLeft: 160,
                                              paddingRight: 16,
                                              width: 150,
                                              height: 50)

        ProfileHeaderView.textField.anchor(top: ProfileHeaderView.statusLabel.topAnchor,
                                           left: ProfileHeaderView.statusLabel.leftAnchor,
                                           bottom: ProfileHeaderView.showStatusButton.bottomAnchor,
                                           right: safeAreaLayoutGuide.rightAnchor,
                                           paddingTop: 50,
                                           paddingRight: 16,
                                           paddingBottom: 60,
                                           width: 100,
                                           height: 40)
    }

    // MARK: -CONFIG
    private func configureProfileImageView() {
        ProfileHeaderView.profileImageView.layer.cornerRadius = 72
        ProfileHeaderView.profileImageView.layer.borderWidth = 3
        ProfileHeaderView.profileImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 100)
        ProfileHeaderView.profileImageView.clipsToBounds = true
        ProfileHeaderView.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        ProfileHeaderView.profileImageView.image = ProfileImages.profileImg
    }

    @objc func buttonPressed() {
        print("\(ProfileHeaderView.statusLabel.text!)")
        ProfileHeaderView.showStatusButton.configuration?.title = "Set status"
        ProfileHeaderView.showStatusButton.configuration?.baseForegroundColor = .white
        ProfileHeaderView.showStatusButton.configuration?.baseBackgroundColor = .black
        ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(secondButtonPress), for: .touchUpInside)
        if isEmptyStatus() == false {
            return
        } else {
            ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(secondButtonPress), for: .touchUpInside)
        }
    }

    //MARK: -STATUS CHECK
    private func isEmptyStatus() -> Bool {
        if ProfileHeaderView.textField.text == "" {
            print("Status is nil")
            ProfileHeaderView.textField.backgroundColor = .systemPink
            lazy var statusTextFieldReAnimation = UIViewPropertyAnimator(duration:0.5, curve: .easeIn) {
                ProfileHeaderView.textField.backgroundColor = .systemGray6
                ProfileHeaderView.textField.layer.opacity = 1
            }

            UIView.animate(withDuration: 0.5, animations: {
                ProfileHeaderView.textField.backgroundColor = .systemRed
                ProfileHeaderView.textField.layer.opacity = 0.8
            }) { (isFinished) in
                statusTextFieldReAnimation.startAnimation(afterDelay: 0.5)
            }
            return false
        }
        return true
    }

    @objc func secondButtonPress() {
        ProfileHeaderView.statusLabel.text = statusText
        ProfileHeaderView.showStatusButton.configuration?.title = "Show status"
        ProfileHeaderView.showStatusButton.configuration?.baseForegroundColor = .white
        ProfileHeaderView.showStatusButton.configuration?.baseBackgroundColor = .black
        ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        ProfileHeaderView.textField.endEditing(true)
        if isEmptyStatus() == false {
            return
        } else {
            ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    }

    private func configureShowStatusButton() {
        ProfileHeaderView.showStatusButton.backgroundColor = .blue
        ProfileHeaderView.showStatusButton.titleLabel?.textColor = .white
        ProfileHeaderView.showStatusButton.layer.cornerRadius = 4
        ProfileHeaderView.showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        ProfileHeaderView.showStatusButton.layer.shadowRadius = 4
        ProfileHeaderView.showStatusButton.layer.shadowOpacity = 0.7
        ProfileHeaderView.showStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
        ProfileHeaderView.showStatusButton.clipsToBounds = true
        ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    private func configureProfileLabel() {
        ProfileHeaderView.profileLabel.text = "Dima Skvortsov"
        ProfileHeaderView.profileLabel.font = .boldSystemFont(ofSize: 18)
        ProfileHeaderView.profileLabel.textColor = .black
        ProfileHeaderView.profileLabel.clipsToBounds = true
        ProfileHeaderView.profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ProfileHeaderView.profileLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureTextField() {
        ProfileHeaderView.textField.font = .systemFont(ofSize: 15)
        ProfileHeaderView.textField.textColor = .black
        ProfileHeaderView.textField.backgroundColor = .white
        ProfileHeaderView.textField.layer.borderWidth = 1
        ProfileHeaderView.textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
        ProfileHeaderView.textField.layer.cornerRadius = 12
        ProfileHeaderView.textField.translatesAutoresizingMaskIntoConstraints = false
        ProfileHeaderView.textField.clipsToBounds = true
        ProfileHeaderView.textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ProfileHeaderView.textField.addTarget(self, action: #selector(textFieldTapped), for: .touchUpInside)
        ProfileHeaderView.textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        // чтобы доставать и убирать клавиатуру + нужен протокол UITextFieldDelegate в расширении
        ProfileHeaderView.textField.delegate = self
    }

    @objc func textFieldTapped() {
        ProfileHeaderView.textField.returnKeyType = .done
        ProfileHeaderView.textField.autocapitalizationType = .words
        ProfileHeaderView.textField.autocorrectionType = .yes
    }

    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func statusTextChanged(_ textField: UITextField) -> String {
        let newTextTyped = textField.text
        if let newTextTyped = newTextTyped {
            statusText = newTextTyped
        } else {
            print("Ошибка, нет статуса")
        }
        return statusText
    }

    @objc func fingerTap() {
        print("fingerTap was called")
        // при нажатии пальем в пустое поле экрана завершается редактирование текста self.endEditing(true)
        self.endEditing(true)
    }

    private func configureStatusLabel() {
        ProfileHeaderView.statusLabel.text = "Learning Swift..."
        ProfileHeaderView.statusLabel.font = .systemFont(ofSize: 14)
        ProfileHeaderView.statusLabel.textColor = .gray
        ProfileHeaderView.statusLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

struct ProfileImages {
    static let profileImg = UIImage(named: "avatar-square")!
    static let vkLogo = UIImage(named: "logo")!
}

extension UIView {

    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    // для расположения элементов - here nil means "we dont always need that param"
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0,
                paddingRight: CGFloat? = 0,
                paddingBottom: CGFloat? = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }

        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// расширение чтобы "textField.delegate = self" сработал
extension ProfileHeaderView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // resign = dismiss
        textField.resignFirstResponder()
        return true
    }
}
