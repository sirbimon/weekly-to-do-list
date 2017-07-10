import Foundation
import CoreData

class DataStore {
    var days = [Day]()
    var items = [Item]()

    static let sharedInstance = DataStore()
    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchData() {
        let context = persistentContainer.viewContext
        let dayRequest: NSFetchRequest<Day> = Day.fetchRequest()
        let itemRequest: NSFetchRequest<Item> = Item.fetchRequest()

        do {
            days = try context.fetch(dayRequest)
            items = try context.fetch(itemRequest)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    func generateData() {
        let context = persistentContainer.viewContext
        let week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

        for days in week {
            let day = Day(context: context)
            day.name = "\(days)"
            let item = Item(context: context)
            day.addToItems(item)
            self.saveContext()
        }
        self.fetchData()
    }


    func specifyDayPerItem(day: Day, item: Item) {
        item.day = day
        day.addToItems(item)
    }

}

