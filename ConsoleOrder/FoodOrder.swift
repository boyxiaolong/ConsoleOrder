//
//  FoodOrder.swift
//  ConsoleOrder
//
//  Created by zhaoAllen on 16/5/4.
//  Copyright © 2016年 zhaoAllen. All rights reserved.
//

import Foundation

class OrderOperation {
    func getInput() -> String {
        let keyboard = NSFileHandle.fileHandleWithStandardInput()
        return (String)(NSString(data: keyboard.availableData, encoding: 4)!.stringByReplacingOccurrencesOfString("\n", withString: ""))
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
    
    init() {
        
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
    
    func onStateChange() {
        //        var isContinue = false
        //        if let curOp = curOperation {
        //            switch curOp {
        //            case .ReadyOrder:
        //                print("RedayOrder input Y to continue or N to reject:")
        //                isContinue = true
        //            case .BeginToOrder(let isBegin):
        //                switch isBegin {
        //                case .Yes:
        //                    print("Please choose your location:A B C")
        //                    isContinue = true
        //                default:
        //                    curOperation = .ReadyOrder
        //                    onStateChange()
        //                }
        //            case .ChooseLocation(let location):
        //                switch location {
        //                case "A", "B", "C":
        //                    print("Please choose restant : A B C")
        //                    isContinue = true
        //                default:
        //                    print("error")
        //                }
        //            case .ChooseReatutant(let retautantNum):
        //                switch retautantNum {
        //                case "A", "B", "C":
        //                    print("choose foods: A B C")
        //                    isContinue = true
        //                default:
        //                    print("error")
        //                }
        //            case .ChooseFoods(let food):
        //                switch food {
        //                case "A", "B", "C":
        //                    print("choose foods: A B C")
        //                    curOperation = lastOperation
        //                default:
        //                    print("error")
        //                }
        //            default:
        //                print("other")
        //            }
        //        }
        //
        //        if isContinue {
        //            clientToInput()
        //        }
    }
    
    func clientToInput()  {
        //        let input = getInput()
        //        do {
        //            try checkIsValidInput(input)
        //        } catch OrderOperationError.InvalidInput {
        //            print("pls input right choose")
        //            clientToInput()
        //        } catch OrderOperationError.NilValidSet {
        //            print("return to last op")
        //        } catch {
        //            print("internal error happen, sorry!")
        //        }
    }
    
    //    func checkIsValidInput(input: String) throws {
    //        switch curOperation {
    //        case .ReadyOrder, .ChooseEnd:
    //            if input != "Yes" || input != "No" {
    //                throw OrderOperationError.InvalidInput
    //            }
    //        case .BeginToOrder:
    //            //
    //        }
    //    }
}