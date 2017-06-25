//
//  TimkiemViewController.swift
//  Cuasotinhyeu
//
//  Created by Jeetebe on 23/6/2017.
//  Copyright © 2017 Jeetebe. All rights reserved.
//

import UIKit
import Alamofire

class TimkiemViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

      var list:[TinhObj] = []
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var txtsearch: DesignTextField!
    @IBAction func action_timkiem(_ sender: Any) {
        alamofireGetLog(str: txtsearch.text!)
        
        
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
        var cell : CellTK! = tableView.dequeueReusableCell(withIdentifier: "celltk") as! CellTK
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("celltk", owner: self, options: nil)?[0] as! CellTK;
        }
        
        let singer = list[indexPath.row].singername as String //NOT NSString
        let chude = list[indexPath.row].chude as String //NOT NSString

        
        cell.lbsinger.text=singer
        cell.lbchude.text = chude
        
        return cell as CellTK
    }
    
    func alamofireGetLog(str:String) {
                let strrep:String=str.replacingOccurrences(of: " ", with: "_")
        let todoEndpoint: String = "http://123.30.100.126:8081//simmobi/rest/csty/gettophitbyloai/search"+strrep
        print("ủl:\(todoEndpoint)")
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
                //self.list.removeAll()

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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("click")
        //if segue.identifier == "segplay"
        
        
        if let indexPath = self.myTable.indexPathForSelectedRow {
            print("row \(indexPath)")
            
            
            let editTaskVC = segue.destination as! PlayerViewController
            editTaskVC.chonInt = indexPath.row
            editTaskVC.list=self.list
            editTaskVC.loai=0
            
        }
        
    }


}
