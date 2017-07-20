//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Sejan Miah on 7/20/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import Foundation

class TaskViewModel {
    var currentDay: Day!
    var tasks = [Item]()
    let store = DataStore.sharedInstance

    func generateItem(task: String) {
        let context = self.store.persistentContainer.viewContext
        let item = Item(context: context)
        item.descriptor = task
        if let id = tasks.first?.id {
            item.id = id + 1
        } else {
            item.id = 0
        }
        tasks.insert(item, at: 0)
        currentDay.addToItems(item)
        self.store.saveContext()

    }

    func generateNumberOfRows()-> Int {
        let unwrappedItems = self.currentDay.items?.count ?? 0
        return unwrappedItems
    }


    func setupViews(_ currentDay: Day)-> String {
        return currentDay.name?.uppercased() ?? ""
    }

    func setupItems(completion: ()-> ()) {
        if let itemsInADay = self.currentDay.items {
            let items = Array(itemsInADay) as! [Item]
            tasks = items
            tasks = tasks.sorted(by: { $0.id > $1.id })
        }
        completion()
    }

}
