//
//  ContentView.swift
//  To_Do
//
//  Created by Anna Ershova on 12.10.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var taskViewModel: TaskViewModel = .init()
    private var header: String = "To-Do List"
    
    var body: some View {
        VStack {
            Text(header)
                .font(.largeTitle)
            TaskScreen()
        }
        .padding()
        .environmentObject(taskViewModel)
    }
}

#Preview {
    ContentView()
}
