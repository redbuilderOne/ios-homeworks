//
//import UIKit
//
//class ProfileVC: UIViewController {
//
//    private lazy var layout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        return layout
//    }()
//
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .systemGray6
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
//        return collectionView
//    }()
//
//    lazy var profileHeaderView = ProfileHeaderView()
//    lazy var tableView = UITableView()
//    lazy var photoCollectionView = UICollectionView()
//
//    var posts = arrayOfPosts
//    let previewCollectionViewCells = previewArrayOfCollectionViewImg
//    let collectionViewCells = arrayOfCollectionViewImg
//
//    let photosLabel: UILabel = {
//        let photosLabel = UILabel()
//        photosLabel.text = "Photos"
//        photosLabel.textColor = .black
//        photosLabel.font = .boldSystemFont(ofSize: 24)
//        photosLabel.translatesAutoresizingMaskIntoConstraints = false
//        return photosLabel
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        view.addSubview(collectionView)
//        setConstraintsCollectionView()
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
////        configureTableView()
////        createLayoutCollectionView()
//    }
//
//    func setConstraintsCollectionView() {
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//
////    private func configureProfileHeaderViewUI() {
////        profileHeaderView.anchor(top: mainTableView.safeAreaLayoutGuide.topAnchor, height: 220)
////
////        NSLayoutConstraint.activate([
////            profileHeaderView.widthAnchor.constraint(equalTo: mainTableView.widthAnchor),
////            profileHeaderView.heightAnchor.constraint(equalTo: mainTableView.heightAnchor),
////            profileHeaderView.centerXAnchor.constraint(equalTo: mainTableView.centerXAnchor),
////            profileHeaderView.centerYAnchor.constraint(equalTo: mainTableView.centerYAnchor),
////            profileHeaderView.bottomAnchor.constraint(equalTo: collectionView!.topAnchor, constant: 220)
////        ])
////    }
//
//    struct Cells {
//        static let postCell = "PostTableViewCell"
//    }
//
//    struct ConstantsForCollectionView {
//        static let leftDistanceToView: CGFloat = 12
//        static let rightDistanceToView: CGFloat = 12
//        static let galleryMinLineSpacing: CGFloat = 8
//    }
//
//    func createLayoutCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = ConstantsForCollectionView.galleryMinLineSpacing
//        layout.minimumInteritemSpacing = 1
//        layout.sectionInset = UIEdgeInsets(top: 24, left: 12, bottom: 12, right: 12)
//        photoCollectionView.contentInset = UIEdgeInsets(top: 24,
//                                                    left: ConstantsForCollectionView.leftDistanceToView,
//                                                    bottom: 12,
//                                                    right: ConstantsForCollectionView.rightDistanceToView)
//
//        layout.itemSize = CGSize(width: view.frame.size.width/3,
//                                 height: view.frame.size.height/3)
//
//        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        photoCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
//        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
//
//        photoCollectionView.dataSource = self
//        photoCollectionView.delegate = self
//        tableView.addSubview(collectionView)
//        photoCollectionView.addSubview(photosLabel)
//        placePhotoLabel()
//        collectionView.addSubview(PhotoCollectionViewCell.leftArrowButton)
//        placeLeftArrowButton()
//        leftArrowButtonPressConfig()
//        ifTappedOnMyImageView()
//
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor),
//            collectionView.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor)
//        ])
//
//        collectionView.anchor(top: tableView.bottomAnchor,
//                              bottom: tableView.bottomAnchor,
//                              paddingTop: 80,
//                              paddingBottom: 16,
//                              height: 160)
//    }
//
//    func placePhotoLabel() {
//        NSLayoutConstraint.activate([
//        photosLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
//        photosLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//        ])
//
//        photosLabel.anchor(top: collectionView.topAnchor,
//                           paddingTop: -6,
//                           height: 50)
//    }
//
//    func placeLeftArrowButton() {
//        NSLayoutConstraint.activate([
//        PhotoCollectionViewCell.leftArrowButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
//        PhotoCollectionViewCell.leftArrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor)
//        ])
//
//        PhotoCollectionViewCell.leftArrowButton.anchor(top: collectionView.topAnchor,
//                           paddingTop: -6,
//                           height: 50)
//    }
////
////    private func configureProfileHeaderView() {
////        profileHeaderView.anchor(top: mainTableView.safeAreaLayoutGuide.topAnchor, height: 220)
////
////        NSLayoutConstraint.activate([
////            profileHeaderView.widthAnchor.constraint(equalTo: mainTableView.widthAnchor),
////            profileHeaderView.heightAnchor.constraint(equalTo: mainTableView.heightAnchor),
////            profileHeaderView.centerXAnchor.constraint(equalTo: mainTableView.centerXAnchor),
////            profileHeaderView.centerYAnchor.constraint(equalTo: mainTableView.centerYAnchor)
////        ])
////    }
//
//    private func configureTableView() {
////        tableView.anchor(top: profileHeaderView.showStatusButton.safeAreaLayoutGuide.topAnchor,
////                         left: view.safeAreaLayoutGuide.leftAnchor,
////                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
////                         right: view.safeAreaLayoutGuide.rightAnchor,
////                         paddingTop: 64,
////                         paddingLeft: 0,
////                         paddingRight: 0,
////                         paddingBottom: 0)
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44
//        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Cells.postCell)
//
//        NSLayoutConstraint.activate([
//            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
////
////    func setTableViewDelegates() {
////        tableView.delegate   = self
////        tableView.dataSource = self
////    }
//
//    func leftArrowButtonPressConfig() {
//        PhotoCollectionViewCell.leftArrowButton.addTarget(self, action: #selector(pushPhotoGallery), for: .touchUpInside)
//        print("leftArrowButton is pressed")
//    }
//
//    @objc func pushPhotoGallery() {
//        let photoRootVC = SecondPhotoViewController()
//        photoRootVC.title = "Photo Gallery"
//        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
//        show(photoNavVC, sender: self)
//    }
//
//    func ifTappedOnMyImageView() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(objcPushPhotoGallery))
//        PhotoCollectionViewCell.myImageView.addGestureRecognizer(tapGesture)
//        PhotoCollectionViewCell.myImageView.isUserInteractionEnabled = true
//    }
//
//    @objc func objcPushPhotoGallery() {
//        print("objcPushPhotoGallery is pressed")
//        lazy var photoRootVC = SecondPhotoViewController()
//        photoRootVC.title = "Photo Gallery"
//        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
//        show(photoNavVC, sender: self)
//    }
//
//    //       @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    //            let photoRootVC = SecondPhotoViewController()
//    //            photoRootVC.title = "Photo Gallery"
//    //            lazy var photoNavVC: Void = UINavigationController(rootViewController: photoRootVC)
//    //                .pushViewController(SecondPhotoViewController(), animated: true)
//    //        }
//
//    func configureTapGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
//        view.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func fingerTap() {
//        print("fingerTap was called")
//        lazy var photoRootVC = SecondPhotoViewController()
//        photoRootVC.title = "Photo Gallery"
//        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
//        show(photoNavVC, sender: self)
//    }
//}
////
////extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
////    // how many cells
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return posts.count
////    }
////    // what cells to show
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let firstCell = tableView.dequeueReusableCell(withIdentifier: Cells.postCell) as! PostTableViewCell
////        let post = posts[indexPath.row]
////        firstCell.set(post: post)
////        return firstCell
////    }
////    // высота ячейки
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 460
////    }
////}
//
//extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
//    // количество ячеек
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
////        return 2 + previewCollectionViewCells.count
//    }
//    // настройка ячеек
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath)
//            return cell
//        }
//        // подгружаем изображения из массива
//        cell.configureCollectionView(image: arrayOfCollectionViewImg[indexPath.row])
//        cell.layer.cornerRadius = 6
//        cell.clipsToBounds = true
//        return cell
//    }
//}
//
//extension ProfileVC: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 90, height: 90)
//    }
//}
