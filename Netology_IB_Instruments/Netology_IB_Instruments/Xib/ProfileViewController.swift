
import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        if let subview = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? UIView {
            self.view.addSubview(subview)
        }
    }
}
