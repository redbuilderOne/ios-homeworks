
import UIKit

private enum State {
    case expanded
    case collapsed

    var change: State {
        switch self {
        case .expanded: return .collapsed
        case .collapsed: return .expanded
        }
    }
}

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    lazy var tableView = ProfileTableHeaderView()
    static var collectionView: UICollectionView?
    var posts = arrayOfPosts
    lazy var viewForAvatar = UIView()

    // Свойства для управления анимацией
    private var initialFrame: CGRect?
    private var state: State = .collapsed
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
    }()

    let photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Photos"
        photosLabel.textColor = .black
        photosLabel.font = .boldSystemFont(ofSize: 24)
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        return photosLabel
    }()

    // MARK: - ProfileVC Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        view.addSubview(tableView)
        configureProfileHeaderView()
        createLayoutCollectionView()
        configureTableView()

        AnimationCustmization.backgorundViewForAvatar.layer.opacity = 0
        view.addSubview(AnimationCustmization.backgorundViewForAvatar)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureProfileHeaderView()
        createLayoutCollectionView()
        configureTableView()

        AnimationCustmization.backgorundViewForAvatar.layer.opacity = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ifTappedOnAvatar()
    }

    // MARK: - Animation setting

    func ifTappedOnAvatar() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(objcAvatarTap))
        ProfileHeaderView.profileImageView.addGestureRecognizer(tapGesture)
        ProfileHeaderView.profileImageView.isUserInteractionEnabled = true
    }

    struct AnimationCustmization {
        static var avatarAnimation = UIViewPropertyAnimator()
        static var avatarButtonAnimation = UIViewPropertyAnimator()
        static var avatarCancelButton = UIButton()
        static var backgorundViewForAvatar = UIView()
    }

    // Анимация начинается
    private func expand() {
        animator.addAnimations {

            self.view.addSubview(ProfileHeaderView.profileImageView)
            configureViewForAvatar()

            func configureViewForAvatar() {
                NSLayoutConstraint.activate([
                    AnimationCustmization.backgorundViewForAvatar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                    AnimationCustmization.backgorundViewForAvatar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                    AnimationCustmization.backgorundViewForAvatar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                    AnimationCustmization.backgorundViewForAvatar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                    AnimationCustmization.backgorundViewForAvatar.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
                    AnimationCustmization.backgorundViewForAvatar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)
                ])
                AnimationCustmization.backgorundViewForAvatar.backgroundColor = .systemGray
                AnimationCustmization.backgorundViewForAvatar.layer.opacity = 0.5
                AnimationCustmization.backgorundViewForAvatar.translatesAutoresizingMaskIntoConstraints = false
            }

            ProfileHeaderView.profileImageView.layer.borderWidth = 0
            ProfileHeaderView.profileImageView.layer.cornerRadius = 0
            ProfileHeaderView.profileImageView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                ProfileHeaderView.profileImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                ProfileHeaderView.profileImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                ProfileHeaderView.profileImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                ProfileHeaderView.profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                ProfileHeaderView.profileImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
                ProfileHeaderView.profileImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)
            ])

            ProfileHeaderView.profileImageView.contentMode = .scaleAspectFill
            ProfileHeaderView.profileImageView.layoutIfNeeded()
        }

        animator.addCompletion { position in
            switch position {
            case .end:
                self.state = self.state.change
            default:
                ()
            }
        }

        animator.startAnimation()
    }

    // Обратная анимация
    private func collapse() {

        animator.addCompletion { position in
            switch position {
            case .end:
                self.state = self.state.change
                
                AnimationCustmization.backgorundViewForAvatar.layer.opacity = 0
                ProfileHeaderView.profileImageView.layer.cornerRadius = 72
                ProfileHeaderView.profileImageView.layer.borderWidth = 3
            default:
                ()
            }
        }

        animator.startAnimation()
    }

    @objc func objcAvatarTap() {
        print("objcAvatarTap is pressed")
        AnimationCustmization.avatarCancelButton.isHidden = false
        toggle()

        func toggle() {
            switch state {
            case .expanded:
                collapse()
            case .collapsed:
                expand()
            }
        }

        AnimationCustmization.avatarButtonAnimation = UIViewPropertyAnimator(duration:0.8, curve: .easeInOut) {
            lazy var cancelButton = AnimationCustmization.avatarCancelButton
            ProfileHeaderView.profileImageView.addSubview(cancelButton)
            configureCancelButton()

            cancelButton.anchor(top: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.topAnchor,
                                right: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.rightAnchor,
                                paddingTop: 32,
                                paddingLeft: 0,
                                paddingRight: 32,
                                paddingBottom: 0,
                                width: 30,
                                height: 30)

            func configureCancelButton() {
                cancelButton.configuration = .tinted()
                cancelButton.configuration?.image = UIImage(systemName: "xmark.square")
                cancelButton.layer.cornerRadius = 4
                cancelButton.configuration?.baseForegroundColor = .white
                cancelButton.configuration?.baseBackgroundColor = .black
                cancelButton.translatesAutoresizingMaskIntoConstraints = false
                cancelButton.clipsToBounds = true
            }
            cancelButton.addTarget(self, action: #selector(self.reverseAnimation), for: .touchUpInside)
        }

        AnimationCustmization.avatarAnimation.startAnimation()
        AnimationCustmization.avatarButtonAnimation.startAnimation(afterDelay: 0.8)
    }

    @objc func reverseAnimation() {
        print("cancelButton is tapped")
        cancelToggle()

        animator.addAnimations {
            ProfileHeaderView.profileImageView.anchor(top: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.topAnchor,
                                                      left:ProfileHeaderView.profileImageView.safeAreaLayoutGuide.leftAnchor,
                                                      bottom: ProfileHeaderView.showStatusButton.topAnchor,
                                                      right: ProfileHeaderView.profileLabel.leftAnchor,
                                                      paddingTop: 16,
                                                      paddingLeft: 16,
                                                      paddingRight: 16,
                                                      paddingBottom: 16,
                                                      width: 150,
                                                      height: 150)

            ProfileHeaderView.profileImageView.layer.cornerRadius = 72
            ProfileHeaderView.profileImageView.layer.borderWidth = 3
            ProfileHeaderView.profileImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 100)
            ProfileHeaderView.profileImageView.clipsToBounds = true
        }

        animator.startAnimation()

        func cancelToggle() {
            switch state {
            case .collapsed:
                print("expand func is done")
                //                ProfileHeaderView.profileImageView.isHidden = true
                AnimationCustmization.avatarCancelButton.isHidden = true
                AnimationCustmization.backgorundViewForAvatar.isHidden = true
                expand()
            case .expanded:
                print("collapse func is done")
                collapse()
            }
        }
    }

    // MARK: - CollectionView

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
        layout.minimumLineSpacing = ConstantsForCollectionView.galleryMinLineSpacing
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 48, left: 12, bottom: 0, right: 12)
        ProfileVC.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        ProfileVC.collectionView?.contentInset = UIEdgeInsets(top: 24,
                                                              left: ConstantsForCollectionView.leftDistanceToView,
                                                              bottom: 12,
                                                              right: ConstantsForCollectionView.rightDistanceToView)

        layout.itemSize = CGSize(width: view.frame.size.width/3,
                                 height: view.frame.size.height/3)

        ProfileVC.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = ProfileVC.collectionView else {
            return
        }

        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)

        CustomCollectionViewCell.myImageView.frame = CGRect(x: 0,
                                                            y: 0,
                                                            width: 90,
                                                            height: 75)

        collectionView.dataSource = self
        collectionView.delegate = self
        profileHeaderView.addSubview(collectionView)
        collectionView.addSubview(photosLabel)
        placePhotoLabel()
        collectionView.addSubview(CustomCollectionViewCell.leftArrowButton)
        placeLeftArrowButton()
        leftArrowButtonPressConfig()
        ifTappedOnMyImageView()

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        collectionView.anchor(top: ProfileHeaderView.showStatusButton.bottomAnchor,
                              bottom: tableView.topAnchor,
                              paddingTop: 16,
                              paddingBottom: 16,
                              height: 160)
    }

    func placePhotoLabel() {
        NSLayoutConstraint.activate([
            photosLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            photosLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        photosLabel.anchor(top: ProfileVC.collectionView?.topAnchor,
                           paddingTop: -6,
                           height: 50)
    }

    func placeLeftArrowButton() {
        NSLayoutConstraint.activate([
            CustomCollectionViewCell.leftArrowButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            CustomCollectionViewCell.leftArrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor)
        ])

        CustomCollectionViewCell.leftArrowButton.anchor(top: ProfileVC.collectionView?.topAnchor,
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

    // MARK: - TableView

    private func configureTableView() {
        setTableViewDelegates()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Cells.postCell)
        tableView.anchor(top: ProfileVC.collectionView?.bottomAnchor, paddingTop: 16)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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

    //    @objc func objcPushVCPhotoGallery() {
    //        print("objcPushVCPhotoGallery is pressed")
    //        let photoRootVC = SecondPhotoViewController()
    //        photoRootVC.title = "Photo Gallery"
    //        lazy var photoNavVC: Void = UINavigationController(rootViewController: photoRootVC)
    //        .pushViewController(SecondPhotoViewController(), animated: true)
    //    }

    //           @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //                let photoRootVC = SecondPhotoViewController()
    //                photoRootVC.title = "Photo Gallery"
    //                lazy var photoNavVC: Void = UINavigationController(rootViewController: photoRootVC)
    //                    .pushViewController(SecondPhotoViewController(), animated: true)
    //            }

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

// MARK: - ProfileVC Extensions

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    // ПОСТЫ
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
    // ФОТО ГАЛЕРЕЯ (ГДЕ 4ШТ)
    // количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previewArrayOfCollectionViewImg.count
    }
    // настройка ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configureCollectionView(image: previewArrayOfCollectionViewImg[indexPath.row])
        // подгружаем изображения из массива
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        cell.contentView.backgroundColor = .systemRed
        return cell
    }
}

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 75)
    }
}
