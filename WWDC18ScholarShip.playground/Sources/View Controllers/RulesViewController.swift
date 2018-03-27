import Foundation
import UIKit
import PlaygroundSupport

public class RulesViewController : UIViewController {
    
    let rulesTextView = UITextView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    
        //Variables and Constants
        //Adding the san fransisco black font
        let cfURL = Bundle.main.url(forResource: "SanFranciscoDisplay-Black", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        var fontNames: [[AnyObject]] = []
        for name in UIFont.familyNames {
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
        
        //MARK: Adding the UI
        //Setting up the inital view
        let view = UIView()
        self.view = view
        view.backgroundColor = .white
        
        //Adding the back button to get back to the start screen
        let backButton = UIButton()
        let backButtonImage = UIImage(named: "backButton.png") as UIImage?
        backButton.setImage(backButtonImage, for: .normal)
        backButton.frame = CGRect(x: 15, y: 15, width: 45, height: 45)
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        //Adding the textView that has all the rules in it
        rulesTextView.font = UIFont(name: "SanFranciscoDisplay-Black", size: 20)
        rulesTextView.text = "Hi there! Welcome to my playground! \n \n When coreML came out last year at WWDC17 I knew what I was going to make for my WWDC18 scholarship playground, a game of pictionary against a neural network. \n \n So when the scholarship details were released I started to develop that game. \n \n The game is simple. One round you draw and the 💻 guesses, the next round the 💻 draws and you have to guess. \n\n *When you are drawing please try and draw as large as possible and keep it simple!* \n \n Points are awarded for the time in which a correct guess is made. \n \n The game lasts for 6 rounds, 3 human drawing and 3 💻 drawing. \n \n I hope you enjoy this playground and hope to see all of you at WWDC18! \n\n *When the network see's a white screen it will guess that its an iPhone X, and some items are extremely easy for the network to guess, like the Watch and iPod, some are more difficult like the MacBook and Apple. If you draw another object than specified the network won't award you points, try it out to see if the network actually works!* \n\n\n\n\n\n"
        rulesTextView.frame = CGRect(x: 12.5, y: 70, width: 360, height: 667)
        view.addSubview(rulesTextView)
        
        
    }
    
    @objc func backButtonPressed() {
        let startVC = StartViewController()
        startVC.modalTransitionStyle = .partialCurl
        present(startVC, animated: true, completion: nil)
    }
    
}

