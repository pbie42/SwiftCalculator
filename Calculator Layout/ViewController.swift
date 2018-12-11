//
//  ViewController.swift
//  Calculator Layout
//
//  Created by Paul Bie on 12/6/18.
//  Copyright © 2018 Paul Bie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    var num1 : String = ""
    var num1done : Bool = false
    var num1decimal : Bool = false
    var num2 : String = ""
    var num2done : Bool = false
    var num2decimal : Bool = false
    var total : Bool = false
    var sign : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        if (!num1done && total) {
            num1 = ""
            total = false
        }
        handleNumString(tag: sender.tag)
        if (!num1done) { display.text = num1 }
        else if (num1done && !num2done) { display.text = num2 }
    }
    
    @IBAction func signPressed(_ sender: UIButton) {
        if (!num1done && num1 != "") {
            num1done = true
        }
        clearSignBorder()
        switch sender.tag {
        case 1:
            sign = "/"
            borderWidthColor(btn: divideBtn)
        case 2:
            sign = "*"
            borderWidthColor(btn: multiplyBtn)
        case 3:
            sign = "-"
            borderWidthColor(btn: minusBtn)
        case 4:
            sign = "+"
            borderWidthColor(btn: plusBtn)
        default:
            sign = ""
        }
        num1done = true
    }
    @IBAction func equalsPressed(_ sender: UIButton) {
        if (num1 != "" && sign != "" && num2 != "") {
            let intNum1 : Double = Double(num1)!
            let intNum2 : Double = Double(num2)!
            var answer : Double
            switch sign {
            case "/":
                answer = intNum1 / intNum2
            case "*":
                answer = intNum1 * intNum2
            case "+":
                answer = intNum1 + intNum2
            case "-":
                answer = intNum1 - intNum2
            default:
                answer = 0
            }
            clearSign()
            clearNum2()
            num1 = "\(answer)"
            
//            Tam - Is there a better way to do this? Look at the function
            
            num1 = handleEndZeros(num: num1)
//
            num1done = false
            total = true
            display.text = num1
        }
    }
    @IBAction func negativePressed(_ sender: UIButton) {
        if (!num1done) {
//            Tam - Am I right to use the exclamations below? Remove them and see the error
            if (Double(num1)! > Double(0)) { num1 = "-" + num1 }
            else if (Double(num1)! < Double(0)) { num1.remove(at: num1.startIndex) }
            display.text = num1
        }
        else if (num1done) {
            if (Double(num2)! > Double(0)) { num2 = "-" + num2 }
            else if (Double(num2)! < Double(0)) { num2.remove(at: num2.startIndex) }
            display.text = num2
        }
    }
    @IBAction func clearPressed(_ sender: UIButton) {
        if (num1done && sign != "" && num2 == "") {
            clearSign()
            num1done = false
            display.text = num1
        }
        else if (num1done && sign != "" && num2 != "") {
            clearNum2()
        }
        else if (!num1done && sign == "" && num2 == "") {
            clearNum1()
        }
    }
    
//    There must be a better way to do this right?
    func handleEndZeros(num : String) -> String {
        var onlyZeros : Bool = true
//        Am I right to use the exclamation here? Remove it and check out the error
        let index: String.Index = num.firstIndex(of: ".")!
        let subNum = num.suffix(from: index)
        for char in subNum {
            if char != "." && char != "0" {
                onlyZeros = false
            }
        }
        if (onlyZeros) { return String(num.prefix(upTo: index)) }
        else { return num }
    }
    
    func borderWidthColor(btn : UIButton) {
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.black.cgColor
    }
    
    func clearSign() {
        clearSignBorder()
        sign = ""
    }
    
    func clearNum1() {
        num1 = ""
        num1decimal = false
        num1done = false
        display.text = "0"
    }
    
    func clearNum2() {
        num2 = ""
        num2decimal = false
        num2done = false
        display.text = "0"
    }
    
    func clearSignBorder() {
        if (sign != "") {
            if (sign == "/") { divideBtn.layer.borderWidth = 0.0 }
            if (sign == "*") { multiplyBtn.layer.borderWidth = 0.0 }
            if (sign == "+") { plusBtn.layer.borderWidth = 0.0 }
            if (sign == "-") { minusBtn.layer.borderWidth = 0.0 }
        }
    }
    
    func handleNumString(tag : Int) {
        switch tag {
        case 0:
            addToNumString(num: "0")
        case 1:
            addToNumString(num: "1")
        case 2:
            addToNumString(num: "2")
        case 3:
            addToNumString(num: "3")
        case 4:
            addToNumString(num: "4")
        case 5:
            addToNumString(num: "5")
        case 6:
            addToNumString(num: "6")
        case 7:
            addToNumString(num: "7")
        case 8:
            addToNumString(num: "8")
        case 9:
            addToNumString(num: "9")
        case 10:
            handleDecimal()
        default:
            num1 += ""
        }
    }
    
    func handleDecimal() {
        if (!num1done && !num1decimal) {
            num1 += "."
            num1decimal = true
        }
        else if (num1done && !num2decimal) {
            num2 += "."
            num2decimal = true
        }
    }
    
    func addToNumString(num : String) {
        if (!num1done) { num1 += num }
        else if (!num2done) { num2 += num }
    }
}

