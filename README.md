
# Welcome To Weeklyst!

![](https://media.giphy.com/media/xUPGGdbNukwiaiXYv6/giphy.gif)

## For Users

Weeklyst is an iOS application that helps you manage what you need to accomplish throughout the week. Add, delete and update your task list and become efficient so you can live your best life!

Weeklyst is available in the Appstore. Just download from the appstore and start structuring your week!


## For Developers

Weeklyst is created using native Apple SDK, just download and run!

## Technologies

We used mainly 3 main things to create the Weeklyst experience:
1.  Retaining state between app usage with CoreData
2.  Shrinking the ViewController code using MVVM
3.  Creating custom views using both Xibs and programmatic custom UIView subclassing.

## Lessons Learned

CoreData as the model layer has to have some error handling and data handling because of the . A possible way to solve this is treating CoreData as a back end or a server. Utilizing handlers to request and save to core data and map that model into a struct. It might need some syncing through that handler to sync the data for every action taken. We haven't solved this problem fully, and will update once we think of a better handler for core data.

There's differing opinions on how to apply MVVM in the application, we opted to use a VM that contains functions that takes care of the business logic and view logic for us using view model methods that we supply arguments and return the relevant object to us.

```swift
//using the selected day that's contained inside the VM, we call this function inside VC, that returns an Int that tells the VC how much rows should the tableview generate based on the data that is contained inside the VC using the logic inside the VM.

func generateNumberOfRows(_ currentDay: Day)-> Int {
     let unwrappedItems = self.currentDay.items?.count ?? 0
     return unwrappedItems
 }

 //using the setupViews function, we pass in the current day that's contained inside the VC, passing it to the VM and the VM logic returns the formatted string.

 func setupViews(_ currentDay: Day)-> String {
     return currentDay.name?.uppercased() ?? ""
 }

//when we needed to handle changing data then reloading the tableviews, we needed a clear order of operations that warranted two functions to be executed separately. so we added a closure and passed a function into the closure. In this case, we wanted the VM to reorder the data, then when the process was complete, the tableview is reloaded using the closure.

 func setupItems(completion: ()-> ()) {
     if let itemsInADay = self.currentDay.items {
         let items = Array(itemsInADay) as! [Item]
         tasks = items
         tasks = tasks.sorted(by: { $0.id > $1.id })
     }
     completion()
 }

```
We realize that some of these functions will not actually save some space in the VC, because these are short concise code that won't change , but we wanted to fully commit to the VM design pattern and port as many code into the VM as a beginning template so we can probably expand more functionality into it at a later date.

Creating custom views was a gamechanger, we abstracted out a lot of the UI setup process needed to execute custom UI. creating a lot of objects and using Stackviews are possible when using Xibs, thereby removing massive overhead and get's the app up and running as soon as we can.
