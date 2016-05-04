//
//  Restaurant.swift
//  FoodOrder
//
//  Created by zhaoAllen on 16/5/3.
//  Copyright © 2016年 zhaoAllen. All rights reserved.
//

import Foundation

struct AllZones {
    var zoneArray: Array<Zone> = []
    func loadFile(fileName: String) {
        let documentsDirectoryPath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let everythingSwiftFilePath = documentsDirectoryPath + fileName
        do {
            let jsonData = try NSString(contentsOfFile: everythingSwiftFilePath, encoding: NSUTF8StringEncoding)
            let data = jsonData.dataUsingEncoding(NSUTF8StringEncoding)
            let objects = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print(objects.dynamicType)
        }
        catch {/* error handling here */}
    }
}

struct Zone {
    var RestautantsArray: Array<Restautants> = []
}

struct Restautants {
    var restautantArray : Array<Restaurant> = []
}

struct Restaurant {
    let name: String
    let classes: String
    let diliverBegin: Int = 0
    let deliverConsume: Int = 0
    let totalSellNum = 0
    let index = 0
    var foodsArray: [RestaurantFood] = []
}

struct RestaurantFood {
    var name: String = ""
    var price: Int = 0
    var sellNum: Int = 0
    var index: Int = 0
}