
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    // Фото галерея
    static let identifier = "PhotoCollectionViewCell"
    
    private lazy var myImageView: UIImageView = {
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
        configureContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }

    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            contentView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    public func configureCollectionView(image: UIImage) {
        myImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }

    func ifTappedOnMyImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableView))
        myImageView.addGestureRecognizer(tapGesture)
        myImageView.isUserInteractionEnabled = true
    }

    // MARK: - TODO
    @objc func objcPushPhotoGallery() {
        print("objcPushPhotoGallery is pressed")
        lazy var photoRootVC = SecondPhotoViewController()
        photoRootVC.title = "Photo Gallery"
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
//        show(photoNavVC, sender: self)
    }

    @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         let photoRootVC = SecondPhotoViewController()
         photoRootVC.title = "Photo Gallery"
         lazy var photoNavVC: Void = UINavigationController(rootViewController: photoRootVC)
            .pushViewController(SecondPhotoViewController(), animated: true)
     }
}
