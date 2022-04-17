//
//  CollectionViewController.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 17.04.2022.
//

import UIKit
 
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Con.reuseIdentifier, for: indexPath) as! CollectionViewCell
        let itemNumber = NSNumber(value: indexPath.item)
        
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            
            /// debug toasts
            if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
            }
            /// debug toasts
            showToast(message: "cached image for item: \(itemNumber)", font: .systemFont(ofSize: 13))
            
            cell.forImage.image = cachedImage
            
        } else {
            
            self.loadImage(currentUrl: imageModel.imagesArray[indexPath.row]) {  [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.forImage.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewController

class CollectionViewController: UICollectionViewController {
     
    private let cache = NSCache<NSNumber, UIImage>()
     
    private let utilityQueue = DispatchQueue.global(qos: .utility)
                    
    private let screenWidth = UIScreen.main.bounds.size.width
    
    private var imageModel = Image()
     
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.title = ""
        cache.countLimit = 60
        getLinks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        navigationController?.hidesBarsOnTap = false
    }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Con.segueId {
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
    
// MARK: - Get Filtered Links
    
    private func getLinks() {
        if let url = URL(string: Con.mainUrl) {
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
