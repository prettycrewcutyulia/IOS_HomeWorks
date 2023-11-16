//
//  Wish+CoreDataProperties.swift
//  yuvgudoshnikovaPW2
//
//  Created by Юлия Гудошникова on 16.11.2023.
//
//

import Foundation
import CoreData


extension Wish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wish> {
        return NSFetchRequest<Wish>(entityName: "Wish")
    }

    @NSManaged public var wish: String?

}

extension Wish : Identifiable {

}
