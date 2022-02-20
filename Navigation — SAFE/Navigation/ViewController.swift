//
//  ViewController.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {

    // создаем кнопку, описываем ее свойства
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        // добавляем созданную кнопку как subview
        view.addSubview(button)

        // создаем tabbar контроллер без параметров в скобке
        let tabBarVC = UITabBarController()

        //rootViewController чтобы сверху после нажатия показывалось название (то есть местоположение после нажатия на кнопку на tabbar)
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        let vc3 = UINavigationController(rootViewController: ThirdViewController())
        let vc4 = UINavigationController(rootViewController: FourthViewController())
        let vc5 = UINavigationController(rootViewController: FifthViewController())

        // Здесь текст кнопки на tabbar будет показываться до того, как на нее нажали
        vc1.title = "First"
        vc2.title = "Second"
        vc3.title = "Third"
        vc4.title = "Fourth"
        vc5.title = "Fifth"

        // устанвливаем ViewController
        // каждый tab привязн к ViewController
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        // [] - array of ViewControllers
        // animated: false = без анимации

        // добавляем изображения нашим кнопкам на tabbar
        guard let items = tabBarVC.tabBar.items else { return }

        // создаем array для изображений
        let images = ["person", "iphone.homebutton", "bell", "house", "gear"]
        // важно чтобы количество картинок соответствовало количетву vc

        // for loop генерирует картинки по очереди начиная с индекса 0 и до 5
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }


        // каким образом будет презентоваться tabbar
        tabBarVC.modalPresentationStyle = .fullScreen
        
        // презентуем наш tabBar controller
        present(tabBarVC, animated: true)



    }

}

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        // отображаемый текст на кнопке
        title = "First"
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Second"
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "Thrid"
    }
}

class FourthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Fourth"
    }
}

class FifthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        title = "Fifth"
    }
}
