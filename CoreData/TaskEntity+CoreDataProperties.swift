//
//  TaskEntity+CoreDataProperties.swift
//  To_Do
//
//  Created by Anna Ershova on 19.10.2023.
//
//

import Foundation
import CoreData

extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var tasks: Data?

}

extension TaskEntity : Identifiable {

}
