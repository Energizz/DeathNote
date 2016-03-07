//
//  People.swift
//  DeathNote
//
//  Created by Valentin Martin on 26/02/16.
//  Copyright © 2016 Valentin Martin. All rights reserved.
//

import Foundation
import UIKit

class People {
    
    /* Var */
    
    var first_name : String
    var last_name : String
    var date_death : String
    var circumstance : String
    var path_picture : UIImage!
    var longitude : String
    var latitude : String
    
    /* Constructeur */
    
    init() {
        self.first_name = ""
        self.last_name = ""
        self.date_death = ""
        self.circumstance = ""
        self.path_picture = nil
        self.longitude = ""
        self.latitude = ""
    }
    
    /* Setters */
    
    func setFirstname(data: NSString) {
        self.first_name = data as String
    }
    
    func setLastname(data: NSString) {
        self.last_name = data as String
    }
    
    func setDateDeath(data: NSString) {
        self.date_death = data as String
    }
    
    func setCircumstance(data: NSString) {
        self.circumstance = data as String
    }
    
    func setPathPicture(data: UIImage) {
        self.path_picture = data as UIImage
    }
    
    func setLongitude(data: String) {
        self.longitude = data as String
    }
    
    func setLatitude(data: String) {
        self.latitude = data as String
    }
    
    /* Getters */
    
    internal func getFirstname() -> NSString {
        return self.first_name
    }
    
    internal func getLastname() -> NSString {
        return self.last_name
    }
    
    internal func getDateDeath() -> NSString {
        return self.date_death
    }
    
    internal func getCircumstance() -> NSString {
        return self.circumstance
    }
    
    internal func getPathPicture() -> UIImage {
        return self.path_picture
    }
    
    internal func getLongitude() -> String {
        return self.longitude
    }
    
    internal func getLatitude() -> String {
        return self.latitude
    }
}
