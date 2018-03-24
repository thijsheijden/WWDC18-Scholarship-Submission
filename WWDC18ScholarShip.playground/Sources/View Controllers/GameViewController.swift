import Foundation
import CoreML
import UIKit
import PlaygroundSupport

public class GameViewController : UIViewController {
    
    let drawView = CanvasView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Variables and constants
        let yellowColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
        var roundNumber = 1
        var currentScore = 0
        
        //MARK: Setting up the UI
        //Setting up the initial view
        let view = UIView()
        self.view = view
        view.backgroundColor = yellowColor
        
        //Adding the view which can be drawn on
        drawView.backgroundColor = UIColor.white
        drawView.frame = CGRect(x: 12.5, y: 250, width: 350, height: 350)
        drawView.layer.cornerRadius = 20
        view.addSubview(drawView)
        
        //Adding a button to start the round
        let startRoundButton = UIButton()
        startRoundButton.frame = CGRect(x: 0, y: 50, width: 100, height: 50)
        view.addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(startRoundButtonPressed), for: .touchUpInside)
        
        //Adding a button clear the canvas
        let clearCanvasButton = UIButton()
        let clearCanvasButtonImage = UIImage(named: "clearButton")
        clearCanvasButton.setImage(clearCanvasButtonImage, for: .normal)
        clearCanvasButton.frame = CGRect(x: 12.5, y: 620, width: 110, height: 27)
        view.addSubview(clearCanvasButton)
        
        clearCanvasButton.addTarget(self, action: #selector(clearCanvasButtonPressed), for: .touchUpInside)
        
        //MARK: Functions
        
    }
    
    @objc func startRoundButtonPressed() {
        
    }
    
    //Clear the canvas when the clear button is pressed
    @objc func clearCanvasButtonPressed() {
        drawView.clearCanvas()
    }

}
