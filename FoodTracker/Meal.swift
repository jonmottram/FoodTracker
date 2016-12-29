//
//  Meal.swift
//  FoodTracker
//
//  Created by Jon Mottram on 12/28/16.
//  Copyright © 2016 Jon Mottram. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?( name: String, photo: UIImage?, rating: Int ) {
        
        //  The name needs to be non-empty
        guard !name.isEmpty else {
            return nil
        }
        
        //  The rating needs to be between 0 and 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //  Initialize stored parameters
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
