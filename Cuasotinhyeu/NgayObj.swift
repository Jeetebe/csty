//
//  TinhObj.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by MacBook on 4/30/17.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//

import Foundation
import SwiftyJSON

class NgayObj
{
    var id:String = ""
    var name:String = ""
    var parent:String = ""
     required init?(_id: String?, _name: String?) {
        self.id = _id!
        self.name=_name!
        
        
    }
    
    //    func description() -> String {
    //        return "ID: \(self.id)" +
    //            "User ID: \(self.userId)" +
    //            "Title: \(self.title)\n" +
    //        "Completed: \(self.completed)\n"
    //    }
    required init?(json: SwiftyJSON.JSON) {
        self.id = json["nameid"].string!
        self.name = json["name"].string!
                 }
    
    convenience init?(json: [String: Any]) {
        guard let isdn = json["nameid"] as? String,
            let ngay = json["name"] as? String
        
                       else {
                return nil
        }
        
        self.init(_id:isdn,_name:ngay)    }
    
}
