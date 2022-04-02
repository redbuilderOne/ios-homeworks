
import UIKit

class ExpandedPostVC: UIViewController {

    lazy var viewForPost1 = UIView()
    lazy var viewForPost2 = UIView()
    lazy var viewForPost3 = UIView()
    lazy var viewForPost4 = UIView()

    //MARK: - UIElements
    lazy var tableImageView = UIImageView()
    lazy var tableViewTitleLabel = UILabel()
    lazy var tableViewFullTextP1 = UITextField()

    func setupPost1() {
        tableImageView.image = firstPost.image
        tableViewTitleLabel.text = text1Title
        tableViewFullTextP1.frame = CGRect(x: 20, y: 20, width: 640, height: 2200)
        tableViewFullTextP1.text = text1
        tableViewFullTextP1.font = .systemFont(ofSize: 14)
        tableViewFullTextP1.textColor = .black
        tableViewFullTextP1.textAlignment = .justified
    }


    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollView = UIScrollView(frame: CGRect(x: 16, y: 16, width: view.frame.size.width - 20, height: view.frame.size.height - 20))
        scrollView.contentSize = CGSize(width: 640, height: 2200)
        scrollView.backgroundColor = .systemGray6
        view.addSubview(scrollView)

        scrollView.addSubview(tableViewFullTextP1)
        setupPost1()

    }

//    private func setupScrollView(){
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }

//    private func confPostViews() {
//        //        viewForPost1.
//
//        NSLayoutConstraint.activate([
//            tableViewFullText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            tableViewFullText.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
//            tableViewFullText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            tableViewFullText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
//            tableViewFullText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
//        ])


//        tableViewFullText.anchor(left: contentView.leftAnchor,
//                              right: contentView.rightAnchor,
//                              paddingLeft: 16,
//                              paddingRight: 16,
//                              height: 50)



//        NSLayoutConstraint.activate([
//            viewForPost1.topAnchor.constraint(equalTo: contentView.topAnchor),
//            viewForPost1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            viewForPost1.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            viewForPost1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])

//        tableViewTitleLabel.frame = CGRect(x: 16, y: 16, width: 150, height: 40)
//        tableImageView.frame = CGRect(x: 0, y: 64, width: tableImageView.frame.size.width, height: 300)
//        tableViewDescriptionLabel.frame = CGRect(x: 16, y: 46+tableImageView.frame.size.height, width: 150, height: 100)
//        tableViewLikesLabel.frame = CGRect(x: 16, y:316+tableViewDescriptionLabel.frame.size.height, width: 150, height: 40)
//        tableViewViewsLabel.frame = CGRect(x: 320, y: 316+tableViewDescriptionLabel.frame.size.height, width: 150, height: 40)

//        tableImageView.contentMode = .scaleAspectFill
//
//        NSLayoutConstraint.activate([
//        tableViewTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//        tableViewTitleLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
//        tableImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//        tableImageView.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 120),
//        tableViewDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//        tableViewDescriptionLabel.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 24),
//        tableViewLikesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//        tableViewLikesLabel.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 48),
//        tableViewViewsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//        tableViewViewsLabel.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 48)
//    ])
//
//        tableImageView.anchor(width: 150, height: 150)
//}
//
//    }
//
    }


let text1Title = "Когда рушится мир: как быстро привести себя в порядок в невыносимой ситуации"
