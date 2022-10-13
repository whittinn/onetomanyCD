//
//  CDVehicle+CoreDataProperties.swift
//  onetomanyCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//
//

import Foundation
import CoreData


extension CDVehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDVehicle> {
        return NSFetchRequest<CDVehicle>(entityName: "CDVehicle")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var name: String?
    @NSManaged public var toPerson: CDPerson?
    
    func covertToVehicle()->Vehicle{
        return Vehicle(id: self.id!, name: self.name!, type: self.type!)
    }

}

extension CDVehicle : Identifiable {

}
