//
//  CoreDataHelper.swift
//  Movie
//
//  Created by Phincon on 10/07/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    
    // MARK: - Singleton
    static let shared = CoreDataHelper()
    
    // MARK: - Core Data Stack
    private init() {
        // Prevent external initialization
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer
        
        if let bundle = Bundle(identifier: "form.Domain") {
            guard let modelURL = bundle.url(forResource: "MovieDB", withExtension: "momd") else {
                fatalError("Failed to find data model")
            }
            guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Failed to load data model")
            }
            container = NSPersistentContainer(name: "MovieDB", managedObjectModel: managedObjectModel)
        } else {
            fatalError("Framework bundle not found")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving Support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror)
            }
        }
    }
    
    // MARK: - CRUD Operations
    func createEntity<T: NSManagedObject>(entityName: String) -> T? {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
        let object = NSManagedObject(entity: entity, insertInto: context) as? T
        return object
    }
    
    func fetchEntities<T: NSManagedObject>(entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    func deleteEntity(_ entity: NSManagedObject) {
        context.delete(entity)
        saveContext()
    }
    
    func deleteAllEntities(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            
        }
    }
}
