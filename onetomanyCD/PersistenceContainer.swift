//
//  PersistenceContainer.swift
//  onetomanyCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation
import CoreData

class PersistenceContainer{
    private init () {}
    
    static let shared = PersistenceContainer()
    
   lazy var persistenceContainer: NSPersistentContainer = {
        
        var persistenceContainer = NSPersistentContainer(name: "onetomanyCD")
        persistenceContainer.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError{
                
                fatalError("Unresolved Error: \(error), \(error.localizedDescription)")
            }
        }
        return persistenceContainer
    }()
    
    lazy var context = persistenceContainer.viewContext
    
    func save(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let error = error as NSError
                print(error)
            }
           
        }
    }
    
    func fetchManagedObject<T:NSManagedObject>(managedObject:T.Type)-> [T]?{
        
        do{
            guard let results =  try PersistenceContainer.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return  nil}
            return results
        }catch{
            let error = error as NSError
            print(error)
        }
return nil
        
    }
}
