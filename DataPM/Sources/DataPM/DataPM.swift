import Foundation
import CoreData


protocol IDataService {
    func encodeData<T: Codable>(type: T.Type, withData data: T?) -> Data?
    func decodeData<T: Codable>(type: T.Type, withData data: Data?) -> T?
    func saveData()
    func deleteAll(name: String)
}

public class DataService: IDataService {
    public var context: NSManagedObjectContext?
       
    private var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores { descrip, error in
            if let error = error {
                print("error with container: ", error.localizedDescription)
            }
        }
        return container
    }()
    
    public init() {
        self.context = container.viewContext
    }
    
    public func saveData() {
        if let _ = context?.hasChanges {
            do { try context?.save() }
            catch {
                context?.rollback()
                fatalError("Unresolved error")
            }
        }
        //print("data saved")
    }
    
    public func encodeData<T: Codable>(type: T.Type, withData data: T?) -> Data? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            print("encoded data")
            return encoded
        }
        return nil
    }
    
    public func decodeData<T: Codable>(type: T.Type, withData data: Data?) -> T? {
        let decoder = JSONDecoder()
        if let data = data {
            if let content = try? decoder.decode(T.self, from: data) {
                print("decoded data")
                return content
            }
        }
        return nil
    }
    
    public func checkIfDataIsEmpty(name: String) -> Bool {
        var isEmpty: Bool {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
                let count  = try context?.count(for: request)
                print(count == 0)
                return count == 0
            }
            catch {
                print("catch error")
                return true
            }
        }
        return isEmpty
    }
    
    public func deleteAll(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let items = try? context?.fetch(fetchRequest)
        for item in items ?? [] {
            context?.delete(item as! NSManagedObject)
        }
        try? context?.save()
    }
}

