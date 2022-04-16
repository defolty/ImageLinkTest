//
//  CollectionViewController.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 17.04.2022.
//

import UIKit

private let reuseIdentifier = "Cell"
 
// MARK: UICollectionViewDataSource

extension CollectionViewController {
     
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModel.imagesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
          
        if let url = URL(string: imageModel.imagesArray[indexPath.row]) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async {
                    cell.forImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        return cell
    }
}

class CollectionViewController: UICollectionViewController {
    
    var links = [""]
    
    var imageModel = Image()
    
    var orientationChange = false
    
    let mainUrl = "https://it-link.ru/test/images.txt"
    let photo = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqNZNZvSkBzt5rPSmUNYKNG1MpuC6h1LppdQ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        getLinks()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPaths = collectionView.indexPathsForSelectedItems{
//                let destinationController = segue.destination as! ImageDetailController
//                destinationController.fullSizeImage = imageModel.imagesArray[indexPaths[0].row]
//                collectionView.deselectItem(at: indexPaths[0], animated: false)
//            }
//        }
//    }
    
    private func getLinks() {
        if let url = URL(string: mainUrl) {
            do {
                let contents = try String(contentsOf: url)
                //print("contents", contents)
                  
                let allLinks = contents.components(separatedBy: "\r\n")
                //print("allLinks", allLinks) // на выходе без ковычек .compactMap { URL(string: $0) })
                
                links = allLinks.filter { $0.contains("image") }
                
                imageModel.imagesArray = allLinks.filter { $0.contains("image") }
                 
            } catch {
                print("contents could not be loaded")
            }
        } else {
            print("bad url")
        }
    }
}
