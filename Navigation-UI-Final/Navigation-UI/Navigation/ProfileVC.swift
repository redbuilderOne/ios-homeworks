//
//  ProfileVC.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 18.02.2022.
//

import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(profileHeaderView)
        configureUI()
    }

    private func configureUI() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor),
            profileHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileHeaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
