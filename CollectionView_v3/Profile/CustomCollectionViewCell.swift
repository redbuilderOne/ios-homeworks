
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    static let identifier = "CustomCollectionViewCell"

    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    static let leftArrowButton = NewButton(color: .black, title: "", systemImageName: "arrow.forward")

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(myImageView)
        ifTappedOnMyImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: contentView.frame.size.width,
                                   height: contentView.frame.size.height)
    }

    func ifTappedOnMyImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(objcPushPhotoGallery))
        myImageView.addGestureRecognizer(tapGesture)
        myImageView.isUserInteractionEnabled = true
    }

    @objc func objcPushPhotoGallery() {
        print("objcPushPhotoGallery is pressed")
    }

//       @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            let photoRootVC = SecondPhotoViewController()
//            photoRootVC.title = "Photo Gallery"
//            lazy var photoNavVC: Void = UINavigationController(rootViewController: photoRootVC)
//                .pushViewController(SecondPhotoViewController(), animated: true)
//        }

    public func configureCollectionView(image: UIImage) {
        myImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}
