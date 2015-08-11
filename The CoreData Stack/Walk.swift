//
//  Walk.swift
//  Dog Walk
//
//  Created by 游义男 on 15/8/11.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import Foundation
import CoreData

class Walk: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var dog: Dog

}
