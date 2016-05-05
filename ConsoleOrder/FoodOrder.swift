//
//  FoodOrder.swift
//  ConsoleOrder
//
//  Created by zhaoAllen on 16/5/4.
//  Copyright © 2016年 zhaoAllen. All rights reserved.
//

import Foundation

class OrderOperation {
    var foods: AllZones
    
    init() {
        foods = AllZones()
        foods.loadFile("/Users/allen/maizitech/ConsoleOrder/zone_data")
    }
    
    enum OrderOperationError : ErrorType {
        case NilValidSet
        case InvalidInput
    }
    
    enum YesOrNo{
        case Yes
        case No
        case Invalid
    }
    
    enum FoodOrder{
        case ReadyOrder
        case BeginToOrder(String)
        case ChooseLocation(String)
        case ChooseReatutant(String)
        case ChooseFoods(String)
        case ChooseEnd(String)
        
        static func getDefaultInputSet() -> Set<String> {
            return ["Yes", "No"]
        }
        
        func desption() -> String {
            switch self {
            case .ReadyOrder:
                return "ReadyOrder"
            case .BeginToOrder:
                return "BeginToOrder"
            case .ChooseLocation:
                return "ChooseLocation"
            case ChooseReatutant:
                return "ChooseReatutant"
            case ChooseFoods:
                return "ChooseFoods"
            case .ChooseEnd:
                return "ChooseEnd"
            }
        }
    }
    
    var validInput: [String: Set<String>] = [:]
    var lastOperation:FoodOrder = .ReadyOrder
    var curOperation:FoodOrder = .ReadyOrder {
        willSet {
            lastOperation = curOperation
        }
        didSet {
            onStateChange()
        }
    }
    var opRestant: Restaurant?
    var chooseFoodsArray: [RestaurantFood] = []
    
    func onStateChange() -> String? {
        print("here")
        var optionalShowStr: String?
            switch curOperation {
            case .ReadyOrder:
                optionalShowStr = "RedayOrder input y to continue:"
            case .BeginToOrder(let isBegin):
                switch isBegin {
                case "y":
                    var tmpShowStr = "Please choose your location:"
                    let nameArr = foods.getZonesNames()
                    for name in nameArr {
                        tmpShowStr += name + " "
                    }
                    optionalShowStr = tmpShowStr
                default:
                    curOperation = .ReadyOrder
                }
            case .ChooseLocation(let location):
                //数组足够小，所以此处无需考虑效率影响
                let opRestutantDesArray = foods.getZoneRestanurant(location)
                if let restutantDesArray = opRestutantDesArray {
                    var tmpStr = "pls choose reatuant:"
                    for restutant in restutantDesArray {
                        tmpStr += "\n" + restutant
                    }
                    optionalShowStr = tmpStr
                }else {
                    print("not find \(location)")
                }
            case .ChooseReatutant(let retautantStr):
                var location: String?
                if case let FoodOrder.ChooseLocation(location) = self.lastOperation {
                    var opRes = self.foods.getZoneRestanurants(location)
                    if let res = opRes {
                        for item in res {
                            if String(item.index!) == retautantStr {
                                optionalShowStr = "pls choose foods\n" + item.getAllFoodsDesption()
                                opRestant = item
                                break
                            }
                        }
                    }
                }
            case .ChooseFoods(let food):
                guard let rest = opRestant else {
                    print("nil opRestant")
                    break
                }
                
                for item in rest.foodsArray {
                    if String(item.index) == food {
                        print("choose right food \(food)")
                        self.chooseFoodsArray.append(item)
                        break
                    }
                }
            default:
                print("other")
            }

        return optionalShowStr
    }
    
    func clientToInput(opInput: String?) -> String? {
        if let input = opInput {
            print(input, self.curOperation)
            switch curOperation {
            case .ReadyOrder:
                self.curOperation = .BeginToOrder(input)
            case .BeginToOrder:
                self.curOperation = .ChooseLocation(input)
            case .ChooseLocation:
                self.curOperation = .ChooseReatutant(input)
            case .ChooseReatutant, .ChooseFoods:
                self.curOperation = .ChooseFoods(input)
            default:
                print("clientToInput not handler ")
            }
            
            return onStateChange()
        }
        
        return nil
    }
    
    func checkIsValidInput(input: String) throws {
        switch curOperation {
        case .ReadyOrder, .ChooseEnd:
            if input != "Yes" && input != "No" {
                throw OrderOperationError.InvalidInput
            }
        default:
            print("default")
        }
    }
    
    func isHasChooseFoods() -> Bool {
        return !self.chooseFoodsArray.isEmpty
    }
    
    func getChooseFoodsDes() -> String {
        var res : String = ""
        for item in self.chooseFoodsArray {
            res += item.desption() + "\n"
        }
        return res
    }
}