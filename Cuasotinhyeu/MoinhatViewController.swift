//
//  ViewController.swift
//  Cuasotinhyeu
//
//  Created by Jeetebe on 23/6/2017.
//  Copyright © 2017 Jeetebe. All rights reserved.
//

import UIKit
import  Alamofire

class MoinhatViewController: UIViewController {

    
    var list=[TinhObj]()
    
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        alamofireGetLog()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        var cell : SampleTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell") as! SampleTableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("cell", owner: self, options: nil)?[0] as! SampleTableViewCell;
        }
        let chude = list[indexPath.row].chude as String //NOT NSString
        let ngay = list[indexPath.row].ngay as String //NOT NSString
        let singer = list[indexPath.row].singername as String //NOT NSString
        let img = list[indexPath.row].singernameid as String //NOT NSString
        cell.lbchude.text=chude
        cell.lbngay.text=ngay
        cell.lbsinger.text=singer
        
              return cell as SampleTableViewCell
    }
    
    
    func alamofireGetLog() {
        let todoEndpoint: String = "http://123.30.100.126:8081/simmobi/rest/csty/gettophit"
        Alamofire.request(todoEndpoint)
            
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print(response.result.error!)
                    //completionHandler(.failure(response.result.error!))
                    return
                }
                
                // make sure we got JSON and it's an array of dictionaries
                guard let json = response.result.value as? [[String: AnyObject]] else {
                    print("didn't get todo objects as JSON from API")
                    //                    completionHandler(.failure(BackendError.objectSerialization(reason: "Did not get JSON array in response")))
                    return
                }
                
                // turn each item in JSON in to Todo object
                var todos:[TinhObj] = []
                for element in json {
                    if let todoResult = TinhObj(json: element) {
                        todos.append(todoResult)
                        self.list.append(todoResult)
                    }
                }
                print("out:\(self.list.count)")
                self.myTable.reloadData()
                
        }
    }

}

