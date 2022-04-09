//
//import UIKit
//
//class ViewForTableView2: UIView {
//    // FOR POSTS
//    // MARK: - tableView2
//    lazy var tableView2: UITableView = {
//        let tableView2 = UITableView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height), style: .plain)
//        tableView2.translatesAutoresizingMaskIntoConstraints = false
//        tableView2.delegate = self
//        tableView2.dataSource = self
//        tableView2.rowHeight = UITableView.automaticDimension
//        tableView2.estimatedRowHeight = 44
//        tableView2.register(PostTableViewCell.self, forCellReuseIdentifier: ProfileVC.Cells.postCellID)
//        return tableView2
//    }()
//
//    var postContent: [Post] = []
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(tableView2)
//        postContent = fetchPostData()
//        confTableView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
//
//    func confTableView() {
//        NSLayoutConstraint.activate([
//            tableView2.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
//            tableView2.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//            tableView2.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//            tableView2.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
//            tableView2.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
//        ])
//    }
//}
//
//// MARK: -Extension for TableView
//extension ViewForTableView2: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 460
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return postContent.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        return UITableViewCell()
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell {
//            cell.selectionStyle = .none
//            let post = postContent[indexPath.row]
//            cell.set(post: post)
//            return cell
//        }
//        fatalError("Unable to dequeReusableCell")
//    }
//}
//
//// MARK: -Extension for fetching
//extension ViewForTableView2 {
//
//    func fetchPostData() -> [Post] {
//        return [firstPost, secondPost, thirdPost, fourthPost]
//    }
//}
