//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var guess: UITextField!
    @IBOutlet var puzzle: UILabel!
    var puzzleString: String = String()
    var phrase: String = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()!
        print(phrase)
        var count = 0
        for c in phrase.characters {
            if c == " " {
                puzzleString.appendContentsOf(" ")
            }
            else {
                puzzleString.appendContentsOf("-")
            }
            count += 1
        }
        puzzle.text = puzzleString
    }

    @IBAction func correctGuess(sender: UIButton) {
        let g: Character = guess.text![guess.text!.startIndex]
        for i in phrase.characters.indices {
            if phrase.uppercaseString[i] == g || phrase.lowercaseString[i] == g{
                puzzleString.removeAtIndex(i)
                puzzleString.insert(phrase[i], atIndex: i)
            }
        }
        puzzle.text = puzzleString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
