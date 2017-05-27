//
//  ConvertionViewController.swift
//  TempConverter
//
//  Created by Raditia Madya on 5/25/17.
//  Copyright © 2017 Universitas Gadjah Mada. All rights reserved.
//

import UIKit

class ConvertionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelciusLabel()
        }
    }
    
    var celciusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        
        return nf
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        //change the background color depending on day or night
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: NSDate() as Date)
        
        if hour >= 6 && hour <= 18 {
            view.backgroundColor = UIColor.lightGray
        }
        else {
            view.backgroundColor = UIColor.darkGray
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConvertionViewController loads its view")
        
        updateCelciusLabel()
    }
    
    @IBAction func valueChanged(_ sender: UITextField) {
        
        if let text = sender.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        
        textField.resignFirstResponder()
    }
    
    func updateCelciusLabel() {
        
        if let celciusValue = celciusValue {
            celciusLabel.text = numberFormatter.string(from: NSNumber(value: celciusValue.value))
        }
        else {
            celciusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //prevent user to input alphabetic characters
        let currentTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789.")
        let replacementStringCharacterSet = CharacterSet(charactersIn: string)
        
        if !replacementStringCharacterSet.isSubset(of: allowedCharacterSet) {
            print("Rejected (Invalid Character)")
            return false
        }
        
        if currentTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            
            return false
        }
        else {
            
            return true
        }
    }
}
