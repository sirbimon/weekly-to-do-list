import UIKit

class WeeklyViewController: UIViewController {

    let vm = WeeklyViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.generateData()
        self.vm.checkIfDataExists()
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
        setupGradientBG()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func setupGradientBG() {
        let newLayer = CAGradientLayer()
        // I wanted to create a background for the tableview.
        print("setupgradientBG")
        let pink = UIColor(hex: 0xFFA3A3)
        let purple = UIColor(hex: 0xA3AEFB)
        newLayer.colors = [purple.cgColor, pink.cgColor]
        newLayer.frame = view.frame
        view.layer.insertSublayer(newLayer, at: 0)
    }

}

extension WeeklyViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = DayCellView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        cell.contentView.addSubview(view)
        view.frame = cell.contentView.frame
        view.dayLabel?.text = vm.generateDayLabelText(index: indexPath.row)
        view.remainingTaskLabel.text = vm.getTaskCount(index: indexPath.row)
        
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.store.days.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TaskViewController {
            let indexPath = sender as! IndexPath
            print(indexPath.row)
            destination.vm.currentDay = self.vm.store.days[indexPath.row]

        }
    }
}

extension WeeklyViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/CGFloat(self.vm.store.days.count)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskSegue", sender: indexPath)
    }


}


