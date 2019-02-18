//
//  ViewController.swift
//  StyleMe
//
//  Created by Mitchell Holmes on 2019/02/12.
//  Copyright © 2019 Mitchell Holmes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var attributedText: NSMutableAttributedString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var textOutputField: UITextView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    @IBAction func detectButtonPressed(_ sender: Any) {
        
        if textInputField.text?.isEmpty == true
        {
            textOutputField.text = "You did not enter any text"
        }
        else
        {
            textOutputField.attributedText = analyseSpecialStrings(text: textInputField.text ?? "No text")
            resultsLabel.isHidden = false
        }
    }
    
    func analyseSpecialStrings(text: String) -> NSMutableAttributedString? {
        
        let inputTextArray = text.components(separatedBy: " ")
        attributedText = NSMutableAttributedString.init(string: text)
        
        if text.isPangram {
            let range = NSMakeRange(0, text.count)
            attributedText?.addAttributes([NSAttributedString.Key.font:UIFont.italicSystemFont(ofSize: 14)], range:range)
        }
        else
        {
            for word in inputTextArray {
                if word.isEmail {
                    let range = (text as NSString).range(of: word)
                    attributedText?.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 3))], range: range)
                }
                if word.isNumeric {
                    let range = (text as NSString).range(of: word)
                    attributedText?.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)], range: range)
                }
                if word.isPalindrome {
                    let range = (text as NSString).range(of: word)
                    attributedText?.addAttributes([NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2))], range: range)
                }
            }
        }
        return attributedText
    }
}

extension String {
    
    var isPangram: Bool {
        
        let characters: Set<Character> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        if characters.isSubset(of: self){
            return true
        }
        return false
    }
    var isNumeric: Bool {
        
        let letters = CharacterSet.letters
        let range = self.rangeOfCharacter(from: letters)
        
        if range == nil{
            return true
        }
        return false
    }
    var isEmail: Bool {
        #warning("MITCH - Need to update email validatation")
        if self.contains("@")==true && self.contains(".")==true{
            return true
        }
        return false
    }
    var isPalindrome: Bool {
        if self == String(self.reversed()){
            return true
        }
        return false
    }
}

