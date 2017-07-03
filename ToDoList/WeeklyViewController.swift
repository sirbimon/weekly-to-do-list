import UIKit

class WeeklyViewController: UIViewController {

    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        self.store.fetchData()
        if self.store.days.isEmpty{
            self.store.generateData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension WeeklyViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        cell.textLabel?.text = self.store.days[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.days.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TaskViewController {
            let indexPath = sender as! IndexPath
            print(indexPath)

        }
    }
}

extension WeeklyViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/CGFloat(self.store.days.count)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskSegue", sender: indexPath)
    }

}

