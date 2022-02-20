//
//  FeedVC.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 18.02.2022.
//

import UIKit



class FeedVC: UIViewController {

    let buttonNext = NewButton(color: .systemPink, title: "Next", systemImageName: "chevron.up.square")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNextButton()
    }

    func configureNextButton() {

        // добавляем кнопку на экран
        view.addSubview(buttonNext)

        // нажатие на кнопку
        buttonNext.addTarget(self, action: #selector(showPostOne), for: .touchUpInside)

        // размещаем кнопку
        NSLayoutConstraint.activate([
            buttonNext.widthAnchor.constraint(equalToConstant: 250),
            buttonNext.heightAnchor.constraint(equalToConstant: 50),
            buttonNext.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonNext.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func showPostOne() {
        show(PostVC(), sender: nil)
        //present(PostVC(), animated: true) - показывается модально
    }

}
