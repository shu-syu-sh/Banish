//
//  BanishImage+CoreDataProperties.swift
//  Banish
//
//  Copyright © 2016年 ShuSyuSh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BanishImage {

    @NSManaged var image: NSData?
    @NSManaged var banish: BanishEntity?

}
