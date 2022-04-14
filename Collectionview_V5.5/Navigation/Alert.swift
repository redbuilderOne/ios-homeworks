
import UIKit

struct Alert {

    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))

        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

        vc.present(alert, animated: true)
    }
}
