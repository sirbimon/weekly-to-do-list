import UIKit

class TaskViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let inputTaskView = InputTaskView()
    let store = DataStore.sharedInstance

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        setupInputTaskView()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchData()
        self.tableView.reloadData()
    }
    
    func setupRefresh() {
        refreshControl.addTarget(nil, action: #selector(refreshInitiated), for: .valueChanged)
        refreshControl.tintColor = .white
        tableView.addSubview(refreshControl)
    }
    
    func setupInputTaskView() {
        refreshControl.addSubview(inputTaskView)
        inputTaskView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (refreshControl.frame.height))
        inputTaskView.addTaskButton.addTarget(self, action: #selector(finishCreatingTask), for: .touchDown)
    }
    
    @objc func refreshInitiated() {
        print("pull refresh control")
        inputTaskView.taskTextLable.text = ""
        inputTaskView.layer.opacity = 1.0
    }
    
    @objc func finishCreatingTask() {
        if inputTaskView.addTaskButton.isSelected {

        let context  = store.persistentContainer.viewContext
        let firstItem = Item(context: context)
        if let task = inputTaskView.taskTextLable.text, task != "" {
            print(task)
            firstItem.descriptor = task
            inputTaskView.layer.opacity = 0.0
            refreshControl.endRefreshing()
        }
        store.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
    }


}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return  UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
}
