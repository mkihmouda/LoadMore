# Load More
Load More in UITableView (Client &amp; Server Side ) in Swift

[![Swift 3.0](https://img.shields.io/badge/Swift-3.2-orange.svg?style=flat)](https://swift.org/)
[![License](https://img.shields.io/cocoapods/l/ParallaxView.svg)](https://github.com/PGSSoft/ParallaxView/LICENSE.md)


Call Rest API and retrieve bulk of Data as scrolling in UITableView

 
## Requirements

Swift 3.2

## The Scenario : 



We will implement a Rest API using PHP Laravel framework (server side) which will return the latests feeds as bulk of data (20 items) in each call. and a swift code to consume the API to load more data as scrolling down.

<p align="center">

 <img src="http://appsgeeks.de/loadMore.gif" height="550" width="300">
 
</p>


## Server Side   :


The API will return bulks of data ex. 20 feeds in descending order for each call respectively. such that the latest 20 feeds for first call, and the next before latest 20 feeds for the second call .. and so on.
take(20) : To limit the number of results returned from the query to be 20.
skip(0) : to skip a given number of results in the query. such that in the first call skip(0) to don’t skip any feed, and in the second call skip(20) to skip the first 20 feeds and retrieve the next before latest 2o feeds and so on … skip(40), skip(60) … etc.

        1. public function getData($bulk_no)
        {
          return Feed::orderBy('created_at','desc')->skip($bulk_no)-> take(20)->get();  
        }


## Client Side   :

Well, there are many swift-based libraries used to perform HTTP request. one of the best of them is Alamofire. for its simplicity and taking the burden of network tasks and providing user-friendly request/response methods.
The ViewController will implement UITableView and in cellForRowAt delegate method will look like :

        var bulk_no = 0
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                   .......
            if indexPath.row >= bulk_no - 3 {
             callFeedAPI()
            }
          return cell
          }


bulk_no : Int var default value= 0. and will have the value of last item; such that after the first call will be updated to 20 and the second call will be 40 and so on …
Call Almofire API Method “callFeedAPI”

        func callFeedAPI(){
           let feedAPI = FeedAPI() // model FeedAPI
           feedAPI.callAPI(completed: {
               // code to be executed after completion of API
           self.bulk_no = self.dataArray.count
          self.tableView.reloadData()
           }, delegate : self)
         }
      }
 
after calling API completed :
1. update bulk_no to be the dataArray count ex. 20, 40 , 60 , 80 and etc. 
2. reload UITableView data.


        class FeedAPI{
          func callAPI (completed : @escaping DownloadComplete, delegate : ViewController){
           let URL = URL(string: "URL/\(delegate.lastId)")
                  Alamofire.request(URL!).responseJSON { response in
                    switch response.result {
                     case .success:
                        if let resultDictionary = response.value as? Dictionary<String, AnyObject>{
                        if let data = resultDictionary["data"] as?  Dictionary<String, AnyObject>  {
                          for obj in data {
                           if let item = resultDictionary["data"] as? String{
                               delegate.dataArray.append(item)
                        }
                       }
                      }
                     }

                    break 
                    case .failure(let error):
                      print(error)
                }
                completed()
                 }
                }
                }     

here in FeedAPI model execute callAPI method which call Rest API URL and appending bulk_no to skip # items as we mentioned in the server side.


                  // Server Side
                  public function getData($bulk_no)
                  {
                  return Feed::orderBy('created_at','desc')->skip($bulk_no)-> take(20)->get();  


                  }

  
  
after successfully feeds returned from server with success status : append the ViewController dataArray with the new bulk data. and completed() escaping closure will return to the.
  
  
  
 
## License

The project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

 
## About

The project maintained by [Grand PH], [IOS and MAC Softwares]
See our other [open-source projects](https://itunes.apple.com/us/app/iweather-fc/id1178484560?mt=8), [download_our_app](https://itunes.apple.com/us/app/iweather-fc/id1178484560?mt=8) or [contact us ](https://twitter.com/MIhmouda).

