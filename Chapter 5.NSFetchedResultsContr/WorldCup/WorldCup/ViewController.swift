//
//  ViewController.swift
//  WorldCup
//
//  Created by Pietro Rea on 8/2/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import CoreData

var fetchedResultsController:NSFetchedResultsController!

class ViewController: UIViewController {
  
  var coreDataStack: CoreDataStack!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //1
    let fetchRequest = NSFetchRequest(entityName: "Team")
    //2
    fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    //3
    var error: NSError? = nil
    if (!fetchedResultsController.performFetch(&error)){
        println("Error: \(error?.localizedDescription)")
    }
}
  
  func numberOfSectionsInTableView
    (tableView: UITableView) -> Int {
      
      return fetchedResultsController.sections!.count
  }
  
  func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      
        let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
      return sectionInfo.numberOfObjects
  }

  func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      
      let resuseIdentifier = "teamCellReuseIdentifier"
      
      var cell =
      tableView.dequeueReusableCellWithIdentifier(
        resuseIdentifier, forIndexPath: indexPath)
        as! TeamCell
      
      configureCell(cell, indexPath: indexPath)
      
      return cell
  }
  
  func configureCell(cell: TeamCell, indexPath: NSIndexPath) {
     let team = fetchedResultsController.objectAtIndexPath(indexPath) as! Team
    
    cell.flagImageView.image = UIImage(named: team.imageName)
    cell.flagImageView.backgroundColor = UIColor.blueColor()
    cell.teamLabel.text = "Team Name"
    cell.scoreLabel.text = "Wins: 0"
  }
  
  func tableView(tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
  }
}

