//
//  ViewController.swift
//  Cuasotinhyeu
//
//  Created by Jeetebe on 23/6/2017.
//  Copyright © 2017 Jeetebe. All rights reserved.
//

import UIKit
import  Alamofire
import AVFoundation
import AVKit
import GoogleMobileAds

class MoinhatViewController: UIViewController {

    

    @IBOutlet weak var bannerView: GADBannerView!
  

  var isPlaying = false
    
    @IBOutlet weak var demoLabel: MarqueeLabel!
    
    @IBOutlet weak var btnplay: UIButton!
    var list=[TinhObj]()
    let vov2:String = "http://210.245.60.242:1935/nghehevov2/vov2/playlist.m3u8"
    let soundUrl = "http://45.121.26.141/w/colorring/al/601/785/0/0000/0001/399.mp3"
    
   
    
    var player:AVPlayer!
    
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"  //test
        
        
        bannerView.adUnitID = "ca-app-pub-8623108209004118/7189249185"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        alamofireGetLog()
        
    
        do {
            //keep alive audio at background
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()

        
        //let url = NSURL(string:"http://45.124.94.83/get_vt/155")
        let url = NSURL(string:vov2)
        player = AVPlayer(url: url! as URL)
        
        let playerController = AVPlayerViewController()
        
        
        playerController.player = player
        self.addChildViewController(playerController)
        
        
              
        self.demoLabel.innerText = "Trực tiểp Cửa sổ tinh yêu từ 10h00 đến 10h45 Chủ nhật hàng tuần"
        
        self.demoLabel.innerSize = 15
        self.demoLabel.innerColor = UIColor.blue

        
    }

    @IBAction func btn_play_click(_ sender: Any) {
        //playSound2(soundUrl: vov2)
        if (!isPlaying)
        {
       
        //self.myView.addSubview(playerController.view)
        //playerController.view.frame = self.myView.frame
        
        player.play()
            //btnplay.image(for: def)=UIImage(named: "ic_pause")
            if let image = UIImage(named: "ic_pause.png") {
                btnplay.setImage(image, for: .normal)
            }
            isPlaying=true
        }
        else
        {
            player.pause()
            if let image = UIImage(named: "ic_play.png") {
                btnplay.setImage(image, for: .normal)
            }
            isPlaying=false
        }
       
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
        let imgsinger:String = "http://123.30.100.126:8081/simmobi/img/" + img.replacingOccurrences(of: " ", with: "%20") + ".png"
        //print("img: \( imgsinger)")
        if let url = NSURL(string: imgsinger) {
            if let data = NSData(contentsOf: url as URL) {
                cell.imgsinger.image = UIImage(data: data as Data)
            }
        }
        
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

