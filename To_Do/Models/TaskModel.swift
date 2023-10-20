//
//  TaskModel.swift
//  To_Do
//
//  Created by Anna Ershova on 19.10.2023.
//

import Foundation

struct TaskModel: Hashable, Codable, Identifiable {
    var id = UUID()
    let name: String
    var completed: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case completed
    }
}
