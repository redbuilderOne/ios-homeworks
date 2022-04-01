
import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    lazy var tableView = ProfileTableHeaderView()
    var collectionView: UICollectionView?

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
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        view.addSubview(tableView)
        configureProfileHeaderView()
        configureTableView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        createLayoutCollectionView()
    }

    struct Cells {
        static let postCell = "PostTableViewCell"
    }

    struct ConstantsForCollectionView {
        static let leftDistanceToView: CGFloat = 12
        static let rightDistanceToView: CGFloat = 12
        static let galleryMinLineSpacing: CGFloat = 8
    }

    func createLayoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ConstantsForCollectionView.galleryMinLineSpacing
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 24, left: 12, bottom: 12, right: 12)
        collectionView?.contentInset = UIEdgeInsets(top: 24,
                                                    left: ConstantsForCollectionView.leftDistanceToView,
                                                    bottom: 12,
                                                    right: ConstantsForCollectionView.rightDistanceToView)

        layout.itemSize = CGSize(width: view.frame.size.width/3,
                                 height: view.frame.size.height/3)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }

        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.addSubview(photosLabel)
        placePhotoLabel()
        collectionView.addSubview(CustomCollectionViewCell.leftArrowButton)
        placeLeftArrowButton()
        leftArrowButtonPressConfig()
        ifTappedOnMyImageView()

        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        collectionView.anchor(top: profileHeaderView.showStatusButton.topAnchor,
                              bottom: tableView.topAnchor,
                              paddingTop: 80,
                              paddingBottom: 16,
                              height: 160)
    }

    func placePhotoLabel() {
        photosLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        photosLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        photosLabel.anchor(top: collectionView?.topAnchor,
                           paddingTop: -6,
                           height: 50)
    }

    func placeLeftArrowButton() {
        CustomCollectionViewCell.leftArrowButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        CustomCollectionViewCell.leftArrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor).isActive = true
        CustomCollectionViewCell.leftArrowButton.anchor(top: collectionView?.topAnchor,
                           paddingTop: -6,
                           height: 50)
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
        print("leftArrowButton is pressed")
    }

    @objc func pushPhotoGallery() {
        let photoRootVC = SecondPhotoViewController()
        photoRootVC.title = "Photo Gallery"
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        show(photoNavVC, sender: self)
    }

    func ifTappedOnMyImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(objcPushPhotoGallery))
        CustomCollectionViewCell.myImageView.addGestureRecognizer(tapGesture)
        CustomCollectionViewCell.myImageView.isUserInteractionEnabled = true
    }

    @objc func objcPushPhotoGallery() {
        print("objcPushPhotoGallery is pressed")
        lazy var photoRootVC = SecondPhotoViewController()
        photoRootVC.title = "Photo Gallery"
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        show(photoNavVC, sender: self)
    }

    //       @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //            let photoRootVC = SecondPhotoViewController()
    //            photoRootVC.title = "Photo Gallery"
    //            lazy var photoNavVC: Void = UINavigationController(rootViewController: photoRootVC)
    //                .pushViewController(SecondPhotoViewController(), animated: true)
    //        }
    
    
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func fingerTap() {
        print("fingerTap was called")
        lazy var photoRootVC = SecondPhotoViewController()
        photoRootVC.title = "Photo Gallery"
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        show(photoNavVC, sender: self)
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
        return cell
    }
}

extension ProfileVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
}
