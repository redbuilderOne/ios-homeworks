
import UIKit

class StackViewButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
        titleLabel?.font = .systemFont(ofSize: 28)
        layer.cornerRadius = 10
    }
}
