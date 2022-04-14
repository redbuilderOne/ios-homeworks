
import UIKit

class PhotoGalleryVC: UIViewController {

    lazy var photoGalleryVC = PhotoGalleryVC()

    var titleLabel = UILabel()
    var photoGalleryView = UIView()

    var photoGalleryVCTitle = "Photo Gallery"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        titleLabel.text = photoGalleryVCTitle
        titleLabel.numberOfLines = 0
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    @objc func imageViewPressed() {
        let photoRootVC = SecondPhotoViewController()
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        photoRootVC.title = "Photo Gallery"
        self.show(photoNavVC, sender: self)
    }
}
