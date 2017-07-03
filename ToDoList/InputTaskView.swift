import UIKit

class InputTaskView: UIView {
 
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTextLable: UITextField!
    let store = DataStore.sharedInstance
    var currentDay: Day?

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

    func addTask() {
        if addTaskButton.isSelected {
        }
    }
    
}

