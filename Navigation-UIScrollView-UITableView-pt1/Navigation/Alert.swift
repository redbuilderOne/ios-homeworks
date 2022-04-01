//
//  Alert.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 20.02.2022.
//

import UIKit

struct Alert {

    // on -> what shows up when we call the method
    // vc -> what we use in the scope of a function
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Alert Action 1
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))

        // Alert Action 2
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

        // vc: UIViewController
        vc.present(alert, animated: true)
    }
}
