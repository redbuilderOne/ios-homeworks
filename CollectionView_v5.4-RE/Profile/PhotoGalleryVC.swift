
import UIKit

// MARK: - Photo Gallery
class SecondPhotoViewController: UIViewController {

    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        title = "Photo Gallery"
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }

    private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 8

        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)

        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(PhotoGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

extension SecondPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCell.identifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        cell.confgiurePhotoGalleryRow(image: arrayOfCollectionViewImg[indexPath.row])
        cell.clipsToBounds = true

        return cell
    }
}

extension SecondPhotoViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * 4
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 3

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
