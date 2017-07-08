import UIKit

class TaskViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let inputTaskView = InputTaskView()
    let store = DataStore.sharedInstance
    var currentDay : Day!
    //populate the array with this:
    var tasks = [Item]()
    
    @IBOutlet weak var daylabel: UILabel!

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
        reloadTableView()
    }
    
    override func viewDidLayoutSubviews() {
        let offset = CGPoint(x: 0, y: 80)
        tableView.setContentOffset(offset, animated: false)
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
            reloadTableView()
        }

    }
    
    func reloadTableView() {
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
            firstItem.id = Int64(tasks.count + 1)
            currentDay.addToItems(firstItem)
            inputTaskView.taskTextLable?.text = ""
            reloadTableView()
        }
        store.saveContext()
        print("context has saved")
    }
    

}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        if let unwrappedTask = tasks[indexPath.row].descriptor {
            cell.textLabel?.text = unwrappedTask
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
}
