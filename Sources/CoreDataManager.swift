//
//  CoreDataManager.swift
//  MVVMSwift
//
//  Created by David Seca on 14.07.22.
//  Copyright (c) 2022 David Seca. All rights reserved.
//

import Foundation
import CoreData

/// Manager for packing CoreData persistence container
public class CoreDataManager {

    /// Private constructor
    private init() {}

    /// Shared instance
    static let shared = CoreDataManager()

    /// Context to manipulate and track changes to managed objects
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    /// A container that encapsulates the Core Data stack in your app.
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MVVMSwift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - CoreData Saving support

    /// Attempts to commit unsaved changes to registered objects to the context’s parent store
    /// - parameters:
    ///    - completion: Completion callback
    private func save(completion: @escaping () -> Void) {
        if context.hasChanges {
            do {
                try context.save()
                completion()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - CoreData Fetching support

    /// Fetch array of items of the specified type that meet the fetch request’s critieria through completion
    /// - parameters:
    ///    - type: Which properties to fetch
    ///    - completion: Callback with array of items of the specified type that meet the fetch request’s critieria
    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        do {
            let objects = try context.fetch(request)
            completion(objects)
        } catch {
            print(error)
            completion([])
        }
    }

    // MARK: - CoreData Clearing support

    /// Deletes objects in the SQLite persistent store without loading them into memory.
    ///    - type: Which properties to delete
    ///    - completion: Completion callback
    private func clear<T: NSManagedObject>(_ type: T.Type, completion: @escaping () -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            completion()
        } catch let error as NSError {
            print(error)
        }
    }

    // MARK: - CoreData Save and fetch

    /// Dave and fetch and array of items of the specified type that meet the fetch request’s critieria through completion
    /// - parameters:
    ///   - type: Which properties to save and fetch
    ///   - completion: Callback with array of items of the specified type that meet the fetch request’s critieria
    func saveAndFetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T]) -> Void) {
        self.clear(type) {
            self.save {
                self.fetch(type) { objects in
                    completion(objects)
                }
            }
        }
    }
    
}
