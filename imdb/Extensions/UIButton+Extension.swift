//
//  UIButton+Extension.swift
//  imdb
//
//  Created by apple on 23/10/22.
//

import UIKit

extension UIButton {
    func setFavourite(favourite: Bool?) {
        let image = (favourite ?? false) ? UIImage(named: "selected_tag")! : UIImage(named: "unselected_tag")!
        self.setImage(image, for: .normal)
    }
}

