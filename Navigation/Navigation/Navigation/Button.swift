//
//  Button.swift
//  Navigation
//
//  Created by Дмитрий Скворцов on 19.02.2022.
//

import UIKit

class NewButton: UIButton {

    // we need to OVERRIDE INIT because we want to use our method "cofigure()" to add our own special configurations
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // we dont have storyboard thats why we need this code
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // we create func to configure settings of any UIButton
    init(color: UIColor, title: String, systemImageName: String) {
        
        // constraints ( .zero = CGRect ) zero height, zero widhth, zero coordinates (x, y, h, w)
        super.init(frame: .zero)

        // кастомизация кнопки
        configuration = .tinted()
        configuration?.title = title
        configuration?.baseForegroundColor = color
        configuration?.baseBackgroundColor = color
        configuration?.cornerStyle = .medium

        // устанавливаем SF Symbol
        configuration?.image = UIImage(systemName: systemImageName)

        configuration?.imagePadding = 5
        configuration?.imagePlacement = .trailing
        translatesAutoresizingMaskIntoConstraints = false
    }

}
