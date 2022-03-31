//
//  FeedVC.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 18.02.2022.
//

import UIKit

class FeedVC: UIViewController {

    lazy var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureStackView()
    }

    func configureStackView() {
        view.addSubview(stackView)
        addButtonsToStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func addButtonsToStackView() {
        let numberOfButons = 2

        for i in 1...numberOfButons {
            let button = StackViewButton()
            button.setTitle("\(i)", for: .normal)
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(showPostOne), for: .touchUpInside)
        }
    }

    @objc func showPostOne() {
        show(PostVC(), sender: nil)
    }
}
