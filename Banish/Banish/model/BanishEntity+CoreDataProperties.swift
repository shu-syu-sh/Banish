//
//  BanishEntity+CoreDataProperties.swift
//  Banish
//
//  Copyright © 2016年 ShuSyuSh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BanishEntity {

    @NSManaged var identifier: NSNumber?
    @NSManaged var ext: String?
    @NSManaged var width: NSNumber?
    @NSManaged var height: NSNumber?
    @NSManaged var imageUrl: String?
    @NSManaged var thumbUrl: String?
    @NSManaged var relImage: BanishImage?

}
