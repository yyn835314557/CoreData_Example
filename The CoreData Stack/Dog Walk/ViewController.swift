//
//  ViewController.swift
//  Dog Walk
//
//  Created by Pietro Rea on 7/10/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
  
    var managedContext:NSManagedObjectContext!
    
  @IBOutlet var tableView: UITableView!
  var walks:Array<NSDate> = []
    var currentDog:Dog!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let dogEntity = NSEntityDescription.entityForName("Dog", inManagedObjectContext: managedContext)
    
    let dog = Dog(entity: dogEntity!, insertIntoManagedObjectContext: managedContext)
    
    let dogName = "Fido"
    let dogFetch = NSFetchRequest(entityName: "Dog")
    dogFetch.predicate = NSPredicate(format: "name == %@", dogName)
    
    var error:NSError?
    let result = managedContext.executeFetchRequest(dogFetch, error: &error) as! [Dog]?
    
    if let dogs = result{
        if dogs.count == 0{
            currentDog = Dog(entity: dogEntity!, insertIntoManagedObjectContext: managedContext)
            currentDog.name = dogName
            
            if !managedContext.save(&error){
                println("Could not save: \(error)")
            }
        }else{
            currentDog = dogs[0]
        }
    }else{
        println("Could not fetch:\(error)")
    }
    
    tableView.registerClass(UITableViewCell.self,
      forCellReuseIdentifier: "Cell")
  }
  
  func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    
        var numRows = 0
        if let dog = currentDog{
            numRows = dog.walks.count
        }
      return numRows;
  }
  
  func tableView(tableView: UITableView,
    titleForHeaderInSection section: Int) -> String? {
      return "List of Walks";
  }
  
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath
    indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell =
      tableView.dequeueReusableCellWithIdentifier("Cell",
      forIndexPath: indexPath) as! UITableViewCell
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .ShortStyle
    dateFormatter.timeStyle = .MediumStyle
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_cn")
    
        let walk = currentDog.walks[indexPath.row] as! Walk
        
//    let date =  walks[indexPath.row]
        //ko_kr ja_jp zh_tw
      cell.textLabel!.text = dateFormatter.stringFromDate(walk.date)
    
    return cell
  }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            //1
            let walkToRemove = currentDog.walks[indexPath.row] as! Walk
            //2
            let walks = currentDog.walks.mutableCopy() as! NSMutableOrderedSet
            walks.removeObjectAtIndex(indexPath.row)
            currentDog.walks = walks.copy() as! NSOrderedSet
            //3
            managedContext.deleteObject(walkToRemove)
            //4
            var error:NSError?
            if !managedContext.save(&error){
                println("Could not save:\(error)")
            }
            //5
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
    }
  
  @IBAction func add(sender: AnyObject) {
//    walks.append(NSDate())
    // insert new Walk entity into Core Data
    let walkEntity = NSEntityDescription.entityForName("Walk", inManagedObjectContext: managedContext)
    let walk = Walk(entity: walkEntity!, insertIntoManagedObjectContext: managedContext)
    walk.date = NSDate()
    
    //Insert the new Walk into the Dog's walks set
    var walks = currentDog.walks.mutableCopy() as! NSMutableOrderedSet
    walks.addObject(walk)
    currentDog.walks = walks.copy() as! NSOrderedSet
    
    //Save the managed object context
    var error:NSError?
    if !managedContext.save(&error){
        println("Could not save:\(error)")
    }
    
    tableView.reloadData()
  }
  
}

