//
//  ImageDetailController.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 17.04.2022.
//

import UIKit

class ImageDetailController: UIViewController {
    
    @IBOutlet weak var fullSizeImage: UIImageView!
    
    var imageModel = Image()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // грузить из кеша
        //fullSizeImage.image = UIImage(named: imageModel.imagesArray)
        
        if let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqNZNZvSkBzt5rPSmUNYKNG1MpuC6h1LppdQ") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.fullSizeImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    } 
}
