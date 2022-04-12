
import UIKit

// MARK: - Photo Gallery
class SecondPhotoViewController: UIViewController {

    private var collectionView: UICollectionView?
    static var phBackGroundView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        title = "Photo Gallery"
        view.backgroundColor = .systemBackground
        configureCollectionView()
        view.addSubview(SecondPhotoViewController.phBackGroundView)
        SecondPhotoViewController.phBackGroundView.isHidden = true
        setupPhBackGroundView()
    }

    static func animateImageInsideCollectionView() {
        print("animateImageInsideCollectionView is tapped")
        SecondPhotoViewController.phBackGroundView.isHidden = false
    }

    func setupPhBackGroundView() {
        SecondPhotoViewController.phBackGroundView.backgroundColor = .systemGray6
        SecondPhotoViewController.phBackGroundView.layer.opacity = 0.9
        SecondPhotoViewController.phBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            SecondPhotoViewController.phBackGroundView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            SecondPhotoViewController.phBackGroundView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            SecondPhotoViewController.phBackGroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            SecondPhotoViewController.phBackGroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(PhotoGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

// MARK: Extension
extension SecondPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoGalleryCollectionViewCell {
            print("Tap on \(cell)")
            cell.animateCell()
        }
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
