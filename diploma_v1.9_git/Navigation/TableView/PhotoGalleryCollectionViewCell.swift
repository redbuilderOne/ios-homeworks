
import UIKit

class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    // Свойства для управления анимацией
    var initialFrame: CGRect?
    var state: State = .collapsed
    var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    }()

    static let identifier = "PhotoGalleryCollectionViewCell"
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.configuration = .tinted()
        cancelButton.configuration?.image = UIImage(systemName: "xmark.square")
        cancelButton.layer.cornerRadius = 4
        cancelButton.configuration?.baseForegroundColor = .white
        cancelButton.configuration?.baseBackgroundColor = .black
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.clipsToBounds = true
        cancelButton.addTarget(self, action: #selector(reverseAnimation), for: .touchUpInside)
        return cancelButton
    }()

    private let navLabel: UILabel = {
        let navLabel = UILabel()
        navLabel.text = "Photo Gallery"
        navLabel.textColor = .black
        navLabel.font = .systemFont(ofSize: 24)
        return navLabel
    }()

    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        myImageView.contentMode = .scaleAspectFill
    }

    public func confgiurePhotoGalleryRow(image: UIImage) {
        myImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    //MARK: - Cell Animation
    func animateCell() {
        print("animateCell activated")
        SecondPhotoViewController.animateImageInsideCollectionView()
        expand()
    }

    // MARK: - expand() Animation Starts
    private func expand() {
        SecondPhotoViewController.phBackGroundView.addSubview(self.myImageView)
        SecondPhotoViewController.phBackGroundView.addSubview(self.cancelButton)
        self.myImageView.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.isHidden = false

        NSLayoutConstraint.activate([
            self.myImageView.centerXAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.centerXAnchor),
            self.myImageView.centerYAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.centerYAnchor),
            self.myImageView.leadingAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.leadingAnchor),
            self.myImageView.trailingAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.trailingAnchor),
            self.myImageView.bottomAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.bottomAnchor),
            self.myImageView.topAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.topAnchor),
            self.myImageView.heightAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.heightAnchor),
            self.myImageView.widthAnchor.constraint(equalTo: SecondPhotoViewController.phBackGroundView.safeAreaLayoutGuide.widthAnchor)
        ])
        self.myImageView.contentMode = .scaleAspectFit

        animator.addAnimations {
            self.cancelButton.anchor(top: self.myImageView.safeAreaLayoutGuide.topAnchor,
                                     right: self.myImageView.safeAreaLayoutGuide.rightAnchor,
                                     paddingTop: 32,
                                     paddingLeft: 0,
                                     paddingRight: 32,
                                     paddingBottom: 0,
                                     width: 30,
                                     height: 30)

            self.myImageView.layoutIfNeeded()
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

    // MARK: - collapse()
    private func collapse() {

        SecondPhotoViewController.phBackGroundView.isHidden = true
        self.contentView.addSubview(self.myImageView)
        self.myImageView.translatesAutoresizingMaskIntoConstraints = true
        self.cancelButton.isHidden = true

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

    // MARK: - REVERSE ANIMATION
    @objc func reverseAnimation() {
        print("cancelButton is tapped")
        cancelToggle()

        animator.addAnimations {
            self.myImageView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        }
        animator.startAnimation()

        func cancelToggle() {
            switch state {
            case .collapsed:
                print("collapsed case is done")
                expand()
            case .expanded:
                print("expanded case is done")
                collapse()
            }
        }
    }
}
