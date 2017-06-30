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
        refreshControl.addTarget(nil, action: #selector(refreshInitiated), for: .allTouchEvents)
        //refreshControl.backgroundColor = .red
        refreshControl.tintColor = .white
        tableView.addSubview(refreshControl)
    }
    
    func setupInputTaskView() {
        refreshControl.addSubview(inputTaskView)
        inputTaskView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (refreshControl.frame.height))
        //inputTaskView.taskTextLable.addTarget(nil, action: #selector(finishCreatingTask), for: .editingDidEndOnExit)
    }
    
    func refreshInitiated() {
        
    }
    
    func finishCreatingTask() {
        print(inputTaskView.taskTextLable.text)
        refreshControl.endRefreshing()
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
