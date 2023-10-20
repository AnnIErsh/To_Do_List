//
//  InjectedWrapper.swift
//  To_Do
//
//  Created by Anna Ershova on 19.10.2023.
//

import Foundation

@propertyWrapper
struct Injected<T: AnyObject> {
    private var service: T?
    private weak var serviceManager = ServiceLocator.shared
    
    public var wrappedValue: T? {
        mutating get {
            if (service == nil) {
                service = serviceManager?.getService(type: T.self)
            }
            return service
        }
        
        mutating set {
            service = newValue
        }
    }
    
    public var projectedValue: Injected<T> {
        get { return self }
        set { self = newValue }
    }
}
