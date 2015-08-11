
//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by 游义男 on 15/8/11.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import CoreData

class CoreDataStack{
    let context:NSManagedObjectContext!
    let psc:NSPersistentStoreCoordinator!
    let model:NSManagedObjectModel!
    let store:NSPersistentStore?
    
    //    func applicationDocumentDirectory() -> NSURL{
    //            let fileManager = NSFileManager.defaultManager()
    //            let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentationDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as! [NSURL]
    //            return urls[0]
    //        }
    class func applicationDocumentsDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! [NSURL]
        return urls[0]
    }
    init(){
        //
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Dog Walk", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)
        //
        psc = NSPersistentStoreCoordinator(managedObjectModel:model)
        //
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        //
        let documentsURL = CoreDataStack.applicationDocumentsDirectory()
        let storeURL = documentsURL.URLByAppendingPathComponent("Dog Walk")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        var error: NSError? = nil
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType,configuration: nil, URL: storeURL, options: options, error:&error)
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    
    func saveContext(){
        var error:NSError? = nil
        if context.hasChanges && !context.save(&error){
            println("Could not save:\(error?.userInfo)")
        }
    }
    
}