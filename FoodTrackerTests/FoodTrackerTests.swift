//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Jon Mottram on 12/27/16.
//  Copyright © 2016 Jon Mottram. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    //MARK: Meal Class Tests
    
    //  Confirm the Mean initializer retuns a Meal object when passed valid parameters
    func testMealInitializationSuccess( ) {
        //  Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil( zeroRatingMeal )
        
        //  highest possible rating
        let positiveRatingMeal = Meal.init( name: "Positive", photo: nil, rating: 5 )
        XCTAssertNotNil( positiveRatingMeal )
    }
    
    func testMealInitializationFailure( ) {
        let largeRatingMeal = Meal.init( name: "Large", photo: nil, rating: 6 )
        XCTAssertNil( largeRatingMeal )
    }
}
