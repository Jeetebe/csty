//
//  NgayViewController.swift
//  Cuasotinhyeu
//
//  Created by Jeetebe on 23/6/2017.
//  Copyright © 2017 Jeetebe. All rights reserved.
//

import UIKit
import Alamofire

class NgayViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    var list:[NgayObj] = []
    
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        alamofireGetLog()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        var cell : CellNgay! = tableView.dequeueReusableCell(withIdentifier: "cellngay") as! CellNgay
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("cellngay", owner: self, options: nil)?[0] as! CellNgay;
        }
      
        let ngay = list[indexPath.row].name as String //NOT NSString
      
             cell.lbngay.text=ngay
        
        return cell as CellNgay
    }

    func alamofireGetLog() {
        let todoEndpoint: String = "http://123.30.100.126:8081//simmobi/rest/csty/getngay"
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
                var todos:[NgayObj] = []
                for element in json {
                    if let todoResult = NgayObj(json: element) {
                        todos.append(todoResult)
                        self.list.append(todoResult)
                    }
                }
                print("out:\(self.list.count)")
                self.myTable.reloadData()
                
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("click")
        //if segue.identifier == "segplay"
        
        
        if let indexPath = self.myTable.indexPathForSelectedRow {
            print("row \(indexPath)")
            
            
            let editTaskVC = segue.destination as! PlayerViewController
            editTaskVC.chonInt = indexPath.row
            editTaskVC.loai=1
            
            
        }
        
    }
}
