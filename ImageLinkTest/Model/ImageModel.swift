//
//  Model.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 16.04.2022.
//

import Foundation

struct Image { 
    var imagesArray: Array = [""]
}

/*
 struct Place {
     
     var name: String
     var location: String
     var type: String
     var image: String
     
     
     static let restaurantName = [
         "Burger Heroes", "Kitchen", "Love&Life", "Morris Pub",
         "Sherlock Holmes", "Speak Easy", "X.O", "Балкан Гриль",
         "Бочка", "Вкусные истории", "Дастархан",
         "Индокитай", "Классик", "Шок", "Bonsai"
     ]

     static func getPlaces() -> [Place] {
         var places = [Place]()
         
         for place in restaurantName {
             places.append(Place(name: place, location: "Ekaterinburg", type: "Restaurant", image: place))
         }
         
         return places
     }
 */

/*
 func filterImages(matching prefix: String) -> [String] {
     return imagesArray?.filter( { $0.hasPrefix(prefix) } ) ?? ["none"]
 }
 */

/*
 func filterImages(matching prefix: String) -> [String] {
    return imagesArray.filter( { $0.hasPrefix(prefix) } )
 }
 */

/* 
 init(images: [String]) {
     self.imagesArray = images.filter({ $0.hasPrefix("https") })
 }
 */
