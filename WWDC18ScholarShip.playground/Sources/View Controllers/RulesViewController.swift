import Foundation
import UIKit
import PlaygroundSupport

public class RulesViewController : UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    
        //Variables and Constants
        
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
        
        //Adding the image which has all the rules on it
        let rulesImage = UIImage(named: "rulesVC.png")
        let rulesImageView = UIImageView(image: rulesImage)
        rulesImageView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        rulesImageView.isUserInteractionEnabled = true
        rulesImageView.addSubview(backButton)
        view.addSubview(rulesImageView)
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        let startVC = StartViewController()
        startVC.modalTransitionStyle = .partialCurl
        present(startVC, animated: true, completion: nil)
    }
    
}

