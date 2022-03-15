
import UIKit

class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoGalleryCollectionViewCell"

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
        contentView.backgroundColor = .systemRed
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // расположение изображения в ячейке
        myImageView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: contentView.frame.size.width,
                                   height: contentView.frame.size.height)

    }

    public func confgiurePhotoGalleryRow(image: UIImage) {
        myImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}
