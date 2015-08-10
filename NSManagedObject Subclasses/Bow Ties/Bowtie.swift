//
//  Bowtie.swift
//  Bow Ties
//
//  Created by 游义男 on 15/8/9.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import Foundation
import CoreData

class Bowtie: NSManagedObject {

    @NSManaged var isFavorite: NSNumber
    @NSManaged var lastWorn: NSDate
    @NSManaged var name: String
    @NSManaged var rating: NSNumber
    @NSManaged var serachKey: String
    @NSManaged var timesWorn: NSNumber
    @NSManaged var photoData: NSData
    @NSManaged var tintColor: AnyObject

}
