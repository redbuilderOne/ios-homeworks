//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 19.02.2022.
//

import UIKit

class PostVC: UIViewController {

    lazy var postImageView = UIImageView()

    lazy var posts = [firstPost]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post View Controller"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(showInfoVC))
        title = firstPost.title
        view.backgroundColor = .systemTeal
    }

    @objc func showInfoVC() {
        present(InfoVC(), animated: true)
    }

    func createBarButtonItemNV() -> UINavigationController {
        let barButtonNV = InfoVC()
        barButtonNV.title = "InfoVC"
        barButtonNV.tabBarItem.image = UIImage(named: "icons8-Material Filled-List")
        barButtonNV.tabBarItem.selectedImage = UIImage(named: "icons8-Material Two Tone-89421-50-ffffff")

        return UINavigationController(rootViewController: barButtonNV)
    }

}
