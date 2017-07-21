
# Welcome To Weeklyst!

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

'''swift


'''
