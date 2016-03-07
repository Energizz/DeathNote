//
//  ListName.swift
//  DeathNote
//
//  Created by Valentin Martin on 26/02/16.
//  Copyright © 2016 Valentin Martin. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ListName : UITableViewController {
    
    /* Var */
    
    @IBOutlet weak var NavTitle: UINavigationItem!
    @IBOutlet var tableViewList: UITableView!
    var list = [People]()
    var position : Int = 0
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    let fetchRequest = NSFetchRequest()
    
    /* ViewDid... */
    
    override func viewDidLoad() {
        let logo = UIImage(named: "small_death_note.jpg")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .ScaleAspectFit
        self.NavTitle.titleView = imageView
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        let entityDescription = NSEntityDescription.entityForName("People", inManagedObjectContext: appDel.managedObjectContext)
        fetchRequest.entity = entityDescription
        do {
            let result = try appDel.managedObjectContext.executeFetchRequest(fetchRequest)
            if (result.count > 0) {
                for info in result {
                    let oldPeople = People()
                    oldPeople.setFirstname(info.valueForKey("first_name") as! String)
                    oldPeople.setLastname(info.valueForKey("last_name") as! String)
                    oldPeople.setLongitude(info.valueForKey("longitude") as! String)
                    oldPeople.setLatitude(info.valueForKey("latitude") as! String)
                    oldPeople.setDateDeath(info.valueForKey("date_death") as! String)
                    oldPeople.setCircumstance(info.valueForKey("circumstance") as! String)
                    let getUIImageData = info.valueForKey("path_picture")
                    oldPeople.setPathPicture(UIImage(data:getUIImageData as! NSData)!)
                    list.append(oldPeople)
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        self.tableViewList.reloadData()
    }
    
    /* Action from Storyboard */
    
    func refresh(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entityDescription = NSEntityDescription.entityForName("People", inManagedObjectContext: appDel.managedObjectContext)
            fetchRequest.entity = entityDescription
            let context:NSManagedObjectContext = self.appDel.managedObjectContext
            do {
                let result = try appDel.managedObjectContext.executeFetchRequest(fetchRequest)
                context.deleteObject(result[indexPath.row] as! NSManagedObject)
                deleteCell(indexPath.row)
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
            self.tableViewList.reloadData()
        }
    }
        
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.position = indexPath.row
        performSegueWithIdentifier("Details", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomCell {
        let cell: CustomCell = tableViewList.dequeueReusableCellWithIdentifier("CellName") as! CustomCell
        cell.cellDateDeath!.text = list[indexPath.row].getDateDeath() as String
        cell.cellName!.text = ((list[indexPath.row].getFirstname() as String) + " " + (list[indexPath.row].getLastname() as String) as String)
        cell.cellCircumstance!.text = list[indexPath.row].getCircumstance() as String
        cell.cellImage.image = list[indexPath.row].getPathPicture() as UIImage
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func deleteCell(position: Int) {
        list.removeAtIndex(position)
        self.tableViewList.reloadData()
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let carDetailVC = segue.sourceViewController as! AddName
        var newName = People()
        newName = carDetailVC.InformationsP
        list.append(newName)
        self.tableViewList.reloadData()
        let context : NSManagedObjectContext! = self.appDel.managedObjectContext
        let newEntity = NSEntityDescription.insertNewObjectForEntityForName ("People", inManagedObjectContext: context) as NSManagedObject
        newEntity.setValue(newName.getFirstname(), forKey: "first_name")
        newEntity.setValue(newName.getLastname(), forKey: "last_name")
        newEntity.setValue(newName.getDateDeath(), forKey: "date_death")
        newEntity.setValue(newName.getCircumstance(), forKey: "circumstance")
        newEntity.setValue(newName.getLongitude(), forKey: "longitude")
        newEntity.setValue(newName.getLatitude(), forKey: "latitude")
        let transformUIImageData = UIImageJPEGRepresentation(newName.getPathPicture(), 1)! as NSData;
        newEntity.setValue(transformUIImageData, forKey: "path_picture")
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "Details") {
            let svc = segue.destinationViewController as! DetailsPeople
            svc.ObjPeople = list[self.position]
        }
    }
}
