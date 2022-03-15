
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewForXibFile: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.addSubview(ProfileView())
    }

    private func loadViewFromXib() -> UIView {
        guard let xibView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? UIView else { return UIView() }

        return xibView
    }

    private func setupView() {
        let xibView = self.loadViewFromXib()
//        xibView.frame = view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(xibView)
    }
}
