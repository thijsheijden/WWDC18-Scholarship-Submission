import Foundation
import UIKit
import PlaygroundSupport

public class QuestionViewController : UIViewController {
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        //Variables and Constants
        //Adding custom san francisco font
        let cfURL = Bundle.main.url(forResource: "SanFranciscoDisplay-Black", withExtension: "otf") as! CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let SanFranciscofont = UIFont(name: "San Francisco Black", size:  14.0)
        
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Question View Controller"
        label.textColor = .black
        label.font = SanFranciscofont
        
        view.addSubview(label)
        self.view = view
        
        //MARK: Adding the UI
        //Adding the back button to get back to the start screen
        let backButton = UIButton()
        let backButtonImage = UIImage(named: "singlePlayerStartButton.png") as UIImage?
        backButton.setImage(backButtonImage, for: .normal)
        backButton.frame = CGRect(x: 160, y: 550, width: 75, height: 75)
        backButton.setTitleColor(UIColor.red, for: .normal)
        view.addSubview(backButton)
        
         backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        let startVC = StartViewController()
        startVC.modalTransitionStyle = .coverVertical
        present(startVC, animated: true, completion: nil)
    }
    
}

