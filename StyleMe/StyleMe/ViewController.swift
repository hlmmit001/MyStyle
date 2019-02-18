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
    
    func analyseSpecialStrings (text: String)-> NSMutableAttributedString? {
        
        let inputTextArray = text.components(separatedBy: " ")
        attributedText = NSMutableAttributedString.init(string: text)
        
        if checkPangram(sentence: text){
            let range = NSMakeRange(0, text.count)
            attributedText?.addAttributes([NSAttributedString.Key.font:UIFont.italicSystemFont(ofSize: 14)], range:range)
        }
        else
        {
            for word in inputTextArray{
                if checkEmail(word: word) {
                    let range = getRange(text: text, word: word)
                    attributedText?.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 3))], range: range)
                }
                if checkNumeric(word: word) {
                    let range = getRange(text: text, word: word)
                    attributedText?.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)], range: range)
                }
                if checkPalindrome(word: word){
                    let range = getRange(text: text, word: word)
                    attributedText?.addAttributes([NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2))], range: range)
                }
                
            }
        }

        return attributedText
    }
    
    func getRange (text: String, word: String)-> NSRange{
        
        return (text as NSString).range(of: word)
    }
    
    func checkEmail (word: String)-> Bool{
        #warning("Need to update email validatation")
        if word.contains("@")==true && word.contains(".")==true{
            return true
        }
        return false
    }
    
    func checkNumeric (word: String)-> Bool{
        
        let letters = CharacterSet.letters
        let range = word.rangeOfCharacter(from: letters)
        
        if range == nil{//letters are present in the word
            return true
        }
        
        return false
    }
    
    func checkPalindrome (word: String)-> Bool{
        if word == String(word.reversed()){
            return true
        }
        return false
    }
    
    func checkPangram (sentence: String)-> Bool{
        let characters: Set<Character> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        if characters.isSubset(of: sentence){
            return true
        }
        return false
    }
    //making some random changes for the new branch
    
}

