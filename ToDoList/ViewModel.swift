import Foundation

class WeeklyViewModel {
let store = DataStore.sharedInstance

    func generateData() {
        self.store.fetchData()
    }

    func checkIfDataExists() {
        if self.store.days.isEmpty{
            self.store.generateData()
        }
    }

    func getTaskCount(index: Int)-> String {
        if let numOfTasks = self.store.days[index].items?.count, numOfTasks != 0 {
            return "\(numOfTasks) tasks remaining."
        } else {
            return ""
        }
    }

    func generateDayLabelText(index: Int)-> String {
        return store.days[index].name ?? ""
    }


}
