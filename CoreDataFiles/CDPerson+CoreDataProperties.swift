//
//  CDPerson+CoreDataProperties.swift
//  onetomanyCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//
//

import Foundation
import CoreData


extension CDPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPerson> {
        return NSFetchRequest<CDPerson>(entityName: "CDPerson")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var toVehicle: Set<CDVehicle>?
    
    func convertToPerson()->Person{
        return Person(id: self.id!, name: self.name!, Vehicle: self.convertToVehicle())
    }
    
    func convertToVehicle()->[Vehicle]?{
        guard self.toVehicle != nil && self.toVehicle?.count != 0 else{
            return nil
        }
        var array = [Vehicle]()
        
        self.toVehicle?.forEach({ vehicle in
            array.append(vehicle.covertToVehicle())
        })
        return array
    }

}

// MARK: Generated accessors for toVehicle
extension CDPerson {

    @objc(addToVehicleObject:)
    @NSManaged public func addToToVehicle(_ value: CDVehicle)

    @objc(removeToVehicleObject:)
    @NSManaged public func removeFromToVehicle(_ value: CDVehicle)

    @objc(addToVehicle:)
    @NSManaged public func addToToVehicle(_ values: Set<CDVehicle>)

    @objc(removeToVehicle:)
    @NSManaged public func removeFromToVehicle(_ values: Set<CDVehicle>)

}

extension CDPerson : Identifiable {

}
