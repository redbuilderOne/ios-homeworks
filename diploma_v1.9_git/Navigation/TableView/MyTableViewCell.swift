
import UIKit

class PhotoCollectionTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCVLayout()
        self.collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(self.collectionView)
        collectionView.addSubview(photosLabel)
        collectionView.addSubview(PhotoCollectionTableViewCell.leftArrowButton)
        confCollectionView()
        confUIElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: -CollectionView UIElements
    static let leftArrowButton = NewButton(color: .black, title: "", systemImageName: "arrow.right")

    var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        photosLabel.text = "Photos"
        photosLabel.font = .boldSystemFont(ofSize: 24)
        photosLabel.textColor = .black
        return photosLabel
    }()

    func confUIElements() {
        photosLabel.frame = CGRect(x: 12, y: 12, width: 70, height: 40)
        photosLabel.anchor(top: self.topAnchor, paddingTop: -6, height: 50)
        PhotoCollectionTableViewCell.leftArrowButton.frame = CGRect(x: 12, y: -12, width: 30, height: 30)
        PhotoCollectionTableViewCell.leftArrowButton.anchor(top: self.topAnchor, paddingTop: -6, width: 50, height: 50)
        PhotoCollectionTableViewCell.leftArrowButton.configuration?.baseForegroundColor = .black
        PhotoCollectionTableViewCell.leftArrowButton.configuration?.baseBackgroundColor = .systemBackground
        PhotoCollectionTableViewCell.leftArrowButton.addTarget(self, action: #selector(pushProfileVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            photosLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            photosLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            PhotoCollectionTableViewCell.leftArrowButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            PhotoCollectionTableViewCell.leftArrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor)
        ])
    }

    @objc func pushProfileVC() {
        let photoRootVC = ProfileVC()
        lazy var photoNavVC = UINavigationController(rootViewController: photoRootVC)
        print("TRY TO PUSH ProfileVC")
//        self.navigationController?.pushViewController(photoRootVC, animated: true)
    }


    // MARK: - PhotoTableViewCell
    var previewCollectionViewCells: [UIImage] = previewArrayOfCollectionViewImg
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var selectedIndex: IndexPath?

    func updateCellWith(row: [UIImage]) {
        self.collectionView.reloadData()
    }

    func phSet(ph: UIImage) {
        self.collectionView.reloadData()
    }

    func createCVLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 1
        // отсупы внутри ячейки
        layout.sectionInset = UIEdgeInsets(top: 42, left: 12, bottom: 12, right: 12)
        layout.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        collectionView = UICollectionView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height), collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
    }

    func confCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - Extension CollectionView
extension PhotoCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previewArrayOfCollectionViewImg.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCollectionView(image: previewArrayOfCollectionViewImg[indexPath.row])
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 80)
    }
}
