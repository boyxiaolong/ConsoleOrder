//
//  ViewController.swift
//  ConsoleOrder
//
//  Created by zhaoAllen on 16/5/4.
//  Copyright © 2016年 zhaoAllen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var showText: UITextView!
    @IBOutlet weak var finishOrder: UIButton!
    
    let orderOp: OrderOperation = OrderOperation()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showText.text = self.orderOp.onStateChange()
    }

    @IBAction func sureButtonTapped(sender: UIButton) {
        let text = self.inputText.text
        let opResText = self.orderOp.clientToInput(text)
        if let res = opResText {
            self.showText.text = res
            self.inputText.text = ""
        }
    }
    
    @IBAction func finishOrderTapped(sender: UIButton) {
        if self.orderOp.isHasChooseFoods() {
            self.showText.text = self.orderOp.getChooseFoodsDes()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

