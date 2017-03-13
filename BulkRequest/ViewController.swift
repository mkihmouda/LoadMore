//
//  ViewController.swift
//  BulkRequestAPI
//
//  Created by Mac on 3/2/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    
    var lastId = 0
    var reachEnd = false
    
    var intArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callMessageAPI()
        defineCollectionAndTableViewCells()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return intArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        cell.textLabel?.text = "\(intArray[indexPath.row])"
        
        if indexPath.row == lastId - 3 {
            
            callMessageAPI()
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
    
    func callMessageAPI(){
        
        if !reachEnd {
            
            let messageAPI = callAPI()
            
            messageAPI.callMessageAPI(completed: {
                
                print(self.intArray.count)
                self.lastId = self.intArray.count
                self.tableView.reloadData()
                
            }, delegate : self)
            
        }
        
    }
    
    
    // MARK:  register nib cell
    
    
    func defineCollectionAndTableViewCells(){
        
        let userDetailsNIB = UINib(nibName: "MessageCell", bundle: nil)
        tableView.register(userDetailsNIB, forCellReuseIdentifier: "messageCell")
        
        
    }
    
}

