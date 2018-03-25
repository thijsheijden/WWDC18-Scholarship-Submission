import Foundation
import CoreML
import Vision
import UIKit
import PlaygroundSupport

public class GameViewController : UIViewController {
    
    //UI for Human drawing round
    let drawView = CanvasView()
    var request = [VNRequest]()
    let resultLabel = UILabel()
    let scoreLabel = UILabel()
    let informationPopUpView = UIView()
    let startButtonvisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var startButtonEffect:UIVisualEffect!
    let endOfTheRoundPopupView = UIView()
    let endOfTheRoundVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var endOfRoundEffect:UIVisualEffect!
    let startRoundButton = UIButton()
    let clearCanvasButton = UIButton()
    let closePopUpButton = UIButton()
    let endOfRoundClosePopUpButton = UIButton()
    var toDrawObject = ""
    let toDrawObjectLabel = UILabel()
    let objectNames = ["iPhone", "MacBook", "Apple", "Watch", "HomePod", "iPhone X", "Swift", "iPod"]
    var gameTimer = Timer()
    var numberOfPoints = 100
    var pointsTimer = Timer()
    let roundLabel = UILabel()
    var roundNumber = 1
    
    //UI for AI drawing round
    let startAIRoundButton = UIButton()
    let aiDrawView = UIView()
    let aiPopupLabel = UILabel()
    let aiGuessTextBox = UITextField()
    let enterButton = UIButton()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCoreMLRequest()
        
        print("view loaded")
        
        //MARK: Variables and constants
        let yellowColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
        
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
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .right
        scoreLabel.frame = CGRect(x: 275, y: 12.5, width: 80, height: 50)
        scoreLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 18)
        view.addSubview(scoreLabel)
        
        //Creating label that shows what the computer see's
        resultLabel.frame = CGRect(x: 37.5, y: 100, width: 300, height: 150)
        resultLabel.text = "💻 doesn't see anything yet..."
        resultLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 35)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        view.addSubview(resultLabel)
        
        //Adding the view which can be drawn on
        drawView.backgroundColor = UIColor.white
        drawView.frame = CGRect(x: 12.5, y: 250, width: 350, height: 350)
        drawView.layer.cornerRadius = 20
        view.addSubview(drawView)
        
        //Creating a label that shows which round it is
        roundLabel.textAlignment = .left
        determineRoundLabelText()
        roundLabel.frame = CGRect(x: 12.5, y: 12.5, width: 275, height: 50)
        roundLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 14)
        view.addSubview(roundLabel)
        
        //Adding the label that displays the object that should be drawn
        toDrawObjectLabel.text = ""
        toDrawObjectLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 20)
        toDrawObjectLabel.frame = CGRect(x: 252.5, y: 620, width: 110, height: 30)
        view.addSubview(toDrawObjectLabel)
        
        //MARK: UI for the popup view
        startButtonEffect = startButtonvisualEffectView.effect
        startButtonvisualEffectView.effect = nil
        
        startButtonvisualEffectView.effect = nil
        startButtonvisualEffectView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        view.addSubview(startButtonvisualEffectView)
        
        informationPopUpView.layer.cornerRadius = 5
        informationPopUpView.frame = CGRect(x: 12.5, y: 250, width: 360, height: 300)
        informationPopUpView.backgroundColor = .white
        
        //Adding the close button to the popup view
        let closePopUpButtonImage = UIImage(named: "closeButton.png") as UIImage?
        closePopUpButton.setImage(closePopUpButtonImage, for: .normal)
        closePopUpButton.frame = CGRect(x: 150, y: 230, width: 60, height: 60)
        informationPopUpView.addSubview(closePopUpButton)
        
        closePopUpButton.addTarget(self, action: #selector(closePopUpButtonPressed), for: .touchUpInside)
        
        //Adding the information to the popup view
        let startPopupLabel = UILabel()
        startPopupLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 20)
        startPopupLabel.numberOfLines = 0
        startPopupLabel.frame = CGRect(x: 12.5, y: 5, width: 345, height: 300)
        startPopupLabel.text = "This round, you draw! Five seconds after closing this pop-up the 💻 will start guessing. The faster it guesses correctly the more points you get! The object you have to draw is shown in the bottom right. Good luck!"
        
        informationPopUpView.addSubview(startPopupLabel)
        
        //MARK: Creating the UI for the popup notification that appears when the network guesses correctly
        endOfRoundEffect = endOfTheRoundVisualEffectView.effect
        endOfTheRoundVisualEffectView.effect = nil
        
        endOfTheRoundVisualEffectView.effect = nil
        endOfTheRoundVisualEffectView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        view.addSubview(endOfTheRoundVisualEffectView)
        
        endOfTheRoundPopupView.layer.cornerRadius = 5
        endOfTheRoundPopupView.frame = CGRect(x: 12.5, y: 250, width: 360, height: 300)
        endOfTheRoundPopupView.backgroundColor = .white
        
        //Adding the close button to end of the round popup view
        let endOfRoundClosePopUpButtonImage = UIImage(named: "closeButton.png") as UIImage?
        endOfRoundClosePopUpButton.setImage(endOfRoundClosePopUpButtonImage, for: .normal)
        endOfRoundClosePopUpButton.frame = CGRect(x: 150, y: 230, width: 60, height: 60)
        endOfTheRoundPopupView.addSubview(endOfRoundClosePopUpButton)
        
        endOfRoundClosePopUpButton.addTarget(self, action: #selector(endOfRoundClosePopUpButtonPressed), for: .touchUpInside)
        
        //Label in the end of round popup
        aiPopupLabel.frame = CGRect(x: 12.5, y: 30, width: 345, height: 150)
        aiPopupLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 25)
        aiPopupLabel.text = ""
        aiPopupLabel.textAlignment = .center
        aiPopupLabel.numberOfLines = 0
        endOfTheRoundPopupView.addSubview(aiPopupLabel)
        
        //MARK: Rest of the UI
        //Adding a button to start the round
        let startRoundButtonImage = UIImage(named: "startButton.png") as UIImage?
        startRoundButton.setImage(startRoundButtonImage, for: .normal)
        startRoundButton.frame = CGRect(x: 252.5, y: 620, width: 110, height: 27)
        view.addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(startRoundButtonPressed), for: .touchUpInside)
        
        //Adding a button clear the canvas
        let clearCanvasButtonImage = UIImage(named: "clearButton")
        clearCanvasButton.setImage(clearCanvasButtonImage, for: .normal)
        clearCanvasButton.frame = CGRect(x: 12.5, y: 620, width: 110, height: 27)
        view.addSubview(clearCanvasButton)
        
        clearCanvasButton.addTarget(self, action: #selector(clearCanvasButtonPressed), for: .touchUpInside)
        
        
        
        //MARK: Creating the UI for the AI round where the user has to guess what the AI is drawing
        //Creating the drawview for the ai
        aiDrawView.backgroundColor = UIColor.white
        aiDrawView.layer.cornerRadius = 20
        aiDrawView.frame = CGRect(x: 12.5, y: 250, width: 350, height: 350)
        
        //Creating the text field where a user can input his guess
        aiGuessTextBox.frame = CGRect(x: 12.5, y: 620, width: 200, height: 80)
        aiGuessTextBox.delegate = self
        aiGuessTextBox.layer.cornerRadius = 5
        aiGuessTextBox.backgroundColor = .white
        aiGuessTextBox.placeholder = "Enter your guess"
        
        //Creating the enter button that allows users to enter their answer
        enterButton.frame = CGRect(x: 12.5, y: 620, width: 110, height: 27)
        let enterButtonImage = UIImage(named: "startButton")
        enterButton.setImage(enterButtonImage, for: .normal)
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
        
        let classification = observations
            .flatMap({ $0 as? VNClassificationObservation  })
            .filter({$0.confidence > 0.9})                      // filter confidence > 90%
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
        checkIfNetworkGuessedCorrectly(networkGuess: text!)
    }
    
    //Function that calls the recognize fuction every 2 seconds
    @objc func startAnalyzingDrawView() {
        recognize()
        print("Started the 2 second interval")

    }
    
    //MARK: Buttons
    @objc func startRoundButtonPressed() {
        //startAnalyzingDrawView()
        animateIn()
        var i = Int(arc4random_uniform(UInt32(objectNames.count)))
        var toDrawObject = objectNames[i]
        
        toDrawObjectLabel.text = "\(toDrawObject)"
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
        let fiveSecondsBeforeAnalyzingStarts = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(GameViewController.startAnalyzingDrawViewAfterPopUpClosed), userInfo: nil, repeats: false)
        
        clearCanvasButton.isHidden = false
    
    }
    
    //Function that keeps track of the points
    @objc func keepTrackOfPoints() {
        numberOfPoints -= 1
    }
    
    @objc func startAnalyzingDrawViewAfterPopUpClosed() {
        //Creating a timer that calls the recognize function every 2 seconds to analyze the drawView
        gameTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(GameViewController.startAnalyzingDrawView), userInfo: nil, repeats: true)
        
        pointsTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameViewController.keepTrackOfPoints), userInfo: nil, repeats: true)
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
            self.startButtonvisualEffectView.effect = self.startButtonEffect
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
            
            self.startButtonvisualEffectView.effect = nil
            
        }) { (success:Bool) in
            self.informationPopUpView.removeFromSuperview()
        }
        let bringDrawViewToFront = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GameViewController.bringDrawViewToFront), userInfo: nil, repeats: false)
        
        
    }
    
    @objc func bringDrawViewToFront() {
        self.view.bringSubview(toFront: drawView)
    }

    func checkIfNetworkGuessedCorrectly(networkGuess: String?) {
        if toDrawObjectLabel.text == networkGuess {
            gameTimer.invalidate()
            pointsTimer.invalidate()
            transferToAiRound(correctGuess: networkGuess!, numberOfPoints: numberOfPoints)
            roundNumber += 1
        } else {
            print("Correct object still not guessed")
        }
    }
    
    @objc func transferToAiRound(correctGuess: String?, numberOfPoints: Int) {
        aiPopupLabel.text = "I found out it was \(correctGuess!) 🎉 \n \n \n you now have \(numberOfPoints) points!"
        animateInEndPopUp()
        hideAllUIAfterUserRound()
    }
    
    //MARK: Code to animate in a second popup at the end of the round showing the amount of points the user got and a button to progress to the next round
    
    //Function that animates the appearing of the end of the round popup view
    func animateInEndPopUp() {
        
        self.view.addSubview(endOfTheRoundPopupView)
        endOfTheRoundPopupView.center = self.view.center
        
        endOfTheRoundPopupView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        endOfTheRoundPopupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.endOfTheRoundVisualEffectView.effect = self.endOfRoundEffect
            self.endOfTheRoundPopupView.alpha = 1
            self.endOfTheRoundPopupView.transform = CGAffineTransform.identity
        }
        print("popup View added")
    }
    
    //Function that animates the disapearance of the end of the round popup view
    func animateOutEndPopUp () {
        UIView.animate(withDuration: 0.4, animations: {
            self.endOfTheRoundPopupView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            self.endOfTheRoundPopupView.alpha = 0
            
            self.endOfTheRoundVisualEffectView.effect = nil
            
        }) { (success:Bool) in
            self.endOfTheRoundPopupView.removeFromSuperview()
        }
        
        
    }
    
    @objc func endOfRoundClosePopUpButtonPressed() {
        animateOutEndPopUp()
        let showAllAIUI = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GameViewController.showAllUIForAIRound), userInfo: nil, repeats: false)
        showAllUIForAIRound()
        UIView.animate(withDuration: 0.15) {
            self.endOfRoundClosePopUpButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
        }
    }
    
    func hideAllUIAfterUserRound() {
        drawView.isHidden = true
        clearCanvasButton.isHidden = true
        resultLabel.isHidden = true
        toDrawObjectLabel.isHidden = true
        scoreLabel.isHidden = true
        roundLabel.isHidden = true
    }
    
    @objc func showAllUIForAIRound() {
        self.view.addSubview(aiDrawView)
        self.view.addSubview(aiGuessTextBox)
        self.view.addSubview(enterButton)
        print(numberOfPoints)
        scoreLabel.text = "Score: \(numberOfPoints)"
        scoreLabel.isHidden = false
        determineRoundLabelText()
        roundLabel.isHidden = false
    }
    
    func determineRoundLabelText() {
    if roundNumber % 2 == 0 {
        roundLabel.text = "Round \(roundNumber), 💻 draws, 👱🏼 guesses"
    } else {
        roundLabel.text = "Round \(roundNumber), 👱🏼 draws, 💻 guesses."
    }
}
    
}

//Extension to enable us to get the textfield inputs
extension GameViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
