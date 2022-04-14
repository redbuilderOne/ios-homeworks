
import UIKit

class PhotoCollectionVC: UIViewController {

    var phCollectionView = UICollectionView()
    let phCollectionNavController = UINavigationController()
    let phCollectionViewCell = UICollectionViewCell()
    let phImageView = UIImageView()

    var collectionviewFlowLayout = UICollectionViewFlowLayout()
    let phCellIdentifier = "phCollectionViewCell"

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        createNavigationController()
        phCollectionNavController.viewControllers = [self]
        createLayoutPhCollectionView()
        configurePhImageView()
        configurePhotoCV()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    func createNavigationController() {
        lazy var photoRootVC = phCollectionNavController
        let photoNavVC = UINavigationController(rootViewController: photoRootVC)
        photoRootVC.title = "Photo Gallery"
        self.show(photoNavVC, sender: self)
    }

    func configurePhotoCV() {
        phCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            phCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            phCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            phCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func configurePhImageView() {
        phImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            phImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            phImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            phImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            phImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupPhCollectionView() {
        phCollectionView.delegate = self
        phCollectionView.dataSource = self
    }

    func createLayoutPhCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 1

        phCollectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        // размер ячейки
        layout.itemSize = CGSize(width: view.frame.size.width/3,
                                 height: view.frame.size.height/3)

        phCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        phCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        phCollectionView.dataSource = self
        phCollectionView.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(phCollectionView)
    }
}

extension PhotoCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCollectionViewImg.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell

        cell.configureCollectionView(image: arrayOfCollectionViewImg[indexPath.row])
        cell.clipsToBounds = true

        return cell
    }
}

// MARK: - Photo Gallery
class SecondPhotoViewController: UIViewController {

    private var collectionView: UICollectionView?
//    lazy var photoRootVC = navigationController
//    let phNavCtrlr = UINavigationController(rootViewController: SecondPhotoViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
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
        //  layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.height/3)-4)
        //  layout.itemSize = CGSize(width: 110, height: 110)
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }

        header.configure()
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}
