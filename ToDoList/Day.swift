//
//  Day.swift
//  ToDoList
//
//  Created by Bimonaretga on 6/29/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import Foundation

class Day {
    var day: String
    var items = [Item]()
    
    init(day: String) {
        self.day = day
    }
    
}

class Item {
    var name: String
    var description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
