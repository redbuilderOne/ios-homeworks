
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    static let myImageView: UIImageView = {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(CustomCollectionViewCell.myImageView)
        CustomCollectionViewCell.myImageView.frame = CGRect(x: 0,
                                                            y: 0,
                                                            width: contentView.frame.size.width,
                                                            height: contentView.frame.size.height)
        //         contentView.frame.size.width w90 h75
    }
    
    public func configureCollectionView(image: UIImage) {
        CustomCollectionViewCell.myImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        CustomCollectionViewCell.myImageView.image = nil
    }
}