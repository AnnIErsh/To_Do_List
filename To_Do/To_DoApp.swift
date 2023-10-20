//
//  To_DoApp.swift
//  To_Do
//
//  Created by Anna Ershova on 12.10.2023.
//

import SwiftUI

@main
struct To_DoApp: App {
    @Configurated var config: ()
    
    init() {
        config
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
