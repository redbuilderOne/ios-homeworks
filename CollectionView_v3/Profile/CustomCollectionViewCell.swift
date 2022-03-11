
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

    static let leftArrowButton = NewButton(color: .systemBackground, title: "", systemImageName: "arrow.forward")

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(myImageView)
        //        contentView.addSubview(CustomCollectionViewCell.leftArrowButton)
        configureMyImageView()
        //        configureLeftArrowButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        myImageView.frame = CGRect(x: 5,
                                   y: 0,
                                   width: contentView.frame.size.width-10,
                                   height: contentView.frame.size.height-50)

        //        photosLabel.frame = CGRect(x: 5,
        //                                   y: contentView.frame.size.height-50,
        //                                   width: contentView.frame.size.width-10,
        //                                   height: 50)

        //        CustomCollectionViewCell.leftArrowButton.frame = CGRect(x: 12,
        //                                       y: 24,
        //                                       width: 30,
        //                                       height: 30)
    }

    func configureMyImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PhotoGalleryVC.imageViewPressed))
        myImageView.addGestureRecognizer(tapGesture)
        myImageView.isUserInteractionEnabled = true
    }

    public func configureCollectionView(image: UIImage) {
        myImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}
