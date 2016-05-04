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
    
    func onStateChange() -> String? {
        var optionalShowStr: String?
            switch curOperation {
            case .ReadyOrder:
                optionalShowStr = "RedayOrder input Y to continue or N to reject:"
            case .BeginToOrder(let isBegin):
                switch isBegin {
                case "Yes":
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
                    tmpStr + "\n" + restutant
                }
                
                optionalShowStr = tmpStr
            }
            case .ChooseReatutant(let retautantStr):
                switch retautantStr {
                case "A", "B", "C":
                    optionalShowStr = "choose foods: A B C"
                default:
                    print("error")
                }
            case .ChooseFoods(let food):
                switch food {
                case "A", "B", "C":
                    print("choose foods: A B C")
                    curOperation = lastOperation
                default:
                    print("error")
                }
            default:
                print("other")
            }

        return optionalShowStr
    }
    
    func clientToInput(opInput: String?)  {
        if let input = opInput {
            do {
                try checkIsValidInput(input)
            } catch OrderOperationError.InvalidInput {
                print("pls input right choose")
            } catch OrderOperationError.NilValidSet {
                print("return to last op")
            } catch {
                print("internal error happen, sorry!")
            }
        }
    }
    
    func checkIsValidInput(input: String) throws {
        switch curOperation {
        case .ReadyOrder, .ChooseEnd:
            if input != "Yes" || input != "No" {
                throw OrderOperationError.InvalidInput
            }
        default:
            print("default")
        }
    }
}