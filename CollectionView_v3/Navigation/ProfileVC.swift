
import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    lazy var tableView = ProfileTableHeaderView()
    var collectionView: UICollectionView?
    var collectionBackgroundView = UIView()

    var posts = arrayOfPosts
    let previewCollectionViewCells = previewArrayOfCollectionViewImg
    let collectionViewCells = arrayOfCollectionViewImg

    let photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Photos"
        photosLabel.textColor = .black
        photosLabel.font = .boldSystemFont(ofSize: 24)
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        return photosLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = .lightGray
        view.addSubview(collectionBackgroundView)
        view.addSubview(profileHeaderView)
        view.addSubview(tableView)
        collectionBackgroundView.addSubview(CustomCollectionViewCell.leftArrowButton)
        configureProfileHeaderView()
        configureTableView()
        configureCollectionBackgroundView()
        placingLeftArrowButton()
        placingPhotosLabel()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        createLayoutCollectionView()
    }

    func configureCollectionBackgroundView() {
        collectionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        collectionBackgroundView.backgroundColor = .systemBackground
        collectionBackgroundView.backgroundColor = .red
        collectionBackgroundView.anchor(top: profileHeaderView.showStatusButton.topAnchor,
                                        bottom: tableView.topAnchor,
                                        paddingTop: 80,
                                        paddingBottom: 16,
                                        height: 160)
    }

    func placingLeftArrowButton() {
        CustomCollectionViewCell.leftArrowButton.frame = CGRect(x: 12,
                                                                y: 24,
                                                                width: 30,
                                                                height: 30)
        NSLayoutConstraint.activate([
            CustomCollectionViewCell.leftArrowButton.widthAnchor.constraint(equalToConstant: 30),
            CustomCollectionViewCell.leftArrowButton.heightAnchor.constraint(equalToConstant: 30),
            CustomCollectionViewCell.leftArrowButton.trailingAnchor.constraint(equalTo: collectionBackgroundView.trailingAnchor, constant: -16)
        ])
    }

    func placingPhotosLabel() {
        //        photosLabel.frame = CGRect(x: 5,
        //                                   y: collectionBackgroundView.frame.size.height-50,
        //                                   width: collectionBackgroundView.frame.size.width-10,
        //                                   height: 50)
        //
        //        NSLayoutConstraint.activate([
        //            photosLabel.topAnchor.constraint(equalTo: collectionBackgroundView.topAnchor, constant: 12),
        //            photosLabel.bottomAnchor.constraint(equalTo: collectionBackgroundView.bottomAnchor, constant: 12),
        //            photosLabel.leadingAnchor.constraint(equalTo: collectionBackgroundView.leadingAnchor, constant: 12),
        //            photosLabel.trailingAnchor.constraint(equalTo: collectionBackgroundView.safeAreaLayoutGuide.trailingAnchor)
        //        ])
    }

    struct Cells {
        static let postCell = "PostTableViewCell"
    }

    struct ConstantsForCollectionView {
        static let leftDistanceToView: CGFloat = 12
        static let rightDistanceToView: CGFloat = 12
        static let galleryMinLineSpacing: CGFloat = 8
        //        ширина текущго экрана
        //        static let galleryItemWidth = (UIScreen.main.bounds.width - ConstantsForCollectionView.leftDistanceToView - ConstantsForCollectionView.rightDistanceToView - (ConstantsForCollectionView.galleryMinLineSpacing / 4)) / 2
    }

    func createLayoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ConstantsForCollectionView.galleryMinLineSpacing
        layout.minimumInteritemSpacing = 1

        // оступы от краев границы
        collectionView?.contentInset = UIEdgeInsets(top: 24, left: ConstantsForCollectionView.leftDistanceToView, bottom: 12, right: ConstantsForCollectionView.rightDistanceToView)

        // размер ячейки
        layout.itemSize = CGSize(width: view.frame.size.width/3,
                                 height: view.frame.size.height/3)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }

        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .systemBackground
        collectionBackgroundView.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        collectionView.anchor(top: profileHeaderView.showStatusButton.topAnchor,
                              bottom: tableView.topAnchor,
                              paddingTop: 80,
                              paddingBottom: 16,
                              height: 160)
    }

    private func configureProfileHeaderView() {
        profileHeaderView.anchor(top: view.safeAreaLayoutGuide.topAnchor, height: 220)

        NSLayoutConstraint.activate([
            profileHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor),
            profileHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileHeaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureTableView() {
        setTableViewDelegates()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Cells.postCell)

        tableView.anchor(left: view.safeAreaLayoutGuide.leftAnchor)
        tableView.anchor(right: view.safeAreaLayoutGuide.rightAnchor)
        tableView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        tableView.anchor(top: collectionView?.topAnchor, height: 400)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setTableViewDelegates() {
        tableView.delegate   = self
        tableView.dataSource = self
    }

    func leftArrowButtonPressConfig() {
        CustomCollectionViewCell.leftArrowButton.addTarget(self, action: #selector(pushPhotoGallery), for: .touchUpInside)
    }

    @objc func pushPhotoGallery() -> UINavigationController {
        let photoGalleryVC = PhotoGalleryVC()
        photoGalleryVC.title = "Photo Gallery"
        return UINavigationController(rootViewController: photoGalleryVC)
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    // how many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    // what cells to show
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.postCell) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.set(post: post)
        return cell
    }

    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 460
    }
}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {

    // количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previewCollectionViewCells.count
    }

    // настройка ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell

        // подгружаем изображения из массива
        cell.configureCollectionView(image: arrayOfCollectionViewImg[indexPath.row])
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        cell.contentView.backgroundColor = .systemRed
        return cell
    }
}

extension ProfileVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        //        let cellFrame = collectionView.frame
        //        let widthCell = cellFrame.width
        //        let heightCell = widthCell
        //
        //        let spacing = CGFloat((3 + 1)) * 2 / CGFloat(3)

        return CGSize(width: 100, height: 80)
    }
}
