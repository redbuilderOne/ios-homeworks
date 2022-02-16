//
//  CustomView.swift
//  Netology_IB_Instruments
//
//  Created by Дмитрий Скворцов on 15.02.2022.
//

import UIKit

class CustomView: UIView {

    override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.setupView()
        }

        private func setupView() {
            let view = self.loadViewFromXib()
            view.frame = self.bounds // здесь view, загруженная из xib-файла, добавляется на вьюху класса. Ее размер соответствует размеру вьюхе класса и растягивается так же, как и сама вьюха класса.
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(view)
        }

        private func loadViewFromXib() -> UIView {
            guard let view = Bundle.main.loadNibNamed("CustomView", owner: nil, options: nil)?.first as? UIView else { return UIView() }

            return view
        }

}
