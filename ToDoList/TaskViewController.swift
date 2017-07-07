import UIKit

class TaskViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let inputTaskView = InputTaskView()
    let store = DataStore.sharedInstance
    
    //populate the array with this:
    var tasks = [String]()
    

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupGradientBG()
        setupInputHeader()
        //setupRefresh()
        //setupInputTaskView()
        
        //self.navigationController?.navigationBar.tintColor = UIColor.clear
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchData()
        self.tableView.reloadData()
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
    
//    func setupRefresh() {
//        refreshControl.addTarget(nil, action: #selector(refreshInitiated), for: .valueChanged)
//        refreshControl.tintColor = .clear
//        tableView.addSubview(refreshControl)
//    }
//    
//    @objc func refreshInitiated() {
//        print("pull refresh control")
//        inputTaskView.taskTextLable.text = ""
//        inputTaskView.layer.opacity = 1.0
//    }
    
    func setupInputTaskView() {
        refreshControl.addSubview(inputTaskView)
        inputTaskView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (refreshControl.frame.height))
        inputTaskView.addTaskButton.addTarget(self, action: #selector(finishCreatingTask), for: .touchDown)
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
    
    
    @objc func finishCreatingTask() {
        let context  = store.persistentContainer.viewContext
        let firstItem = Item(context: context)
        if let task = inputTaskView.taskTextLable.text, task != "" {
            print(task)
            firstItem.descriptor = task
            inputTaskView.layer.opacity = 0.0
            tasks.append(task)
            refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
        store.saveContext()
        print("context has saved")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func finishCreatingTaskHeaderOption() {
        let context  = store.persistentContainer.viewContext
        let firstItem = Item(context: context)
        if let task = inputTaskView.taskTextLable.text, task != "" {
            print(task)
            firstItem.descriptor = task
            tasks.append(task)
            tableView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
            inputTaskView.taskTextLable?.text = ""
            self.tableView.reloadData()
        }
        store.saveContext()
        print("context has saved")
    }

}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
}
