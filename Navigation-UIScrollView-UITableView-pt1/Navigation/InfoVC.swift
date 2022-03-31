//
//  InfoVC.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 19.02.2022.
//

import UIKit

class InfoVC: UIViewController {

    let buttonAlert = NewButton(color: .systemRed, title: "Alert", systemImageName: "xmark.shield")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureAlertButton()
    }

    private func configureAlertButton() {
        view.addSubview(buttonAlert)
        buttonAlert.addTarget(self, action: #selector(showAlert), for: .touchUpInside)

        NSLayoutConstraint.activate([
            buttonAlert.widthAnchor.constraint(equalToConstant: 250),
            buttonAlert.heightAnchor.constraint(equalToConstant: 50),
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func showAlert() {
        Alert.showBasicAlert(on: self, with: "Alert", message: "Alert Message")
    }
}
