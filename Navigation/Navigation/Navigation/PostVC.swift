//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 19.02.2022.
//

import UIKit



class PostVC: UIViewController {

    let postImageView = UIImageView()

    // let button1 = UIBarButtonItem(image: UIImage(named: "imagename"), style: .plain, target: self, action: Selector("action"))
    // self.navigationItem.rightBarButtonItem  = button1

    var posts = [firstPost]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Post View Controller"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showInfoVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(showInfoVC))
        // let show = UIBarButtonItem(title: "Show", style: .plain, target: self, action: #selector(showInfoVC))
        // navigationItem.rightBarButtonItems = [show]


        title = firstPost.title
        view.backgroundColor = .systemTeal

      // createBarButtonItemNV()

    }

    @objc func showInfoVC() {
        present(InfoVC(), animated: true)
        // show(InfoVC(), sender: nil) - показывается НЕ модально
    }

    @objc func showPost() {
        // postImageView.image = posts
    }

    func createBarButtonItemNV() -> UINavigationController {
        let barButtonNV = InfoVC()
        barButtonNV.title = "InfoVC"

        barButtonNV.tabBarItem.image = UIImage(named: "icons8-Material Filled-List")
        barButtonNV.tabBarItem.selectedImage = UIImage(named: "icons8-Material Two Tone-89421-50-ffffff")

        return UINavigationController(rootViewController: barButtonNV)
    }

// ПРИ НАЖАТИИ НА BAR BUTTON ITEM в Navigation Bar должен открываться новый контроллер InfoVC

}
