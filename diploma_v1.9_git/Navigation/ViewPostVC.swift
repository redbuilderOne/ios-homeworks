
import UIKit

class ViewFirstPost: UITabBarController {

    private let post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var fullPostTableView: UITableView = {
        let fullPostTableView = UITableView()
        fullPostTableView.translatesAutoresizingMaskIntoConstraints = false
        fullPostTableView.delegate = self
        fullPostTableView.dataSource = self
        fullPostTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return fullPostTableView
    }()

    private func confTableView() {
        NSLayoutConstraint.activate([
            fullPostTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullPostTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fullPostTableView.topAnchor.constraint(equalTo: view.topAnchor),
            fullPostTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fullPostTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullPostTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(fullPostTableView)
        confTableView()
    }
}

extension ViewFirstPost: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = post.title
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.imageView?.image = post.image
            cell.imageView?.contentMode = .scaleAspectFill
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = post.description
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            return cell
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return 50
        case 1:
            return 200
        case 2:
            return UITableView.automaticDimension
        default:
            fatalError()
        }
    }
}
