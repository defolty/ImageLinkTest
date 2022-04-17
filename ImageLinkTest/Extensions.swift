//
//  Extensions.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 17.04.2022.
//

import UIKit
 
extension CollectionViewController {
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width - 0,
                                               y: self.view.frame.size.height - 0,
                                               width: 230, height: 55))
         
        toastLabel.center = self.view.center
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.tag = 1
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveEaseOut,
                       animations: { toastLabel.alpha = 0.0 },
                       completion: {(isCompleted) in toastLabel.removeFromSuperview()})
    }
}
