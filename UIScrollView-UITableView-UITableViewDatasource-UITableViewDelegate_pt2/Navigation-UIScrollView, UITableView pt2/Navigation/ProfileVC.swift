
import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    lazy var tableView = ProfileTableHeaderView()

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
        view.addSubview(profileHeaderView)
        view.addSubview(tableView)

        configureProfileHeaderViewUI()
        configureTableViewUI()
    }

    private func configureProfileHeaderViewUI() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.anchor(top: view.safeAreaLayoutGuide.topAnchor, height: 220)

        NSLayoutConstraint.activate([
            profileHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor),
            profileHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileHeaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 64,
                         paddingLeft: 0,
                         paddingRight: 0,
                         paddingBottom: 0)

        NSLayoutConstraint.activate([
         // tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setTableViewDelegates() {
        tableView.delegate   = self
        tableView.dataSource = self
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
