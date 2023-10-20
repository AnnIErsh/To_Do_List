//
//  TaskScreen.swift
//  To_Do
//
//  Created by Anna Ershova on 19.10.2023.
//

import SwiftUI

struct TaskScreen: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State private var text: String = ""

    var body: some View {
        VStack {
            Text("My tasks").modifier(ListStyle())
            currentText
            NavigationStack{
                List {
                    ForEach($taskViewModel.tasks.indices, id: \.self) { i in
                        HStack {
                            Button("") {
                                taskViewModel.tasks[i].completed.toggle()
                            }
                            .buttonStyle(ButtonStyles(tapped: $taskViewModel.tasks[i].completed))
                            .id(i)
                            Text("\(taskViewModel.tasks[i].name)")
                                .modifier(TaskTextStyle(tapped: $taskViewModel.tasks[i].completed))
                        }
                    }
                    .onDelete(perform: taskViewModel.delete(at:))
                }
            }
            .modifier(ListStyle())
            .listStyle(.plain)
            .onAppear {
                taskViewModel.loadTasksFromData()
            }
        }
    }
    
    var currentText: some View {
        TextField("add your text", text: $text) { edit in
            print("is editing \(edit)")
        } onCommit: {
            taskViewModel.toCange = text
        }
        .modifier(ClearButton(text: $text))
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
    }
}
