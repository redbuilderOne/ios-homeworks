
import UIKit

class PhotosTableViewCell: UICollectionViewCell {

    let identifier = "PhotosTableViewCell"
    //    let photoCollectionView = PhotosTableViewCell()
    var photoCollectionView: UICollectionView?
    let showCollectionViewCells = arrayOfCollectionViewImg
    var edgesInsets = UIEdgeInsets()

    let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.image = UIImage()
        photoImageView.backgroundColor = .systemBackground
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.clipsToBounds = true
        return photoImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func createPhotoCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8

        // оступы от краев границы
        photoCollectionView?.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        // размер ячейки
        layout.itemSize = CGSize(width: self.frame.size.width/2,
                                 height: self.frame.size.height/2)

        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let photoCollectionView = photoCollectionView else {
            return
        }

        photoCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosTableViewCell")
//        photoCollectionView.dataSource = self
//        photoCollectionView.delegate = self

        self.backgroundColor = .systemBackground

        addSubview(photoCollectionView)

        photoCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        photoCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true

        photoCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                   bottom: safeAreaLayoutGuide.bottomAnchor,
                                   paddingTop: 0,
                                   paddingBottom: 0)

        NSLayoutConstraint.activate([
            photoCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            photoCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func configureCollectionView(image: UIImage) {
        photoImageView.image = image
    }
}
