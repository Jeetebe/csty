//
//  TinhObj.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by MacBook on 4/30/17.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//

import Foundation
import SwiftyJSON

class TinhObj
{
    var chude:String = ""
    var noidung:String = ""
    var singername:String = ""
    
    var singernameid:String = ""
    var nameid:String = ""
    var ngay:String = ""
    
     required init?(chude: String?, noidung: String?, singername: String?, singernameid: String?, nameid: String?, ngay: String?) {
        self.chude = chude!
        self.noidung=noidung!
        self.singername=singername!
        
        self.singernameid = singernameid!
        self.nameid=nameid!
        self.ngay=ngay!
     
        
    }
    
    //    func description() -> String {
    //        return "ID: \(self.id)" +
    //            "User ID: \(self.userId)" +
    //            "Title: \(self.title)\n" +
    //        "Completed: \(self.completed)\n"
    //    }
    required init?(json: SwiftyJSON.JSON) {
        self.chude = json["chude"].string!
        self.noidung = json["noidung"].string!
        self.singername = json["singername"].string!
        
        self.singernameid = json["singernameid"].string!
        self.nameid = json["nameid"].string!
        self.ngay = json["ngay"].string!
        
          }
    
    convenience init?(json: [String: Any]) {
        guard let chude = json["chude"] as? String,
            let noidung = json["noidung"] as? String,
            let singername = json["singername"] as? String,
        let singernameid = json["singernameid"] as? String,
        let nameid = json["nameid"] as? String,
        let ngay = json["ngay"] as? String
                       else {
                return nil
        }
        
        self.init(chude: chude,noidung: noidung,singername: singername,singernameid: singernameid,nameid: nameid,ngay: ngay)    }
    
}
