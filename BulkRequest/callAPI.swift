//
//  CallWeatherAPI.swift
//  WeatherIOSAPP
//
//  Created by Mac on 10/31/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import Alamofire
import CoreData



class callAPI{
    
  
 
    func callMessageAPI(completed : @escaping DownloadComplete, delegate : ViewController){
        
        
       
        let weatherAPIURL = URL(string: "http://appsgeeks.de/api/messages/\(delegate.lastId)?api_token=msM8IfEwEnbHLKFOekcPOL0wOmJXtMYGccZICQrz0R2IqaHsoq4n2jlQ8PHR")
        
        
        Alamofire.request(weatherAPIURL!).responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                
                
               if let resultDictionary = response.value as? Dictionary<String, AnyObject>{
                
                if let data = resultDictionary["data"] as?  Dictionary<String, AnyObject>  {
                    
 
                    if let messages = data["chatRooms"] as?  [Dictionary<String, AnyObject>]  {

                       
                        if messages.count < 10 {
                        
                            delegate.reachEnd = true
                        
                        }
                        
                        for obj in messages {
                            
                          if let id = obj["id"] as? Int{
                                    
                            delegate.intArray.append(id)
                                    
                         
                      }
                            
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
