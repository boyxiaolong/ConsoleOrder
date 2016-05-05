//
//  Foods.swift
//  ConsoleOrder
//
//  Created by zhaoAllen on 16/5/4.
//  Copyright © 2016年 zhaoAllen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AllZones {
    var zoneArray: Array<Zone> = []
    mutating func loadFile(fileName: String) {
        for i in 1...3 {
            var zone = Zone()
            zone.zoneIndex = i
            let location = fileName + String(i) + ".txt"
            do {
                let fileContent = try NSString(contentsOfFile: location, encoding: NSUTF8StringEncoding)
                if let data = fileContent.dataUsingEncoding(NSUTF8StringEncoding) {
                    let json = JSON(data: data)
                    var count = 1
                    for (_, subJson) in json {
                        let oneRes = Restaurant(data: subJson)
                        oneRes.index = count
                        count = count + 1
                        zone.restautantArray.append(oneRes)
                    }
                }
                else {
                    print("json error")
                }
                
                self.zoneArray.append(zone)
            }
            catch {
                print(error)
            }
        }
    }
    
    func getZonesNames() -> [String] {
        var zoneStrArray : [String] = []
        for item in self.zoneArray {
            zoneStrArray.append(String(item.zoneIndex))
        }
        
        return zoneStrArray
    }
    
    func getZoneRestanurants(zone: String) -> Array<Restaurant>? {
        for oneZone in self.zoneArray {
            if String(oneZone.zoneIndex) == zone {
                return oneZone.restautantArray
            }
        }
        
        return nil
    }
    
    func getZoneRestanurant(zone: String) -> [String]? {
        for oneZone in self.zoneArray {
            if String(oneZone.zoneIndex) == zone {
                var res: [String]? = []
                for restautant in oneZone.restautantArray {
                    res?.append(restautant.desption())
                }
                return res
            }
        }
        
        return nil
    }
}

struct Zone {
    var restautantArray : Array<Restaurant> = []
    var zoneIndex = 0
}

class Restaurant {
    let name: String?
    let classes: String?
    let diliverBegin: Int?
    let deliverConsume: Int?
    let totalSellNum : Int?
    var index: Int?
    var foodsArray: [RestaurantFood] = []
    
    init(data: JSON) {
        self.name = data["restrantName"].string
        self.classes = data["classes"].string
        self.index = data["index"].int
        self.diliverBegin = data["deliveryBegin"].int
        self.deliverConsume = data["deliveryMoney"].int
        self.totalSellNum = data["totalSell"].int
        let subJson = data["restrantFoods"]
        var count = 1
        for (_, subJsonData) in subJson {
            var restaurantFood = RestaurantFood(data: subJsonData)
            restaurantFood.index = count
            count = count + 1
            foodsArray.append(restaurantFood)
        }
    }
    
    func desption() -> String {
        return self.name! + " " + String(self.index!) + " " + self.classes! + " " + String(self.totalSellNum!)
    }
    
    func getAllFoodsDesption() -> String {
        var res = ""
        for item in self.foodsArray {
            res += item.desption() + "\n"
        }
        return res
    }
}

struct RestaurantFood {
    var name: String = ""
    var price: Float = 0.0
    var sellNum: Int = 0
    var index: Int = 0
    
    init(data: JSON) {
        self.name = data["name"].string!
        self.price = data["price"].float!
        self.sellNum = data["sellNum"].int!
    }
    
    func desption() -> String {
        return "\(self.name) \(self.index) \(self.price) \(self.sellNum)"
    }
}