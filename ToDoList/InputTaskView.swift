//
//  InputTaskView.swift
//  ToDoList
//
//  Created by Bimonaretga on 6/30/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import UIKit

class InputTaskView: UIView {
 
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var taskTextLable: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    func setupView() {
        Bundle.main.loadNibNamed("InputTaskView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor)
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor)
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    }
    
}

