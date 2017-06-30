import UIKit

class TaskViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let inputTaskView = InputTaskView()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        setupInputTaskView()
        
        
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
    
    func refreshInitiated() {
        print("pull refresh control")
        inputTaskView.taskTextLable.text = ""
        inputTaskView.layer.opacity = 1.0
    }
    
    func finishCreatingTask() {
        if let task = inputTaskView.taskTextLable.text, task != "" {
            print(task)
            inputTaskView.layer.opacity = 0.0
            refreshControl.endRefreshing()
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
