//
//  ProfileVC.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 18.02.2022.
//

import UIKit

class ProfileVC: UIViewController {

    lazy var profileHeaderView = ProfileHeaderView()
    var newProfileVCButton = NewButton(color: .white, title: "New Button", systemImageName: "eye")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(profileHeaderView)
        view.addSubview(newProfileVCButton)
        configureUI()
    }

    private func configureUI() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.anchor(top: view.safeAreaLayoutGuide.topAnchor, height: 220)

        NSLayoutConstraint.activate([
            profileHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileHeaderView.heightAnchor.constraint(equalTo: view.heightAnchor),
            profileHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileHeaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            newProfileVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        newProfileVCButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
