import UIKit
import Foundation
import PlaygroundSupport

var fontNames: [[AnyObject]] = []

public class StartViewController : UIViewController {
    public override func loadView() {
        
        //Variables and Constants
        let view = UIView()
        
        //Adding the sfsf font
        let cfURL = Bundle.main.url(forResource: "SanFranciscoDisplay-Black", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        for name in UIFont.familyNames {
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
        
        self.view = view
        view.backgroundColor = .white
        
        //Creating a label that displays the title of the game " Pictionairy"
        let titleLabel = UILabel()
        titleLabel.text = " \n PictionAIry"
        titleLabel.font = UIFont(name: "SanfranciscoDisplay-Black", size: 55)
        titleLabel.frame = CGRect(x: 12.5, y: 12.5, width: 360, height: 200)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        //MARK: Creating question button
        let questionButton = UIButton()
        let questionButtonImage = UIImage(named: "seeRulesButton.png") as UIImage?
        questionButton.setImage(questionButtonImage, for: .normal)
        questionButton.frame = CGRect(x: 30, y: 250, width: 315, height: 87)
        view.addSubview(questionButton)
        
        //Adding a function when the singlePlayerStartButton is pressed
        questionButton.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
        
        //MARK: Creating the single player start button
        let singlePlayerStartButton = UIButton()
        let singlePlayerStartButtonImage = UIImage(named: "playGameButton") as UIImage?
        singlePlayerStartButton.setImage(singlePlayerStartButtonImage, for: .normal)
        singlePlayerStartButton.frame = CGRect(x: 30, y: 367, width: 315, height: 87)
        view.addSubview(singlePlayerStartButton)
        
        //Adding a function when the singlePlayerStartButton is pressed
        singlePlayerStartButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)        
    }
    
    @objc func playButtonPressed() {
        let gameVC = GameViewController()
        gameVC.modalTransitionStyle = .coverVertical
        present(gameVC, animated: true, completion: nil)
    }
    
    @objc func questionButtonPressed() {
        let rulesVC = RulesViewController()
        rulesVC.modalTransitionStyle = .coverVertical
        present(rulesVC, animated: true, completion: nil)
    }
    
}
