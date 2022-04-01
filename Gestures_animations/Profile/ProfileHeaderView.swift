
import UIKit

class ProfileHeaderView: UIView {

    static var profileImageView = UIImageView()
    static var profileLabel = UILabel()
    static var statusLabel = UILabel()
    static var showStatusButton = UIButton()
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
        configureShowStatusButton()

        ProfileHeaderView.textField.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setting constraints

    override func layoutSubviews() {
        super.layoutSubviews()

        setupProfileImgView()

        ProfileHeaderView.showStatusButton.anchor(top: ProfileHeaderView.statusLabel.bottomAnchor,
                                                  left: safeAreaLayoutGuide.leftAnchor,
                                                  bottom: ProfileVC.collectionView?.topAnchor,
                                                  right: safeAreaLayoutGuide.rightAnchor,
                                                  paddingTop: 34,
                                                  paddingLeft: 16,
                                                  paddingRight: 16,
                                                  paddingBottom: 16,
                                                  width: 150,
                                                  height: 50)

        ProfileHeaderView.showStatusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        ProfileHeaderView.statusLabel.anchor(top: ProfileHeaderView.profileLabel.topAnchor,
                                             left: ProfileHeaderView.profileLabel.leftAnchor,
                                             bottom: ProfileHeaderView.showStatusButton.topAnchor,
                                             right: safeAreaLayoutGuide.rightAnchor,
                                             paddingTop: 80,
                                             paddingLeft: 0,
                                             paddingRight: 0,
                                             paddingBottom: 34,
                                             width: 150,
                                             height: 50)

        ProfileHeaderView.statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func setupProfileImgView() {

        ProfileHeaderView.profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                                  left: safeAreaLayoutGuide.leftAnchor,
                                                  bottom: ProfileHeaderView.showStatusButton.topAnchor,
                                                  right: ProfileHeaderView.profileLabel.leftAnchor,
                                                  paddingTop: 16,
                                                  paddingLeft: 16,
                                                  paddingRight: 16,
                                                  paddingBottom: 16,
                                                  width: 150,
                                                  height: 150)

        let profileImgTopAnchor = ProfileHeaderView.profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        let profileImgLeftAnchor = ProfileHeaderView.profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16)
        let profileImgBottomAnchor = ProfileHeaderView.profileImageView.bottomAnchor.constraint(equalTo: ProfileHeaderView.showStatusButton.topAnchor, constant: 16)
        let profileImgRightAnchor = ProfileHeaderView.profileImageView.rightAnchor.constraint(equalTo: ProfileHeaderView.profileLabel.leftAnchor, constant: 16)

        NSLayoutConstraint.activate([
            profileImgTopAnchor, profileImgLeftAnchor, profileImgBottomAnchor, profileImgRightAnchor
        ])
    }

    func avatarTappedState2() {
        NSLayoutConstraint.activate([
            ProfileHeaderView.profileImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            ProfileHeaderView.profileImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            ProfileHeaderView.profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            ProfileHeaderView.profileImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        ProfileHeaderView.profileImageView.anchor(width: 150,
                                                  height: 150)
    }

    func configureShowStatusButton() {
        ProfileHeaderView.showStatusButton.layer.cornerRadius = 4
        ProfileHeaderView.showStatusButton.configuration = .tinted()
        ProfileHeaderView.showStatusButton.configuration?.title = "Show status"
        ProfileHeaderView.showStatusButton.backgroundColor = .blue
        ProfileHeaderView.showStatusButton.titleLabel?.textColor = .white
        ProfileHeaderView.showStatusButton.titleLabel?.shadowOffset = CGSize(width: 4, height: 4)
        ProfileHeaderView.showStatusButton.layer.shadowRadius = 4
        ProfileHeaderView.showStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
        ProfileHeaderView.showStatusButton.layer.shadowOpacity = 0.7
        ProfileHeaderView.showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        ProfileHeaderView.showStatusButton.clipsToBounds = true
        ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    private func configureProfileImageView() {
        ProfileHeaderView.profileImageView.layer.cornerRadius = 72
        ProfileHeaderView.profileImageView.layer.borderWidth = 3
        ProfileHeaderView.profileImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 100)
        ProfileHeaderView.profileImageView.clipsToBounds = true
        ProfileHeaderView.profileImageView.image = ProfileImages.profileImg
    }

    @objc func buttonPressed() {
        ProfileHeaderView.textField.isHidden = false
        print("\(ProfileHeaderView.statusLabel.text!)")
        ProfileHeaderView.showStatusButton.configuration?.title = "Set status"
        ProfileHeaderView.showStatusButton.configuration?.baseForegroundColor = .white
        ProfileHeaderView.showStatusButton.configuration?.baseBackgroundColor = .black
        ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(secondButtonPress), for: .touchUpInside)
    }

    @objc func secondButtonPress() {
        ProfileHeaderView.textField.isHidden = true
        ProfileHeaderView.statusLabel.text = statusText
        ProfileHeaderView.showStatusButton.configuration?.title = "Show status"
        ProfileHeaderView.showStatusButton.configuration?.baseForegroundColor = .white
        ProfileHeaderView.showStatusButton.configuration?.baseBackgroundColor = .black
        ProfileHeaderView.showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    private func configureProfileLabel() {
        ProfileHeaderView.profileLabel.text = "Dima Skvortsov"
        ProfileHeaderView.profileLabel.font = .boldSystemFont(ofSize: 18)
        ProfileHeaderView.profileLabel.textColor = .black
        ProfileHeaderView.profileLabel.translatesAutoresizingMaskIntoConstraints = false
        ProfileHeaderView.profileLabel.clipsToBounds = true
        ProfileHeaderView.profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ProfileHeaderView.profileLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                                              left: ProfileHeaderView.profileImageView.rightAnchor,
                                              bottom: ProfileHeaderView.statusLabel.bottomAnchor,
                                              right: safeAreaLayoutGuide.rightAnchor,
                                              paddingTop: 16,
                                              paddingLeft: 16,
                                              paddingRight: 16,
                                              paddingBottom: 80,
                                              width: 150,
                                              height: 50)
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
        ProfileHeaderView.textField.anchor(top: ProfileHeaderView.statusLabel.bottomAnchor,
                                           left: ProfileHeaderView.statusLabel.leftAnchor,
                                           bottom: ProfileHeaderView.showStatusButton.topAnchor,
                                           right: safeAreaLayoutGuide.rightAnchor,
                                           paddingTop: 0,
                                           paddingRight: 16,
                                           paddingBottom: 6,
                                           width: 100,
                                           height: 40)
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
        let newTextTyped = textField.text ?? "No text"
        statusText = newTextTyped
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

// MARK: - ProifleHeaderView Extensions

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
