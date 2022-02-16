//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Дмитрий Скворцов on 15.02.2022.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    private func loadViewFromXib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProfileView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    var view: UIView!
    var nibName: String = "ProfileView"
    
}
