//
//  TaskViewModel.swift
//  To_Do
//
//  Created by Anna Ershova on 19.10.2023.
//

import Foundation
import DataPM

final class TaskViewModel: ObservableObject {
    @Injected var data: DataService?
    @Published var tasks: [TaskModel] = [] {
        didSet {
            addTasksToData(newData: tasks)
        }
    }
    
    var toCange: String {
        get {
            tasks.first?.name ?? ""
        }
        set {
            tasks.append(TaskModel(name: newValue, completed: false))
        }
    }

    func addTasksToData(newData: [TaskModel]?) {
        let entities = TaskEntity(context: (data?.context)!)
        entities.tasks = data?.encodeData(type: [TaskModel].self, withData: newData)
        data?.saveData()
        print("tasks added", newData as Any)
    }
    
    private func getTasksFromData() {
        let requests = TaskEntity.fetchRequest()
        var mapped: [TaskModel]?
        do {
            let tmps = try data?.context?.fetch(requests) ?? []
            for i in tmps {
                let dec = data?.decodeData(type: [TaskModel].self, withData: i.tasks)
                mapped = dec
                print("decode Tasks from core data")
                print(i)
            }
        }
        catch {
            print("error getting tasks")
        }
        data?.saveData()
        self.tasks = mapped ?? []
    }
    
    func loadTasksFromData() {
        if let res = data?.checkIfDataIsEmpty(name: "TaskEntity") {
            if res {
                print("no tasks are loaded")
            }
            else {
                getTasksFromData()
            }
        }
    }
    
    func removeData() {
        data?.deleteAll(name: "TaskEntity")
    }
    
    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
