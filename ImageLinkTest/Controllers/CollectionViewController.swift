//
//  CollectionViewController.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 17.04.2022.
//

import UIKit

private let reuseIdentifier = "Cell"
 
// MARK: - UICollectionViewLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: screenWidth / 2.1, height: screenWidth / 2.1)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
 
// MARK: - UICollectionViewDataSource

extension CollectionViewController {
     
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.imagesArray.count
    }
      
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionViewCell else { return }
                
        let itemNumber = NSNumber(value: indexPath.item)
          
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            
            cell.forImage.image = cachedImage
        } else {
            self.loadImage(currentUrl: imageModel.imagesArray[indexPath.row]) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                print("start download")
                
                cell.forImage.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
    } 
}

class CollectionViewController: UICollectionViewController {
     
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
                    
    private let screenWidth = UIScreen.main.bounds.size.width
    
    private var imageModel = Image()
     
    private let mainUrl = "https://it-link.ru/test/images.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        getLinks() 
    }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
                let destinationController = segue.destination as! ImageDetailController
                let cell = sender as! CollectionViewCell
                
                destinationController.selectedImage = cell.forImage.image
        }
    }
    
    // MARK: - Image Loading
    
    private func loadImage(currentUrl: String, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            let url = URL(string: currentUrl)!
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    private func getLinks() {
        if let url = URL(string: mainUrl) {
            do {
                let contents = try String(contentsOf: url)
                let allLinks = contents.components(separatedBy: "\r\n")
                imageModel.imagesArray = allLinks.filter { $0.contains("image") }
            } catch {
                print("contents could not be loaded")
            }
        } else {
            print("bad url")
        }
    }
}
