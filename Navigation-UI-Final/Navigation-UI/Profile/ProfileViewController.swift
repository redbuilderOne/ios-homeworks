//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 21.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()

    var profileImageView = UIImageView()
    var profileLabel = UILabel()
    var statusLabel = UILabel()
    var showStatusButton = UIButton()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    private func configureProfileHeaderView() {
        profileHeaderView.pin(to: view)
    }

    private func createProfileHeaderView() {
        view.addSubview(profileHeaderView)
    }

    private func configureProfileLabel() {
        profileLabel.text = "Profile Name"
        profileLabel.font = .boldSystemFont(ofSize: 22)
    }

    private func configureStatusLabel() {
        statusLabel.text = "Learning Swift..."
        statusLabel.font = .italicSystemFont(ofSize: 14)
    }
}
