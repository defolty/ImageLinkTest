//
//  ImageDetailController.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 17.04.2022.
//

import UIKit
 
class ImageDetailController: UIViewController {
    
    @IBOutlet weak var fullSizeImage: UIImageView!
    @IBOutlet var pinchGestureOutlet: UIPinchGestureRecognizer!
    
    private let cache = NSCache<NSNumber, UIImage>()
    var selectedImage: UIImage?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullSizeImage.image = selectedImage
        navigationController?.hidesBarsOnTap = true
    }
    
    @IBAction func pinchTapped(_ sender: UIPinchGestureRecognizer) {
        guard let gestureView = pinchGestureOutlet.view else { return }
        
        gestureView.transform = gestureView.transform.scaledBy(x: pinchGestureOutlet.scale,
                                                               y: pinchGestureOutlet.scale)
        pinchGestureOutlet.scale = 1
        
        if pinchGestureOutlet.state == .began {
            navigationController?.isNavigationBarHidden = true
        }
        
        if pinchGestureOutlet.state == .changed {
            navigationController?.isNavigationBarHidden = true
        }
        
        if pinchGestureOutlet.state == .ended {
            UIView.animate(withDuration: 0.5) {
                self.fullSizeImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.navigationController?.isNavigationBarHidden = false
            }
        }
    }
}
