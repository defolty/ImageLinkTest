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
     
    var selectedImage: UIImage?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnTap = true
        fullSizeImage.image = selectedImage
    }
    
    @IBAction func pinchTapped(_ sender: UIPinchGestureRecognizer) {
        guard let gestureView = pinchGestureOutlet.view else { return }
        
        gestureView.transform = gestureView.transform.scaledBy(x: pinchGestureOutlet.scale,
                                                               y: pinchGestureOutlet.scale)
        pinchGestureOutlet.scale = 1
        
        switch pinchGestureOutlet.state {
        case .began, .changed:
            print("view has been moved")
        case .ended:
            UIView.animate(withDuration: 0.5) {
                self.fullSizeImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.navigationController?.isNavigationBarHidden = false
            }
        default:
            print("default case .state")
        } 
    }
}
