
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

        phCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell

        cell.configureCollectionView(image: arrayOfCollectionViewImg[indexPath.row])
        cell.clipsToBounds = true

        return cell
    }
}
