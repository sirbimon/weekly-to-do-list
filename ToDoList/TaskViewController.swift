import UIKit

class TaskViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let inputTaskView = InputTaskView()
    let vm = TaskViewModel()
    var dayCell: DayCellView!
    var headerHeight: CGFloat = 50
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBG()
        setupInputHeader()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        vm.setupItems(completion: reloadTableViewWithOffset)
        setupDayLabel()
    }
    
    override func viewDidLayoutSubviews() {
        offSetTableView()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func setupDayLabel() {
        self.dayLabel.text = vm.currentDay.name

    }

    
    func setupInputHeader() {
        tableView.tableHeaderView = inputTaskView
        inputTaskView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight)
        inputTaskView.addTaskButton.addTarget(self, action: #selector(handleItemCreation), for: .touchDown)
    }
    
    
    func setupGradientBG() {
        let newLayer = CAGradientLayer()
        let pink = UIColor(hex: 0xFFA3A3)
        let purple = UIColor(hex: 0xA3AEFB)
        newLayer.colors = [purple.cgColor, pink.cgColor]
        newLayer.frame = view.frame
        view.layer.insertSublayer(newLayer, at: 0)
    }

    func offSetTableView() {
        let offset = CGPoint(x: 0, y: headerHeight)
        tableView.setContentOffset(offset, animated: false)
    }
    
    func reloadTableViewWithOffset() {
        tableView.reloadData()
        offSetTableView()
    }

    //to-do-rethink core data handling
  func handleItemCreation() {
        if let task = inputTaskView.taskTextLable.text, task != "" {
             vm.generateItem(task: task)
            inputTaskView.taskTextLable?.text = ""
            vm.setupItems(completion: reloadTableViewWithOffset)
        }
    }
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = vm.tasks[indexPath.row].descriptor ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.generateNumberOfRows()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {

            let item  = vm.tasks[indexPath.row]
            vm.store.deleteItem(item)

            DispatchQueue.main.async {
                self.vm.setupItems(completion: self.reloadTableViewWithOffset)
            }
        }
    }
    

}
