
import UIKit

class PostTableViewCell: UITableViewCell {

    var tableImageView = UIImageView()
    var tableViewTitleLabel = UILabel()
    var tableViewDescriptionLabel = UILabel()
    var tableViewLikesLabel = UILabel()
    var tableViewViewsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(tableImageView)
        contentView.addSubview(tableViewTitleLabel)
        contentView.addSubview(tableViewDescriptionLabel)
        contentView.addSubview(tableViewLikesLabel)
        contentView.addSubview(tableViewViewsLabel)

        confContentView()
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

        tableViewTitleLabel.anchor(top: contentView.topAnchor,
                                   left: contentView.leftAnchor,
                                   paddingTop: 16,
                                   paddingLeft: 16,
                                   paddingBottom: 12,
                                   width: self.frame.width,
                                   height: self.frame.height)

        tableImageView.backgroundColor = .black
        tableImageView.contentMode = .scaleAspectFit
        tableImageView.anchor(top: tableViewTitleLabel.bottomAnchor,
                              left: contentView.leftAnchor,
                              bottom: tableViewDescriptionLabel.topAnchor,
                              right: contentView.rightAnchor,
                              paddingTop: 12,
                              paddingLeft: 0,
                              paddingRight: 0,
                              paddingBottom: 16,
                              width: self.frame.width,
                              height: self.frame.height)

        tableViewDescriptionLabel.anchor(top: tableImageView.bottomAnchor,
                                         left: contentView.leftAnchor,
                                         right: contentView.rightAnchor,
                                         paddingTop: 16,
                                         paddingLeft: 16,
                                         paddingRight: 0,
                                         width: self.frame.width,
                                         height: self.frame.height)

        tableViewLikesLabel.anchor(top: tableViewDescriptionLabel.bottomAnchor,
                                   left: contentView.leftAnchor,
                                   bottom: contentView.bottomAnchor,
                                   paddingTop: 16,
                                   paddingLeft: 16,
                                   paddingRight: 0,
                                   width: 120,
                                   height: 40)

        tableViewViewsLabel.anchor(top: tableViewDescriptionLabel.bottomAnchor,
                                   bottom: contentView.bottomAnchor,
                                   right: contentView.rightAnchor,
                                   paddingTop: 16,
                                   paddingLeft: 0,
                                   paddingRight: -16,
                                   width: 120,
                                   height: 40)
    }

    // присваиваем значения из Post к созданным элементам
    public func set(post: Post) {
        tableImageView.image = post.image
        tableViewTitleLabel.text = post.title
        tableViewDescriptionLabel.text = post.description
        tableViewLikesLabel.text = "Likes: " + String(post.likes)
        tableViewViewsLabel.text = "Views: " + String(post.views)
    }

    static func firstPostViewsRecount() {
        let newView = 1
        firstPost.views = firstPost.views + newView

        //        let currentNumberOfViews = String(firstPost.views)
        //        if currentNumberOfViews != currentNumberOfViews {
        //            firstPost.views = firstPost.views + newView
        //        } else {
        //            return
        //        }
    }

    public func countLikes(post: Post) {
        //        tableViewLikesLabel.text = "Likes: " + String(post.likes) + "1"
    }

    //    func likesTap() -> String {
    //        print("firstPost likesTap")
    //        let currentLikesCount = post.likes
    //        var newLikesCount = Int()
    //
    //        if currentLikesCount + 1 != post.likes + 1 {
    //            newLikesCount = post.likes + 1
    //        } else if currentLikesCount + 1 == post.likes + 1 {
    //            newLikesCount = post.likes - 1
    //        } else {
    //            newLikesCount = 0
    //        }
    //
    //        let newLikesCountString = String(newLikesCount)
    //        print("Количество лайков теперь = newLikesCountString")
    //        return newLikesCountString
    //    }

    private func confContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    private func configureTableImageView() {
        tableImageView.contentMode = .scaleAspectFit
        tableImageView.backgroundColor = .black
        tableImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        tableImageView.clipsToBounds = true
    }

    private func configureTableViewTitleLabel() {
        tableViewTitleLabel.font = .boldSystemFont(ofSize: 20)
        tableViewTitleLabel.textColor = .black
        tableViewTitleLabel.numberOfLines = 2
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
    }

    private func configureTableViewViewsLabel() {
        tableViewViewsLabel.font = .systemFont(ofSize: 16)
        tableViewViewsLabel.textColor = .black
    }
}
