
import UIKit

// PHOTO GALLERY VIEW - ОТДЕЛЬНЫМ ЭКРАНОМ
class SecondPhotoViewController: UIViewController {

    private var collectionView: UICollectionView?
//    lazy var photoRootVC = navigationController
//    let phNavCtrlr = UINavigationController(rootViewController: SecondPhotoViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }


    private let sectionInsets = UIEdgeInsets(
        top: 8,
        left: 8,
        bottom: 8,
        right: 8)

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 8

        // (?)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//          layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.height/3)-4)
        //  layout.itemSize = CGSize(width: 110, height: 110)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)

        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(PhotoGalleryCollectionViewCell.self,
                                forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCell.identifier, for: indexPath) as! PhotoGalleryCollectionViewCell
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
