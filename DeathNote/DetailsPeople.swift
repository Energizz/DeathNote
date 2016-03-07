//
//  DetailsPeople.swift
//  DeathNote
//
//  Created by Valentin Martin on 26/02/16.
//  Copyright © 2016 Valentin Martin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetailsPeople : UIViewController {
    
    /* Var */
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateDeathLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var circumstanceLabel: UILabel!
    @IBOutlet weak var MapView: MKMapView!
    let annotation = MKPointAnnotation()
    var ObjPeople = People()
    
    /* ViewDid... */
    
    override func viewDidLoad() {
        nameLabel.text = ObjPeople.getFirstname() as String
        surnameLabel.text = ObjPeople.getLastname() as String
        dateDeathLabel.text = ObjPeople.getDateDeath() as String
        image.image = ObjPeople.getPathPicture()
        self.image.layer.cornerRadius = self.image.frame.size.width/2
        self.image.clipsToBounds = true
        circumstanceLabel.text = ObjPeople.getCircumstance() as String
        
        if ((ObjPeople.getLongitude() != "") && (ObjPeople.getLatitude() != "")) {
            let locCoord:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (ObjPeople.getLatitude() as NSString).doubleValue, longitude: (ObjPeople.getLongitude() as NSString).doubleValue)
            annotation.coordinate = locCoord
            annotation.title = ObjPeople.getFirstname() as String
            annotation.subtitle = "Will die by " + (ObjPeople.getCircumstance() as String)
            self.MapView.addAnnotation(annotation)
            let mapSpan = MKCoordinateSpanMake(0.01, 0.01)
            let mapRegion = MKCoordinateRegionMake(locCoord, mapSpan)
            self.MapView.setRegion(mapRegion, animated: true)
        }
    }
}
