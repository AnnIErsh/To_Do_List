//
//  ServiceLocator.swift
//  To_Do
//
//  Created by Anna Ershova on 19.10.2023.
//

import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()
    
    lazy var services: [String: AnyObject] = {
        return [String: AnyObject]()
    }()
    
    func addServices<T: AnyObject>(service: T) {
        let key = String(describing: T.self)
        if services[key] == nil {
            services[key] = service
        }
    }
    
    func getService<T: AnyObject>(type: T.Type) -> T? {
        let key = String(describing: T.self)
        return services[key] as? T
    }
}
