import UIKit

class TaskViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let inputTaskView = InputTaskView()
    let store = DataStore.sharedInstance
    var currentDay : Day!
    //populate the array with this:
    var tasks = [Item]()
    

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupGradientBG()
        setupInputHeader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchData()
        self.tableView.reloadData()
        reloadTableViewWithOffset()
    }
    
    override func viewDidLayoutSubviews() {
        offSetTableView()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        //tableView.separatorColor = UIColor.clear
    }
    
    func setupInputHeader() {
        tableView.tableHeaderView = inputTaskView
       // inputTaskView.backgroundColor = UIColor.blue
        inputTaskView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80)
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
            print("tasks:", tasks.count)
            reloadTableViewWithOffset()
        }
        
    }
    
    func offSetTableView() {
        let offset = CGPoint(x: 0, y: 80)
        tableView.setContentOffset(offset, animated: false)
    }
    
    func reloadTableViewWithOffset() {
        tableView.reloadData()
        let offset = CGPoint(x: 0, y: 80)
        tableView.setContentOffset(offset, animated: false)
    }
    
    
    @objc func finishCreatingTaskHeaderOption() {
        let context  = store.persistentContainer.viewContext
        let firstItem = Item(context: context)
        if let task = inputTaskView.taskTextLable.text, task != "" {
            print(task)
            firstItem.descriptor = task
            tasks.insert(firstItem, at: 0)
            currentDay.addToItems(firstItem)
            tableView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
            inputTaskView.taskTextLable?.text = ""
            reloadTableViewWithOffset()
        }
        store.saveContext()
        print("context has saved")
    }

}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let tasks = Array(self.currentDay!.items!)
        cell.textLabel?.textColor = UIColor.white
          cell.textLabel?.text = (tasks[indexPath.row] as AnyObject).descriptor
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentDay!.items!.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let tasks = Array(self.currentDay!.items!)
             let item  = tasks[indexPath.row] as! Item
            print("The item \(item.descriptor!) is being deleted")
            store.deleteItem(item)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

}
