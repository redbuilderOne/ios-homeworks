
import UIKit

class PostTableViewCell: UITableViewCell {

    var tableImageView = UIImageView()
    var tableViewTitleLabel = UILabel()
    var tableViewDescriptionLabel = UILabel()
    var tableViewLikesLabel = UILabel()
    var tableViewViewsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(tableImageView)
        addSubview(tableViewTitleLabel)
        addSubview(tableViewDescriptionLabel)
        addSubview(tableViewLikesLabel)
        addSubview(tableViewViewsLabel)

        configureTableImageView()
        configureTableViewTitleLabel()
        configureTableViewDescriptionLabel()
        configureTableViewLikesLabel()
        configureTableViewViewsLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        tableViewTitleLabel.frame = CGRect(x: 16, y: 16, width: self.frame.width-16, height: 40)

        tableImageView.frame = CGRect(x: 0, y: 64, width: tableImageView.frame.size.width, height: 300)
        tableImageView.contentMode = .scaleAspectFill

        tableViewDescriptionLabel.frame = CGRect(x: 16, y: 46+tableImageView.frame.size.height, width: self.frame.width-16, height: 100)

        tableViewLikesLabel.frame = CGRect(x: 16, y:316+tableViewDescriptionLabel.frame.size.height, width: self.frame.width, height: 40)

        tableViewViewsLabel.frame = CGRect(x: 320, y: 316+tableViewDescriptionLabel.frame.size.height, width: self.frame.width, height: 40)

        NSLayoutConstraint.activate([
            tableViewTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableViewTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableViewTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableViewTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            tableImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            tableViewDescriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableViewDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -16),
            tableViewDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableViewDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            tableViewLikesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableViewLikesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableViewLikesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableViewLikesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            tableViewViewsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableViewViewsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableViewViewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableViewViewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }

    // присваиваем значения из Post к созданным элементам
    public func set(post: Post) {
        tableImageView.image = post.image
        tableViewTitleLabel.text = post.title
        tableViewDescriptionLabel.text = post.description
        tableViewLikesLabel.text = "Likes: " + String(post.likes)
        tableViewViewsLabel.text = "Views: " + String(post.views)
    }

    public func countLikes(post: Post) {
//        tableViewLikesLabel.text = "Likes: " + String(post.likes) + ProfileVC.likesTap()
    }

    private func configureTableImageView() {
        tableImageView.contentMode = .scaleAspectFit
        tableImageView.backgroundColor = .black
        tableImageView.translatesAutoresizingMaskIntoConstraints = false
        tableImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        tableImageView.clipsToBounds = true
    }

    private func configureTableViewTitleLabel() {
        tableViewTitleLabel.font = .boldSystemFont(ofSize: 20)
        tableViewTitleLabel.textColor = .black
        tableViewTitleLabel.numberOfLines = 2
        tableViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableViewTitleLabel.adjustsFontSizeToFitWidth = true
        tableViewTitleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        tableViewTitleLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    }

    private func configureTableViewDescriptionLabel() {
        tableViewDescriptionLabel.font = .systemFont(ofSize: 14)
        tableViewDescriptionLabel.textColor = .systemGray
        tableViewDescriptionLabel.numberOfLines = 0
        tableViewDescriptionLabel.adjustsFontSizeToFitWidth = true
        tableViewDescriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        tableViewDescriptionLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    }

    private func configureTableViewLikesLabel() {
        tableViewLikesLabel.font = .systemFont(ofSize: 16)
        tableViewLikesLabel.textColor = .black
        tableViewLikesLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureTableViewViewsLabel() {
        tableViewViewsLabel.font = .systemFont(ofSize: 16)
        tableViewViewsLabel.textColor = .black
        tableViewViewsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
