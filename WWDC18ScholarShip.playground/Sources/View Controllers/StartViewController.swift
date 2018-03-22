import UIKit
import Foundation
import PlaygroundSupport

public class StartViewController : UIViewController {
    public override func loadView() {
        
        //Variables and Constants
        let view = UIView()
        let centerX = 140
        let centerY = 300
        let yellowColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
        
        self.view = view
        view.backgroundColor = yellowColor
        
        //MARK: Creating question button
        let questionButton = UIButton()
        let questionButtonImage = UIImage(named: "questionButton.png") as UIImage?
        questionButton.setImage(questionButtonImage, for: .normal)
        questionButton.frame = CGRect(x: centerX, y: 200, width: 125, height: 125)
        view.addSubview(questionButton)
        
        //Adding a function when the singlePlayerStartButton is pressed
        questionButton.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
        
        //MARK: Creating the single player start button
        let singlePlayerStartButton = UIButton()
        let singlePlayerStartButtonImage = UIImage(named: "singlePlayerStartButton.png") as UIImage?
        singlePlayerStartButton.setImage(singlePlayerStartButtonImage, for: .normal)
        singlePlayerStartButton.frame = CGRect(x: centerX, y: 350, width: 125, height: 125)
        view.addSubview(singlePlayerStartButton)
        
        //Adding a function when the singlePlayerStartButton is pressed
        singlePlayerStartButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        
        //MARK: Creating the Two player start button
        let twoPlayerStartButton = UIButton()
        let twoPlayerStartButtonImage = UIImage(named: "twoPlayerStartButton.png") as UIImage?
        twoPlayerStartButton.setImage(twoPlayerStartButtonImage, for: .normal)
        twoPlayerStartButton.frame = CGRect(x: centerX, y: 500, width: 125, height: 125)
        view.addSubview(twoPlayerStartButton)
        
        //Adding a function when the singlePlayerStartButton is pressed
        twoPlayerStartButton.addTarget(self, action: #selector(twoPlayerStartButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func playButtonPressed() {
        let gameVC = GameViewController()
        gameVC.modalTransitionStyle = .coverVertical
        present(gameVC, animated: true, completion: nil)
    }
    
    @objc func twoPlayerStartButtonPressed() {
        let vc2 = ViewController2()
        vc2.modalTransitionStyle = .coverVertical
        present(vc2, animated: true, completion: nil)
    }
    
    @objc func questionButtonPressed() {
        let questionVC = QuestionViewController()
        questionVC.modalTransitionStyle = .coverVertical
        present(questionVC, animated: true, completion: nil)
    }
    
}
