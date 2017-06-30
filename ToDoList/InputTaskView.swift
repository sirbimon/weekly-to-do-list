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
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    func setupView() {
        Bundle.main.loadNibNamed("InputTaskView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}

