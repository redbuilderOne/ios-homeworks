
import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    lazy var headerView = UIView()
    lazy var tableView = UITableView()
    var posts = arrayOfPosts

    struct Cells {
        static let postCell = "PostTableViewCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = .lightGray
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(headerView)
        configureViewForProfileHeader()
        headerView.addSubview(profileHeaderView)
        view.addSubview(tableView)
        configureProfileHeaderViewUI()
        configureTableViewUI()
    }

    private func configureViewForProfileHeader() {
        headerView.backgroundColor = .lightGray
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

    private func configureTableViewUI() {
        setTableViewDelegates()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Cells.postCell)
      //tableView.pin(to: profileHeaderView.showStatusButton)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.anchor(top: profileHeaderView.showStatusButton.safeAreaLayoutGuide.topAnchor,
                         left: headerView.safeAreaLayoutGuide.leftAnchor,
                         bottom: headerView.safeAreaLayoutGuide.bottomAnchor,
                         right: headerView.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 64,
                         paddingLeft: 0,
                         paddingRight: 0,
                         paddingBottom: 0)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }

    func setTableViewDelegates() {
        tableView.delegate   = self
        tableView.dataSource = self
    }
}

// MARK: - VC Extension

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
