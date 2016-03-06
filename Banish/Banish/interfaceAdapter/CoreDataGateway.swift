//
//  CoreDataGateway.swift
//  Banish
//
//  Copyright © 2016年 ShuSyuSh. All rights reserved.
//

import Foundation
import CoreData

class CoreDataGateway {
    
}

class BackgroundCoreDataStack {
    
    let workerContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    let persistentContext: NSManagedObjectContext
    
    init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        self.workerContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        self.mainContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.persistentContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        
        workerContext.parentContext = mainContext
        mainContext.parentContext = persistentContext
        self.persistentContext.persistentStoreCoordinator = psc
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
            This code uses a file named "DataModel.sqlite" in the application's documents directory.
            */
            let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
}
