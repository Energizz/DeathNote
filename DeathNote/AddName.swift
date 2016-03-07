//
//  AddName.swift
//  DeathNote
//
//  Created by Valentin Martin on 26/02/16.
//  Copyright © 2016 Valentin Martin. All rights reserved.
//

import Foundation
import UIKit

class AddName : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource,UIPickerViewDelegate {
    
    /* Var */
    
    @IBOutlet weak var DateDeath: UIDatePicker!
    @IBOutlet weak var FieldSurname: UITextField!
    @IBOutlet weak var FieldName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var PickerView: UIPickerView!
    @IBOutlet weak var NavTitle: UINavigationItem!
    let imagePicker = UIImagePickerController()
    var InformationsP = People()
    var newPositionLatitude : String = ""
    var newPositionLongitude : String = ""
    var positionCircumstance : Int = 0
    let pickerData = ["Heart attack", "Accident", "Disease", "Suicide"]
    
    /* ViewDid... */
    
    override func viewDidLoad() {
        let logo = UIImage(named: "small_death_note.jpg")
        let imageViewNavTitle = UIImageView(image:logo)
        imageViewNavTitle.contentMode = .ScaleAspectFit
        self.NavTitle.titleView = imageViewNavTitle
        PickerView.dataSource = self
        PickerView.delegate = self
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        DateDeath.minimumDate = NSDate()
    }
    
    /* Action From Storyboard */
    
    @IBAction func ButtonChoosePic(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "doneSegue" {
            if (self.FieldName.text?.isEmpty == true || self.FieldSurname.text?.isEmpty == true) {
                let alertController = UIAlertController(title: "Ryuk", message:
                    "Be careful ... Your name can be added to the Death Note if you make another mistake ...", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "doneSegue" {
            let dateFormatter = NSDateFormatter()
            InformationsP.setFirstname(self.FieldName.text!)
            InformationsP.setLastname(self.FieldSurname.text!)
            InformationsP.setLongitude(self.newPositionLongitude)
            InformationsP.setLatitude(self.newPositionLatitude)
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let strDate = dateFormatter.stringFromDate(DateDeath.date)
            InformationsP.setDateDeath(strDate)
            InformationsP.setCircumstance(self.pickerData[self.positionCircumstance])
            InformationsP.setPathPicture(imageView.image!)
        }
    }
    
    @IBAction func save(segue:UIStoryboardSegue) {
        let positionDetailVC = segue.sourceViewController as! PositionPeople
        self.newPositionLatitude = positionDetailVC.latitude
        self.newPositionLongitude = positionDetailVC.longitude
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.positionCircumstance = row
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        imageView.image = image
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
