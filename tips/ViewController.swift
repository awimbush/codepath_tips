//
//  ViewController.swift
//  tips
//
//  Created by Alex Wimbush on 9/13/15.
//  Copyright (c) 2015 climate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var surpriseButton: UIButton!
    
    let tipPercentages = [0.18, 0.2, 0.25]
    var tipPercentage: Double = 0
    var billAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onClick(sender: AnyObject) {
        surprise()
    }
    
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        setBillAmount()
        if tipControl.selectedSegmentIndex != -1 {
            tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        }
        updateAndDisplayTotal()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            surprise()
        }
    }
    
    func generateRandomTipPercent() -> Double {
        return Double(arc4random_uniform(101))/100
    }
    
    func updateAndDisplayTotal() {
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func setBillAmount() {
        billAmount = NSString(string: billField.text!).doubleValue
    }
    
    func surprise() {
        tipControl.selectedSegmentIndex = -1
        setBillAmount()
        tipPercentage = generateRandomTipPercent()
        updateAndDisplayTotal()
    }
    
}

