import UIKit

class TaskViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let inputTaskView = InputTaskView()
    let vm = WeeklyViewModel()
    let store = DataStore.sharedInstance
    var currentDay: Day!
    //populate the array with this:
    var tasks = [Item]()
    var dayCell: DayCellView!
    var headerHeight: CGFloat = 50
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupGradientBG()
        setupInputHeader()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.generateData()
        self.tableView.reloadData()
        setupItems()
    }
    
    override func viewDidLayoutSubviews() {
        offSetTableView()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        dayLabel.text = currentDay.name?.uppercased()
    }
    
    func setupTableView() {
        //tableView.separatorColor = UIColor.clear
    }
    
    func setupInputHeader() {
        tableView.tableHeaderView = inputTaskView
       // inputTaskView.backgroundColor = UIColor.blue
        inputTaskView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight)
        inputTaskView.addTaskButton.addTarget(self, action: #selector(finishCreatingTaskHeaderOption), for: .touchDown)
    }
    
    
    func setupGradientBG() {
        let newLayer = CAGradientLayer()
        print("setupgradientBG")
        let pink = UIColor(hex: 0xFFA3A3)
        let purple = UIColor(hex: 0xA3AEFB)
        newLayer.colors = [purple.cgColor, pink.cgColor]
        newLayer.frame = view.frame
        view.layer.insertSublayer(newLayer, at: 0)
    }
    
    func setupItems() {
        if let itemsInADay = currentDay.items {
            let items = Array(itemsInADay) as! [Item]
            tasks = items
            tasks = tasks.sorted(by: { $0.id > $1.id })
            print("tasks:")
            for (index, task) in tasks.enumerated() {
                //print(task.descriptor, "id:", task.id, "index:", index)
            }
            reloadTableViewWithOffset()
        }
        
    }
    
    func offSetTableView() {
        let offset = CGPoint(x: 0, y: headerHeight)
        tableView.setContentOffset(offset, animated: false)
    }
    
    func reloadTableViewWithOffset() {
        tableView.reloadData()
        offSetTableView()
    }
    
    
    @objc func finishCreatingTaskHeaderOption() {
        let context  = store.persistentContainer.viewContext
        let firstItem = Item(context: context)
        if let task = inputTaskView.taskTextLable.text, task != "" {
            
            firstItem.descriptor = task
            
            if let id = tasks.first?.id {
                firstItem.id = id + 1
            } else {
                firstItem.id = 0
            }
            
            tasks.insert(firstItem, at: 0)
            currentDay.addToItems(firstItem)
            inputTaskView.taskTextLable?.text = ""
            print("the task:", firstItem.descriptor!, "id:", firstItem.id)
            setupItems()
        }
        store.saveContext()
    }



}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
       cell.textLabel?.text = tasks[indexPath.row].descriptor ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentDay!.items!.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {

            let item  = tasks[indexPath.row]
            store.deleteItem(item)
            DispatchQueue.main.async {
                self.setupItems()
            }
        }
    }
    

}
