//
//  FeedVC.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 18.02.2022.
//

import UIKit

class FeedVC: UIViewController {

    var stackView = UIStackView()

    //let buttonNext = NewButton(color: .systemPink, title: "Next", systemImageName: "chevron.up.square")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureStackView()

        //      configureNextButton()
    }

    func configureStackView() {
        view.addSubview(stackView)

        addButtonsToStackView()

        // axis - horizontal or vertical
        stackView.axis = .vertical

        // all the buttons fill the entire stackview equal size
        stackView.distribution = .fillEqually

        // spacing between each button
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

            // we name each button from 1 to 2
            button.setTitle("\(i)", for: .normal)

            //adding these buttons to the stackView
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(showPostOne), for: .touchUpInside)
        }
    }

    // func configureNextButton() {
//        view.addSubview(buttonNext)
//        buttonNext.addTarget(self, action: #selector(showPostOne), for: .touchUpInside)
//        NSLayoutConstraint.activate([
//            buttonNext.widthAnchor.constraint(equalToConstant: 250),
//            buttonNext.heightAnchor.constraint(equalToConstant: 50),
//            buttonNext.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            buttonNext.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }

    @objc func showPostOne() {
        show(PostVC(), sender: nil)
    }

}
