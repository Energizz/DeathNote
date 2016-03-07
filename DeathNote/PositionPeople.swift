//
//  PositionPeople.swift
//  DeathNote
//
//  Created by Valentin Martin on 28/02/16.
//  Copyright © 2016 Valentin Martin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PositionPeople : UIViewController {
    
    /* Var */
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var NavTitle: UINavigationItem!
    let annotation = MKPointAnnotation()
    var longitude : String = ""
    var latitude : String = ""
    
    /* ViewDid... */
    
    override func viewDidLoad() {
        let logo = UIImage(named: "small_death_note.jpg")
        let imageViewNavTitle = UIImageView(image:logo)
        imageViewNavTitle.contentMode = .ScaleAspectFit
        self.NavTitle.titleView = imageViewNavTitle
    }
    
    override func viewDidAppear(animated: Bool) {
        let alertController = UIAlertController(title: "Ryuk", message:
            "You can specify a location for his death by holding down on the map.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /* Action from Storyboard */
    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        let location = sender.locationInView(self.MapView)
        let locCoord = self.MapView.convertPoint(location, toCoordinateFromView: self.MapView)
        annotation.coordinate = locCoord
        annotation.title = "Here ?"
        annotation.subtitle = "Ryuk : Mmmh okay, but give me an apple."
        self.MapView.addAnnotation(annotation)
        self.longitude = String(locCoord.longitude)
        self.latitude = String(locCoord.latitude)
    }
}
