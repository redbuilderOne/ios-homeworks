
import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    lazy var headerView = UIView()

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

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        postContent = fetchPostData()
        photoContent = fetchPhotoData()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        configureViewForProfileHeader()
        headerView.addSubview(profileHeaderView)
        view.addSubview(tableView1)
        confTableView()
        configureProfileHeaderViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Configurations
    private func configureViewForProfileHeader() {
        headerView.backgroundColor = .systemGray6
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        tableView1.anchor(top: profileHeaderView.showStatusButton.safeAreaLayoutGuide.topAnchor,
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
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        self.navigationController?.pushViewController(photoRootVC, animated: true)
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell0 = tableView.dequeueReusableCell(withIdentifier: Cells.phCollectionID, for: indexPath) as? PhotoCollectionTableViewCell else { fatalError("Unable to dequeReusableCell") }
            cell0.phSet(ph: photoContent[indexPath.item])
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerTap))
            cell0.addGestureRecognizer(tapGesture)

//            PhotoCollectionTableViewCell.leftArrowButton.addGestureRecognizer(tapGesture)
            return cell0
        }

        else if indexPath.section == 1 {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post1[indexPath.row]
            cell1.set(post: post)
            return cell1
        }

        else if indexPath.section == 2 {
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post2[indexPath.row]
            cell2.set(post: post)
            return cell2
        }

        else if indexPath.section == 3 {
            guard let cell3 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post3[indexPath.row]
            cell3.set(post: post)
            return cell3
        }

        else if indexPath.section == 4 {
            guard let cell4 = tableView.dequeueReusableCell(withIdentifier: Cells.postCellID, for: indexPath) as? PostTableViewCell else { fatalError("Unable to dequeReusableCell") }
            let post = post4[indexPath.row]
            cell4.set(post: post)
            return cell4
        }
        return UITableViewCell()
        //let post = postContent[indexPath.row]
    }

    // MARK: -heightForRowAt (высота ячейки tableView)
    // photoCollectionView height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let height: CGFloat = 120.0
            return height
        } else if indexPath.section == 1 {
            let height: CGFloat = 460.0
            return height
        } else if indexPath.section == 2 {
            let height: CGFloat = 460.0
            return height
        } else if indexPath.section == 3 {
            let height: CGFloat = 460.0
            return height
        } else if indexPath.section == 4 {
            let height: CGFloat = 460.0
            return height
        }
        return CGFloat()
    }
}
