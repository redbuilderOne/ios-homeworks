//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Дмитрий Скворцов on 15.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        if let subview = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? UIView {
            self.view.addSubview(subview)
        }
    }

}
