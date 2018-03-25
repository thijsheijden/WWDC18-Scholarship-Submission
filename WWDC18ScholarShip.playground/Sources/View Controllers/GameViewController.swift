import Foundation
import CoreML
import Vision
import UIKit
import PlaygroundSupport

public class GameViewController : UIViewController {
    
    let drawView = CanvasView()
    var request = [VNRequest]()
    let resultLabel = UILabel()
    let scoreLabel = UILabel()
    let informationPopUpView = UIView()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var effect:UIVisualEffect!
    let startRoundButton = UIButton()
    let clearCanvasButton = UIButton()
    let closePopUpButton = UIButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupCoreMLRequest()
        
        print("view loaded")
        
        //MARK: Variables and constants
        let yellowColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
        var roundNumber = 1
        var currentScore = 0
        
        
        //Adding the san fransisco black font
        let cfURL = Bundle.main.url(forResource: "SanFranciscoDisplay-Black", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        var fontNames: [[AnyObject]] = []
        for name in UIFont.familyNames {
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
        
        //MARK: Setting up the UI
        
        //Setting up the initial view
        let view = UIView()
        self.view = view
        view.backgroundColor = yellowColor
        
        //Creating a label that displays the users score
        scoreLabel.text = "Score: \(currentScore)"
        scoreLabel.frame = CGRect(x: 275, y: 12.5, width: 100, height: 50)
        view.addSubview(scoreLabel)
        
        //Creating label that shows what the computer see's
        resultLabel.frame = CGRect(x: 37.5, y: 50, width: 300, height: 150)
        resultLabel.text = "💻 doesn't see anything yet..."
        resultLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 35)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        view.addSubview(resultLabel)
        
        //Adding the view which can be drawn on
        drawView.backgroundColor = UIColor.white
        drawView.frame = CGRect(x: 12.5, y: 200, width: 350, height: 350)
        drawView.layer.cornerRadius = 20
        view.addSubview(drawView)
        
        //MARK: UI for the popup view
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        visualEffectView.effect = nil
        visualEffectView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        view.addSubview(visualEffectView)
        
        informationPopUpView.layer.cornerRadius = 5
        informationPopUpView.frame = CGRect(x: 12.5, y: 250, width: 360, height: 300)
        informationPopUpView.backgroundColor = .white
        
        //Adding the close button to the popup view
        let closePopUpButtonImage = UIImage(named: "closeButton.png") as UIImage?
        closePopUpButton.setImage(closePopUpButtonImage, for: .normal)
        closePopUpButton.frame = CGRect(x: 150, y: 230, width: 60, height: 60)
        informationPopUpView.addSubview(closePopUpButton)
        
        closePopUpButton.addTarget(self, action: #selector(closePopUpButtonPressed), for: .touchUpInside)
        
        //Adding a button to start the round
        let startRoundButtonImage = UIImage(named: "startButton.png") as UIImage?
        startRoundButton.setImage(startRoundButtonImage, for: .normal)
        startRoundButton.frame = CGRect(x: 252.5, y: 570, width: 110, height: 27)
        view.addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(startRoundButtonPressed), for: .touchUpInside)
        
        //Adding a button clear the canvas
        let clearCanvasButtonImage = UIImage(named: "clearButton")
        clearCanvasButton.setImage(clearCanvasButtonImage, for: .normal)
        clearCanvasButton.frame = CGRect(x: 12.5, y: 570, width: 110, height: 27)
        view.addSubview(clearCanvasButton)
        
        clearCanvasButton.addTarget(self, action: #selector(clearCanvasButtonPressed), for: .touchUpInside)
        
    }
    
    //MARK: Functions that control the neural network requests
    func setupCoreMLRequest() {
        let my_model = pictionairy().model
        
        print("Coreml setup ran")
        
        guard let model = try? VNCoreMLModel(for: my_model) else {
            fatalError("Cannot load Core ML Model")
        }
        
        // set up request
        let MNIST_request = VNCoreMLRequest(model: model, completionHandler: handleMNISTClassification)
        self.request = [MNIST_request]
    }
    
    //Function that handles the classification
    func handleMNISTClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results else {
            debugPrint("No results")
            return
        }
        
        print(observations)
        
        let classification = observations
            .flatMap({ $0 as? VNClassificationObservation  })
            .filter({$0.confidence > 0.8})                      // filter confidence > 80%
            .map({$0.identifier})                               // map the identifier as answer
        
        updateLabel(with: classification.first)
        
    }
    
    //Functiont that initializes the recognition process and is called every second
    func recognize() {
        // The model takes input with 28 by 28 pixels, check the uiimage extension for
        // - Get snapshot of an view (Canvas)
        // - Resize image
        
        print("recognize function ran")
        
        let image = UIImage(view: drawView).scale(toSize: CGSize(width: 120, height: 120))
        
        let imageRequest = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        do {
            try imageRequest.perform(request)
        }
        catch {
            print(error)
        }
    }
    
    //Function that updates the result label
    func updateLabel(with text: String?) {
        // update UI should be on main thread
        DispatchQueue.main.async {
            self.resultLabel.text = "I see \(text!)"
        }
    }
    
    //Function that calls the recognize fuction every 2 seconds
    @objc func startAnalyzingDrawView() {
        recognize()
        print("Started the 2 second interval")
    }
    
    //MARK: Buttons
    @objc func startRoundButtonPressed() {
        //Creating a timer that calls the recognize function every 2 seconds to analyze the drawView
        //var gameTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(GameViewController.startAnalyzingDrawView), userInfo: nil, repeats: true)
        //startAnalyzingDrawView()
        print("start button pressed")
        animateIn()
    }
    
    //Clear the canvas when the clear button is pressed
    @objc func clearCanvasButtonPressed() {
        drawView.clearCanvas()
    }
    
    //Close the popup view
    @objc func closePopUpButtonPressed() {
        print("close popup pressed")
        animateOut()
        UIView.animate(withDuration: 0.15) {
            self.closePopUpButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
        }
    }
    
    //MARK: Code to animate in a popup view that shows some of the rules initially (Only in the first round when start is pressed)
    
    //Function that animates the appearing of the popup view
    func animateIn() {
        self.startRoundButton.isHidden = true
        self.clearCanvasButton.isHidden = true
        
        self.view.addSubview(informationPopUpView)
        informationPopUpView.center = self.view.center
        
        informationPopUpView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        informationPopUpView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.informationPopUpView.alpha = 1
            self.informationPopUpView.transform = CGAffineTransform.identity
        }
        print("popup View added")
    }
    
    //Function that animates the disapearance of the popup view
    func animateOut () {
        UIView.animate(withDuration: 0.4, animations: {
            self.informationPopUpView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            self.informationPopUpView.alpha = 0
            
            self.visualEffectView.effect = nil
            
        }) { (success:Bool) in
            self.informationPopUpView.removeFromSuperview()
        }
    }

}
