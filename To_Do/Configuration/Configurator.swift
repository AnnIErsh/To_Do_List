//
//  Configurator.swift
//  To_Do
//
//  Created by Anna Ershova on 19.10.2023.
//

import Foundation
import DataPM

class Configurator {
    static func register() {
        ServiceLocator.shared.addServices(service: DataService())
    }
}

@propertyWrapper
struct Configurated {
    var wrappedValue: () {
        return Configurator.register()
    }
}
