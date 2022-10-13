//
//  BaseRepository.swift
//  onetomanyCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation
import CoreData

protocol BaseRepository{
    
    associatedtype T
    
    func create(record:T)
    func getAll()->[T]?
    func getItem(byIdentifier id:UUID)->T?
    func update(record:T)->Bool
    func delete(by id:UUID)->Bool
    
}

protocol PersonRepository: BaseRepository{
    
    
}

protocol VehicleRepository: BaseRepository{
    
}

struct PersonDataRepository: PersonRepository{
    func create(record: Person) {
        let person = CDPerson(context: PersistenceContainer.shared.context)
        person.name = record.name
        person.id = record.id

        var vehicleSet = Set<CDVehicle>()
        if record.Vehicle != nil{
            record.Vehicle?.forEach({ vehicless in
                let vehicle = CDVehicle(context: PersistenceContainer.shared.context)
                vehicle.id = vehicless.id
                vehicle.name = vehicless.name
                vehicle.type = vehicless.type
                
                vehicleSet.insert(vehicle)
            })
            person.toVehicle = vehicleSet
            PersistenceContainer.shared.save()

        }
    }

    func getAll() -> [Person]? {
        let records = PersistenceContainer.shared.fetchManagedObject(managedObject: CDPerson.self)
        guard records?.count ?? 0 > 0 else {return nil}
        
        var results = [Person]()
        records?.forEach({ person in
            results.append(person.convertToPerson())
        })
        return results
    }

    func getItem(byIdentifier id: UUID) -> Person? {
        let records = self.getVechileById(by:id )
        guard records != nil else {return nil}
        return records?.convertToPerson()
    }

    func update(record: Person) -> Bool {
        let records = self.getVechileById(by: record.id)
        guard records != nil else {return false}
        records?.name = record.name
        PersistenceContainer.shared.save()
        return true
    }

    func delete(by id: UUID) -> Bool {
        let record = self.getVechileById(by: id)
        guard record != nil else {return false}
        PersistenceContainer.shared.context.delete(record!)
        PersistenceContainer.shared.save()
        return true
    }
    
    func getVechileById(by id:UUID)->CDPerson?{
        let fetchRequest = NSFetchRequest<CDPerson>(entityName: "CDPerson")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        let results = try! PersistenceContainer.shared.context.fetch(fetchRequest)
        guard results.count > 0 else {return nil}
        
        return results.first
        
        
        
    }

    typealias T = Person





}

struct VehicleDataRepository: VehicleRepository{
    func create(record: Vehicle) {
        let vehicle = CDVehicle(context: PersistenceContainer.shared.context)
        vehicle.name = record.name
        vehicle.id = record.id
        vehicle.type = record.type
        
        PersistenceContainer.shared.save()
    }
    
    func getAll() -> [Vehicle]? {
        let records = PersistenceContainer.shared.fetchManagedObject(managedObject: CDVehicle.self)
        guard records != nil && records?.count ?? 0 > 0 else {return nil}
        
        var array = [Vehicle]()
        records?.forEach({ vehicle in
            array.append(vehicle.covertToVehicle())
        })
        return array
        
    }
    
    func getItem(byIdentifier id: UUID) -> Vehicle? {
        let record = self.getVehicleById(by: id)
        guard record != nil else {return nil}
        return record?.covertToVehicle()
    }
    
    func update(record: Vehicle) -> Bool {
        let records = self.getVehicleById(by: record.id)
        guard records != nil else {return false}
        records?.type = record.type
        records?.name = records?.name
        PersistenceContainer.shared.save()
        return true
        
    }
    
    typealias T = Vehicle
    
    func delete(by id: UUID) -> Bool {
        let record = getVehicleById(by: id)
        guard record != nil else {return false}
        PersistenceContainer.shared.context.delete(record!)
        PersistenceContainer.shared.save()
        return true
    }
    
    func getVehicleById(by id:UUID)->CDVehicle?{
        let fetchRequest = NSFetchRequest<CDVehicle>(entityName: "CDVehicle")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do{
            let results = try PersistenceContainer.shared.context.fetch(fetchRequest)
            guard results.count > 0 else {return nil}
            
            return results.first
        }catch{
            let error = error as NSError
            print(error)
        }
        return nil
    }
    
    
}
