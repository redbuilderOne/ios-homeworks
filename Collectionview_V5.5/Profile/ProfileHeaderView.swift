
import UIKit

class ProfileHeaderView: UIView {

    var profileImageView = UIImageView()
    var profileLabel = UILabel()
    var statusLabel = UILabel()
    var showStatusButton = NewButton(color: .blue, title: "Show status", systemImageName: "eye")
    var textField = UITextField()

    private var statusText = String()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(profileImageView)
        addSubview(showStatusButton)
        addSubview(profileLabel)
        addSubview(statusLabel)
        addSubview(textField)

        configureProfileImageView()
        configureShowStatusButton()
        configureProfileLabel()
        configureStatusLabel()
        configureTextField()

        textField.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                left: safeAreaLayoutGuide.leftAnchor,
                                paddingTop: 16,
                                paddingLeft: 16,
                                width: 150,
                                height: 150)

        showStatusButton.anchor(top: profileImageView.topAnchor,
                                left: safeAreaLayoutGuide.leftAnchor,
                                bottom: safeAreaLayoutGuide.bottomAnchor,
                                right: safeAreaLayoutGuide.rightAnchor,
                                paddingTop: 180,
                                paddingLeft: 16,
                                paddingRight: 16,
                                paddingBottom: 980,
                                width: 150,
                                height: 50)

        showStatusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        statusLabel.anchor(top: profileLabel.topAnchor,
                           left: profileImageView.leftAnchor,
                           bottom: showStatusButton.bottomAnchor,
                           right: safeAreaLayoutGuide.rightAnchor,
                           paddingTop: 80,
                           paddingLeft: 160,
                           paddingRight: 16,
                           paddingBottom: 80,
                           width: 150,
                           height: 50)

        statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func configureProfileImageView() {
        profileImageView.layer.cornerRadius = 72
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 100)
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = ProfileImages.profileImg
    }

    @objc func buttonPressed() {
        textField.isHidden = false
        print("\(statusLabel.text!)")
        showStatusButton.configuration?.title = "Set status"
        showStatusButton.configuration?.baseForegroundColor = .white
        showStatusButton.configuration?.baseBackgroundColor = .black
        showStatusButton.addTarget(self, action: #selector(secondButtonPress), for: .touchUpInside)
    }

    @objc func secondButtonPress() {
        textField.isHidden = true
        statusLabel.text = statusText
        showStatusButton.configuration?.title = "Show status"
        showStatusButton.configuration?.baseForegroundColor = .white
        showStatusButton.configuration?.baseBackgroundColor = .black
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    private func configureShowStatusButton() {
        showStatusButton.backgroundColor = .blue
        showStatusButton.titleLabel?.textColor = .white
        showStatusButton.layer.cornerRadius = 4
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowRadius = 4
        showStatusButton.layer.shadowOpacity = 0.7
        showStatusButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
        showStatusButton.clipsToBounds = true
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }


    private func configureProfileLabel() {
        profileLabel.text = "Dima Skvortsov"
        profileLabel.font = .boldSystemFont(ofSize: 18)
        profileLabel.textColor = .black
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.clipsToBounds = true
        profileLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                            left: profileImageView.leftAnchor,
                            right: safeAreaLayoutGuide.rightAnchor,
                            paddingTop: 16,
                            paddingLeft: 160,
                            paddingRight: 16,
                            width: 150,
                            height: 50)
    }

    private func configureTextField() {
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 100)
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textField.addTarget(self, action: #selector(textFieldTapped), for: .touchUpInside)
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.delegate = self
        textField.anchor(top: statusLabel.topAnchor,
                         left: statusLabel.leftAnchor,
                         bottom: showStatusButton.bottomAnchor,
                         right: safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 50,
                         paddingRight: 16,
                         paddingBottom: 60,
                         width: 100,
                         height: 40)
    }

    @objc func textFieldTapped() {
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .yes
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
        self.endEditing(true)
    }

    private func configureStatusLabel() {
        statusLabel.text = "Learning Swift..."
        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
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

extension ProfileHeaderView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
