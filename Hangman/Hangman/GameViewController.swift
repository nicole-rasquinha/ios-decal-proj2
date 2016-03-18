//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var hangmanState:UIImageView!
    var stateNum = 1
    
    @IBOutlet var incorrectGuesses: UILabel!
    var allGuesses = [Character]()
    @IBOutlet var guess: UITextField!
    
    @IBOutlet var puzzle: UILabel!
    var puzzleString: String!
    var phrase: String = String()

    var isPlaying: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stateNum = 1
        incorrectGuesses.text = "Incorrect Guesses:"
        allGuesses.removeAll()
        puzzleString = String()
        isPlaying = true
        
        hangmanState.image = UIImage(named: "hangman1.gif")
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

    @IBAction func startOver(sender: UIButton) {
        viewDidLoad()
    }
    @IBAction func guess(sender: UIButton) {
        if !isPlaying {
            gameOver()
            return
        }
        let s: String = guess.text!
        if s.endIndex == s.startIndex {
            error("You have not entered a guess.")
        }
        else if s.startIndex.distanceTo(s.endIndex) > 1 {
            error("Must type just one character.")
        }
        else {
            let gLower: Character = guess.text!.lowercaseString[guess.text!.startIndex]
            let gUpper: Character = guess.text!.uppercaseString[guess.text!.startIndex]
            
            if allGuesses.indexOf(gLower) != nil {
                error("You have already guessed this letter.")
                return
            }
            
            allGuesses.append(gLower)
            allGuesses.append(gUpper)
            if phrase.characters.indexOf(gLower) != nil {
                correct(gLower)
            }
            else if phrase.characters.indexOf(gUpper) != nil {
                correct(gUpper)
            }
            else {
                incorrect(gUpper)
            }
        }
    }
    
    func error(msg: String) {
        let alert = UIAlertController(title: "Invalid Input!", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func win() {
        let alert = UIAlertController(title: "YOU WON!!!", message: "Click 'Start Over' to play a new game.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func lose() {
        let alert = UIAlertController(title: "You lost :(", message: "Click 'Start Over' to try again.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "The game is over. Click 'Start Over' to play again.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func correct(g: Character) {
        for i in phrase.characters.indices {
            if phrase[i] == g {
                puzzleString.removeAtIndex(i)
                puzzleString.insert(phrase[i], atIndex: i)
            }
        }
        puzzle.text = puzzleString
        guess.text = String()
        if puzzleString.characters.indexOf("-") == nil {
            win()
            isPlaying = false
        }
    }
    

    func incorrect(g: Character) {
        var incGuesses: String = incorrectGuesses.text!
        incGuesses.appendContentsOf(" ")
        incGuesses.append(g)
        incorrectGuesses.text = incGuesses
        guess.text = String()
        
        stateNum+=1
        var name:String = "hangman"
        name.appendContentsOf(stateNum.description)
        name.appendContentsOf(".gif")
        
        hangmanState.image = UIImage(named: name)
        if stateNum == 7 {
            lose()
            puzzle.text = phrase
            isPlaying = false
        }
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
