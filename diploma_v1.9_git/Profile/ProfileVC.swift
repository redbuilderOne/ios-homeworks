
import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    lazy var headerView = UIView()
    lazy var cancelButton = AnimationCustmization.avatarCancelButton

    // Свойства для управления анимацией
    private var initialFrame: CGRect?
    private var state: State = .collapsed
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    }()

    // MARK: - tableView1
    private lazy var tableView1: UITableView = {
        let tableView1 = UITableView()
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.rowHeight = UITableView.automaticDimension
        tableView1.estimatedRowHeight = 44
        tableView1.register(PhotoCollectionTableViewCell.self, forCellReuseIdentifier: Cells.phCollectionID)
        tableView1.register(PostTableViewCell.self, forCellReuseIdentifier: Cells.postCellID)
        return tableView1
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()

    var postContent: [Post] = []
    var photoContent: [UIImage] = []

    public struct Cells {
        static let postCellID = "PostTableViewCell"
        static let phCollectionID = "PhotoCollectionTableViewCell"
    }

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemBackground
        postContent = fetchPostData()
        photoContent = fetchPhotoData()
        AnimationCustmization.backgroundViewForAvatar.addSubview(avatarImgForAnimation)
        AnimationCustmization.backgroundViewForAvatar.addSubview(cancelButton)
        view.addSubview(headerView)
        headerView.addSubview(profileHeaderView)
        view.addSubview(tableView1)
        view.addSubview(AnimationCustmization.backgroundViewForAvatar)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // The view’s bounds are finalized here
        configureViewForProfileHeader()
        confTableView()
        configureProfileHeaderViewUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // the subviews have been configured
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear happened")
        // when the view appears on the screen. This is also where the bounds for the view are defined
        avatarImgForAnimation.isHidden = true
        AnimationCustmization.avatarCancelButton.isHidden = true
        AnimationCustmization.backgroundViewForAvatar.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear happened")
        // After the view is presented on the screen, viewDidAppear() is called.
        ifTappedOnAvatar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear happened")
        // If the view is being removed from a view hierarchy, this method is called just before the view is actually removed and before any animations are configured.
    }

    // MARK: -New ImgView for Animation
    lazy var avatarImgForAnimation: UIImageView = {
        let avatarImgForAnimation = UIImageView()
        avatarImgForAnimation.layer.cornerRadius = 72
        avatarImgForAnimation.layer.borderWidth = 3
        avatarImgForAnimation.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 100)
        avatarImgForAnimation.clipsToBounds = true
        avatarImgForAnimation.translatesAutoresizingMaskIntoConstraints = false
        avatarImgForAnimation.image = ProfileImages.profileImg
        return avatarImgForAnimation
    }()

    //MARK: - Back Button
    @objc static func backButtonPressed() {
        print("backButton is pressed")
        lazy var photoRootVC = ProfileVC()
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        photoNavVC.show(photoRootVC, sender: self)
        //        photoNavVC.navigationController?.pushViewController(photoRootVC, animated: true)
    }
    // MARK: -Config
    private func configureViewForProfileHeader() {
        headerView.backgroundColor = .systemGray6
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }

    private func configureProfileHeaderViewUI() {
        profileHeaderView.anchor(top: headerView.safeAreaLayoutGuide.topAnchor, height: 220)
        NSLayoutConstraint.activate([
            profileHeaderView.widthAnchor.constraint(equalTo: headerView.widthAnchor),
            profileHeaderView.heightAnchor.constraint(equalTo: headerView.heightAnchor),
            profileHeaderView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            profileHeaderView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }

    private func confTableView() {
        // вкл/выкл тап по таблице
        tableView1.isUserInteractionEnabled = true
        tableView1.anchor(top: ProfileHeaderView.showStatusButton.safeAreaLayoutGuide.topAnchor,
                          left: headerView.safeAreaLayoutGuide.leftAnchor,
                          bottom: headerView.safeAreaLayoutGuide.bottomAnchor,
                          right: headerView.safeAreaLayoutGuide.rightAnchor,
                          paddingTop: 64)

        NSLayoutConstraint.activate([
            tableView1.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            tableView1.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            tableView1.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }

    func returnConstrainsForAvatar() {
        NSLayoutConstraint.activate([
            AnimationCustmization.backgroundViewForAvatar.leadingAnchor.constraint(equalTo: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.leadingAnchor),
            AnimationCustmization.backgroundViewForAvatar.trailingAnchor.constraint(equalTo: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.trailingAnchor),
            AnimationCustmization.backgroundViewForAvatar.bottomAnchor.constraint(equalTo: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.bottomAnchor),
            AnimationCustmization.backgroundViewForAvatar.topAnchor.constraint(equalTo: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.topAnchor),
            AnimationCustmization.backgroundViewForAvatar.heightAnchor.constraint(equalTo: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.heightAnchor),
            AnimationCustmization.backgroundViewForAvatar.widthAnchor.constraint(equalTo: ProfileHeaderView.profileImageView.safeAreaLayoutGuide.widthAnchor)
        ])
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
        static var backgroundViewForAvatar = UIView()
    }

    // MARK: - Animation Starts
    private func expand() {
        animator.addAnimations {

            self.avatarImgForAnimation.isHidden = false
            ProfileHeaderView.profileImageView.isHidden = true
            configureViewForAvatar()

            func configureViewForAvatar() {
                NSLayoutConstraint.activate([
                    AnimationCustmization.backgroundViewForAvatar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                    AnimationCustmization.backgroundViewForAvatar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                    AnimationCustmization.backgroundViewForAvatar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                    AnimationCustmization.backgroundViewForAvatar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                    AnimationCustmization.backgroundViewForAvatar.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
                    AnimationCustmization.backgroundViewForAvatar.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
                    AnimationCustmization.backgroundViewForAvatar.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                    AnimationCustmization.backgroundViewForAvatar.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
                ])

                AnimationCustmization.backgroundViewForAvatar.backgroundColor = .systemGray
                AnimationCustmization.backgroundViewForAvatar.layer.opacity = 0.95
                AnimationCustmization.backgroundViewForAvatar.translatesAutoresizingMaskIntoConstraints = false
            }

            self.avatarImgForAnimation.layer.borderWidth = 0
            self.avatarImgForAnimation.layer.cornerRadius = 0
            self.avatarImgForAnimation.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                self.avatarImgForAnimation.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.avatarImgForAnimation.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.avatarImgForAnimation.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                self.avatarImgForAnimation.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.avatarImgForAnimation.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
                self.avatarImgForAnimation.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
                self.avatarImgForAnimation.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                self.avatarImgForAnimation.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
            ])
            self.avatarImgForAnimation.contentMode = .scaleAspectFill
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

    //MARK: -REVERSE Обратная анимация
    private func collapse() {

        animator.addCompletion { position in
            switch position {
            case .end:
                self.state = self.state.change
                ProfileHeaderView.profileImageView.isHidden = false

                AnimationCustmization.backgroundViewForAvatar.layer.opacity = 0
                self.avatarImgForAnimation.layer.cornerRadius = 72
                self.avatarImgForAnimation.layer.borderWidth = 3
            default:
                ()
            }
        }
        animator.startAnimation()
    }

    @objc func objcAvatarTap() {
        print("objcAvatarTap is pressed")
        toggle()

        func toggle() {
            switch state {
            case .expanded:
                collapse()
            case .collapsed:
                expand()
            }
        }

        AnimationCustmization.avatarButtonAnimation = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut) {

            //            AnimationCustmization.backgroundViewForAvatar.addSubview(self.cancelButton)
            configureCancelButton()

            self.cancelButton.anchor(top: self.avatarImgForAnimation.safeAreaLayoutGuide.topAnchor,
                                     right: self.avatarImgForAnimation.safeAreaLayoutGuide.rightAnchor,
                                     paddingTop: 32,
                                     paddingLeft: 0,
                                     paddingRight: 32,
                                     paddingBottom: 0,
                                     width: 30,
                                     height: 30)

            func configureCancelButton() {
                self.cancelButton.configuration = .tinted()
                self.cancelButton.configuration?.image = UIImage(systemName: "xmark.square")
                self.cancelButton.layer.cornerRadius = 4
                self.cancelButton.configuration?.baseForegroundColor = .white
                self.cancelButton.configuration?.baseBackgroundColor = .black
                self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
                self.cancelButton.clipsToBounds = true
                self.cancelButton.addTarget(self, action: #selector(self.reverseAnimation), for: .touchUpInside)
            }
        }
        AnimationCustmization.avatarCancelButton.isHidden = false
        AnimationCustmization.avatarAnimation.startAnimation()
        AnimationCustmization.avatarButtonAnimation.startAnimation(afterDelay: 0.8)
    }

    // MARK: - REVERSE ANIMATION
    @objc func reverseAnimation() {
        print("cancelButton is tapped")
        cancelToggle()

        animator.addAnimations {
            self.avatarImgForAnimation.contentMode = .scaleAspectFit

            NSLayoutConstraint.activate([
                self.avatarImgForAnimation.leadingAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.leadingAnchor),
                self.avatarImgForAnimation.trailingAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.trailingAnchor),
                self.avatarImgForAnimation.bottomAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.bottomAnchor),
                self.avatarImgForAnimation.topAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.topAnchor),
                self.avatarImgForAnimation.heightAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.heightAnchor),
                self.avatarImgForAnimation.widthAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.widthAnchor),
                self.avatarImgForAnimation.centerXAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.centerXAnchor),
                self.avatarImgForAnimation.centerYAnchor.constraint(equalTo: self.profileHeaderView.safeAreaLayoutGuide.centerYAnchor)
            ])

            AnimationCustmization.backgroundViewForAvatar.isHidden = true
            AnimationCustmization.avatarCancelButton.isHidden = true
            ProfileHeaderView.profileImageView.isHidden = false

            self.returnConstrainsForAvatar()
        }

        animator.startAnimation()

        func cancelToggle() {
            switch state {
            case .collapsed:
                print("expand func is done")
                AnimationCustmization.avatarCancelButton.isHidden = true
                AnimationCustmization.backgroundViewForAvatar.isHidden = true
                expand()
            case .expanded:
                print("collapse func is done")
                collapse()
                expand()
            }
        }
    }


    // MARK: - Buttons & Actions
    func leftArrowButtonPressConfig() {
        PhotoCollectionTableViewCell.leftArrowButton.addTarget(self, action: #selector(pushPhotoGallery), for: .touchUpInside)
        print("leftArrowButton is pressed")
    }

    @objc func pushPhotoGallery() {
        let photoRootVC = SecondPhotoViewController()
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        self.navigationController?.pushViewController(photoRootVC, animated: true)
    }

    @objc func fingerTap() {
        print("fingerTap was called")
        lazy var photoRootVC = SecondPhotoViewController()
        self.navigationController?.pushViewController(photoRootVC, animated: true)
    }

    //MARK: -LIKES COUNT FUNC
    func likesTap(post: Post) -> String {
        print("firstPost likesTap")
        let currentLikesCount = post.likes
        var newLikesCount = Int()

        if currentLikesCount + 1 != post.likes + 1 {
            newLikesCount = post.likes + 1
        } else if currentLikesCount + 1 == post.likes + 1 {
            newLikesCount = post.likes - 1
        } else {
            newLikesCount = 0
        }

        let newLikesCountString = String(newLikesCount)
        print("Количество лайков теперь = newLikesCountString")
        return newLikesCountString
    }

    // MARK: - PRESENT PostView
    @objc func presentFirstPostView() {
        present(ViewFirstPost(post: firstPostFull), animated: true)
        PostTableViewCell.firstPostViewsRecount()
        self.tableView1.reloadData()
    }

    @objc func presentSecondPostView() {
        present(ViewFirstPost(post: secondPostFull), animated: true)
        PostTableViewCell.firstPostViewsRecount()
        self.tableView1.reloadData()
    }

    @objc func presentThirdPostView() {
        present(ViewFirstPost(post: thirdPostFull), animated: true)
        PostTableViewCell.firstPostViewsRecount()
        self.tableView1.reloadData()
    }

    @objc func presentFourthPostView() {
        present(ViewFirstPost(post: fourthPostFull), animated: true)
        PostTableViewCell.firstPostViewsRecount()
        self.tableView1.reloadData()
    }
}

// MARK: - fetchData extension
extension ProfileVC {

    func fetchPostData() -> [Post] {
        return [firstPost, secondPost, thirdPost, fourthPost]
    }

    func fetchPhotoData() -> [UIImage] {
        return previewArrayOfCollectionViewImg
    }
}
let selectedPost = arrayOfPosts

// MARK: - tableView extension
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        else if section == 1 { return 1 }
        else if section == 2 { return 1 }
        else if section == 3 { return 1 }
        else if section == 4 { return 1 }
        else { return 0 }
    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            cell.tableViewViewsLabel.textColor = UIColor.red
        }
//            let post = arrayOfPosts[indexPath.row]
//            let newView = String(1)
//            cell.tableViewViewsLabel.textColor = UIColor.red
//            cell.tableViewViewsLabel.text = "Views: " + String(post.views)
//        }
//                checked[indexPath.row] = !checked[indexPath.row]
                tableView.reloadRows(at: [indexPath], with: .automatic)
    }
            //OR
//            cell.tableViewLikesLabel.backgroundColor = UIColor.green
//        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)




        ///
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
//            print("Tapped cell : \(cell)")
//            print("Tapp On cell:", indexPath)
//        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell0 = tableView.dequeueReusableCell(withIdentifier: Cells.phCollectionID, for: indexPath) as? PhotoCollectionTableViewCell else { fatalError("Unable to dequeReusableCell") }
            cell0.phSet(ph: photoContent[indexPath.item])
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
            cell0.addGestureRecognizer(tapGesture)
            return cell0
        }

        //MARK: - POST CELLS
        else if indexPath.section == 1 {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post1[indexPath.row]
            cell1.set(post: post)
            cell1.tag = indexPath.row

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentFirstPostView))
            cell1.addGestureRecognizer(tapGesture)
            return cell1
        }

        else if indexPath.section == 2 {
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post2[indexPath.row]
            cell2.set(post: post)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentSecondPostView))
            cell2.addGestureRecognizer(tapGesture)
            return cell2
        }

        else if indexPath.section == 3 {
            guard let cell3 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post3[indexPath.row]
            cell3.set(post: post)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentThirdPostView))
            cell3.addGestureRecognizer(tapGesture)
            return cell3
        }

        else if indexPath.section == 4 {
            guard let cell4 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post4[indexPath.row]
            cell4.set(post: post)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentFourthPostView))
            cell4.addGestureRecognizer(tapGesture)
            return cell4
        }
        return UITableViewCell()
    }

    // MARK: -heightForRowAt (высота ячейки tableView)
    // photoCollectionView height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let height: CGFloat = 120.0
            return height
        } else if indexPath.section == 1 {
            let height: CGFloat = 526.0
            return height
        } else if indexPath.section == 2 {
            let height: CGFloat = 526.0
            return height
        } else if indexPath.section == 3 {
            let height: CGFloat = 526.0
            return height
        } else if indexPath.section == 4 {
            let height: CGFloat = 526.0
            return height
        }
        return CGFloat()
    }
}
