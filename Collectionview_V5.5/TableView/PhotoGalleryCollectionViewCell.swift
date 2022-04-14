
import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "HeaderCollectionReusableViev"

    private let navLabel: UILabel = {
        let navLabel = UILabel()
        navLabel.text = "Photo Gallery"
        navLabel.textColor = .black
        navLabel.font = .boldSystemFont(ofSize: 18)
        navLabel.textAlignment = .center
        return navLabel
    }()

    private let backButton = NewButton(color: .blue, title: "Back", systemImageName: "chevron.backward")

    public func configure() {
        addSubview(navLabel)
        addSubview(backButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        navLabel.frame = bounds
        confBackButton()
    }

    private func confBackButton() {
        backButton.configuration?.baseForegroundColor = .systemBlue
        backButton.configuration?.baseBackgroundColor = .systemBackground
        backButton.configuration?.imagePlacement = .leading
        backButton.frame = CGRect(x: 0, y: 12, width: self.frame.size.width, height: self.frame.size.height)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }

    @objc func backButtonPressed() {
        print("backButton is pressed")
        lazy var photoRootVC = ProfileVC()
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        photoRootVC.navigationController?.popViewController(animated: true)
    }
}

class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoGalleryCollectionViewCell"

    private let navLabel: UILabel = {
        let navLabel = UILabel()
        navLabel.text = "Photo Gallery"
        navLabel.textColor = .black
        navLabel.font = .systemFont(ofSize: 24)
        return navLabel
    }()

    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }

    public func confgiurePhotoGalleryRow(image: UIImage) {
        myImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}
