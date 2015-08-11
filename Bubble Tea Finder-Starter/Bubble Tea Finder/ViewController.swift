//
//  ViewController.swift
//  Bubble Tea Finder
//
//  Created by Pietro Rea on 8/24/14.
//  Copyright (c) 2014 Pietro Rea. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,FilterViewControllerDelegate {
  
    func filterViewController(filter: FilterViewController, didSelectPredicate predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?) {
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = nil
        if let fetchPredicate = predicate{
            fetchRequest.predicate = fetchPredicate
        }
        if let sr = sortDescriptor{
            fetchRequest.sortDescriptors = [sr]
        }
        fetchAndReload()
    }
    
  @IBOutlet weak var tableView: UITableView!
  var coreDataStack: CoreDataStack!
    //定义fetchRequest
    var fetchRequest:NSFetchRequest!
    var venues:[Venue]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //模版查询
//    fetchRequest = coreDataStack.model.fetchRequestTemplateForName("FetchRequest")
    fetchRequest = NSFetchRequest(entityName: "Venue")
    fetchAndReload()
  }
  
    func fetchAndReload(){
        var error:NSError?
        let results = coreDataStack.context.executeFetchRequest(fetchRequest, error: &error) as! [Venue]?
        if let fetchedResults = results{
            venues = fetchedResults
        }else{
            println("Cloud not fetch \(error),\(error!.userInfo)")
        }
        tableView.reloadData()
    }
    
  func tableView(tableView: UITableView?,
    numberOfRowsInSection section: Int) -> Int {
      return venues.count
  }
  
  func tableView(tableView: UITableView!,
    cellForRowAtIndexPath
    indexPath: NSIndexPath!) -> UITableViewCell! {
      
      var cell = tableView.dequeueReusableCellWithIdentifier("VenueCell") as! UITableViewCell
        let venue = venues[indexPath.row]
      cell.textLabel!.text = venue.name
      cell.detailTextLabel!.text = venue.priceInfo.priceCategory
      
      return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "toFilterViewController" {
      
      let navController = segue.destinationViewController as! UINavigationController
      let filterVC = navController.topViewController as! FilterViewController
        filterVC.coreDataStack = coreDataStack
        filterVC.delegate = self
    }
  }
  
  @IBAction func unwindToVenuListViewController(segue: UIStoryboardSegue) {
    
  }
}

