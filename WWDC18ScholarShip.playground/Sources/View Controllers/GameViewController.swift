import Foundation
import CoreML
import Vision
import UIKit
import PlaygroundSupport
import AVFoundation

/*TODO: Add more animations to show the user their answer is correct, Chechmark in screen for instance. Show the users point better. Clear button is weird and not easy to understand what its used for. Buttons in the AI round should have a different font to make them easier to differentiate from the others.*/

public class GameViewController : UIViewController {
    
    var fontNames: [[AnyObject]] = []
    var audioPlayer = AVAudioPlayer()
    
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
    var objectNames = ["iPhone", "MacBook", "Apple", "Watch", "HomePod", "iPhone X", "Swift", "iPod"]
    var gameTimer = Timer()
    var numberOfPoints = 0
    var numberOfSeconds = 100
    var currentScore = 0
    var pointsTimer = Timer()
    let roundLabel = UILabel()
    var roundNumber = 1
    var o = 0
    var failedToGuess = false
    
    //UI for AI drawing round
    let startAIRoundButton = UIButton()
    let aiDrawView = UIView()
    let aiPopupLabel = UILabel()
    let guessOneButton = UIButton()
    let guessTwoButton = UIButton()
    let guessThreeButton = UIButton()
    let infoLabel = UILabel()
    let reloadButtonLabelsButton = UIButton()
    var aiRoundTimer = Timer()
    var formNames = ["iPhone", "Apple", "Swift", "Watch", "MacBook"]
    var actualFormNamesFromFormClass = [Forms.iPhoneForm, Forms.AppleForm, Forms.swiftBirdForm, Forms.watchForm, Forms.macForm]
    var i = 0
    var shapeLayer = CAShapeLayer()
    let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let endOfTheAIRoundPopupView = UIView()
    let endOfTheAIRoundVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var endOfAIRoundEffect:UIVisualEffect!
    let endOfAIRoundClosePopUpButton = UIButton()
    var endOfaiPopupLabel = UILabel()
    
    //UI For the closing scene that shows your total points and final things
    let finalView = UIView()
    let finalLabel = UILabel()
    let finalButton = UIButton()
    let finalEmoji = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCoreMLRequest()
        
        //MARK: Variables and constants
        let appleGray = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
        
        //Adding the san fransisco black font and regular font
        let cfURL = Bundle.main.url(forResource: "SanFranciscoDisplay-Black", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        for name in UIFont.familyNames {
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
        
        let cfURL2 = Bundle.main.url(forResource: "SanFranciscoDisplay-Regular", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)
        for name in UIFont.familyNames {
            fontNames.append(UIFont.fontNames(forFamilyName: name) as [AnyObject])
        }
        
        //MARK: Setting up the UI
        
        //Setting up the initial view
        let view = UIView()
        self.view = view
        view.backgroundColor = appleGray
//        view.backgroundColor = yellowColor
        
        //Creating a label that displays the users score
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .right
        scoreLabel.frame = CGRect(x: 250, y: 12.5, width: 120, height: 50)
        scoreLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 18)
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
        
        //Creating a label that shows which round it is
        roundLabel.textAlignment = .left
        determineRoundLabelText()
        roundLabel.frame = CGRect(x: 12.5, y: 12.5, width: 275, height: 50)
        roundLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 14)
        view.addSubview(roundLabel)
        
        //Adding the label that displays the object that should be drawn
        toDrawObjectLabel.text = ""
        toDrawObjectLabel.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 25)
        toDrawObjectLabel.frame = CGRect(x: 252.5, y: 570, width: 150, height: 60)
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
        startPopupLabel.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 20)
        startPopupLabel.numberOfLines = 0
        startPopupLabel.frame = CGRect(x: 12.5, y: 0, width: 345, height: 300)
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
        aiPopupLabel.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 25)
        aiPopupLabel.text = ""
        aiPopupLabel.textAlignment = .center
        aiPopupLabel.numberOfLines = 0
        endOfTheRoundPopupView.addSubview(aiPopupLabel)
        
        //MARK: Rest of the UI
        //Adding a button to start the round
        let startRoundButtonImage = UIImage(named: "startRoundButton") as UIImage?
        startRoundButton.setImage(startRoundButtonImage, for: .normal)
        startRoundButton.frame = CGRect(x: 202.5, y: 570, width: 150, height: 60)
        view.addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(startRoundButtonPressed), for: .touchUpInside)
        
        //Adding a button clear the canvas
        let clearCanvasButtonImage = UIImage(named: "clearButton")
        clearCanvasButton.setImage(clearCanvasButtonImage, for: .normal)
        clearCanvasButton.frame = CGRect(x: 12.5, y: 570, width: 150, height: 60)
        view.addSubview(clearCanvasButton)
        
        clearCanvasButton.addTarget(self, action: #selector(clearCanvasButtonPressed), for: .touchUpInside)
        
        //MARK: Creating the UI for the AI round where the user has to guess what the AI is drawing
        //Creating the drawview for the ai
        aiDrawView.backgroundColor = UIColor.white
        aiDrawView.layer.cornerRadius = 20
        aiDrawView.frame = CGRect(x: 12.5, y: 200, width: 350, height: 350)
        
        //Creating three buttons that all have a different option, the user gets one chance to choose the correct answer, the faster they choose the more points they get
        //Button 1
        guessOneButton.frame = CGRect(x: 12.5, y: 565, width: 100, height: 40)
        guessOneButton.backgroundColor = .white
        guessOneButton.layer.cornerRadius = 20
        guessOneButton.setTitle("\(formNames[Int(arc4random_uniform(UInt32(formNames.count)))])", for: .normal)
        guessOneButton.titleLabel?.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 20)
        guessOneButton.setTitleColor(.black, for: .normal)
        
        guessOneButton.addTarget(self, action: #selector(checkIfButtonPressedIsCorrectAnswer), for: .touchUpInside)
        //Button 2
        guessTwoButton.frame = CGRect(x: 132.5, y: 565, width: 100, height: 40)
        guessTwoButton.backgroundColor = .white
        guessTwoButton.layer.cornerRadius = 20
        guessTwoButton.setTitle("\(formNames[Int(arc4random_uniform(UInt32(formNames.count)))])", for: .normal)
        guessTwoButton.titleLabel?.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 20)
        guessTwoButton.setTitleColor(.black, for: .normal)
        
        guessTwoButton.addTarget(self, action: #selector(checkIfButtonPressedIsCorrectAnswer), for: .touchUpInside)
        //Button 3
        guessThreeButton.frame = CGRect(x: 252.5, y: 565, width: 100, height: 40)
        guessThreeButton.backgroundColor = .white
        guessThreeButton.layer.cornerRadius = 20
        guessThreeButton.titleLabel?.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 20)
        guessThreeButton.setTitleColor(.black, for: .normal)
        guessThreeButton.setTitle("\(formNames[Int(arc4random_uniform(UInt32(formNames.count)))])", for: .normal)
        
        guessThreeButton.addTarget(self, action: #selector(checkIfButtonPressedIsCorrectAnswer), for: .touchUpInside)
        //Creating a button that reloads the button labels so that a button with the correct label can be found
        reloadButtonLabelsButton.setTitle("🔁", for: .normal)
        reloadButtonLabelsButton.titleLabel?.font = UIFont(name: "SanFranciscoDisplay-Black", size: 45)
        reloadButtonLabelsButton.frame = CGRect(x: 150, y: 598, width: 75, height: 75)
        
        reloadButtonLabelsButton.addTarget(self, action: #selector(setButtonLabels), for: .touchUpInside)
        
        //Creating the start button
        startAIRoundButton.setTitle("▶️", for: .normal)
        startAIRoundButton.titleLabel?.font = UIFont(name: "SanFranciscoDisplay-Black", size: 45)
        startAIRoundButton.frame = CGRect(x: 150, y: 598, width: 75, height: 75)
        
        startAIRoundButton.addTarget(self, action: #selector(startAiRoundButtonPressed), for: .touchUpInside)
        
        //Creating the label that gives some information about that round
        infoLabel.frame = CGRect(x: 10, y: 45, width: 355, height: 150)
        infoLabel.text = "Press the ▶️ below to start the round!"
        infoLabel.font = UIFont(name: "SanFranciscoDisplay-Black", size: 18)
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        
        //MARK: Creating the UI for the end of the AI round popup
        endOfAIRoundEffect = endOfTheAIRoundVisualEffectView.effect
        endOfTheAIRoundVisualEffectView.effect = nil
        
        endOfTheAIRoundVisualEffectView.effect = nil
        endOfTheAIRoundVisualEffectView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        
        endOfTheAIRoundPopupView.layer.cornerRadius = 5
        endOfTheAIRoundPopupView.frame = CGRect(x: 12.5, y: 250, width: 360, height: 300)
        endOfTheRoundPopupView.backgroundColor = .white
        
        //Adding the close button to end of the round popup view
        let endOfAIRoundClosePopUpButtonImage = UIImage(named: "closeButton.png") as UIImage?
        endOfAIRoundClosePopUpButton.setImage(endOfAIRoundClosePopUpButtonImage, for: .normal)
        endOfAIRoundClosePopUpButton.frame = CGRect(x: 150, y: 230, width: 60, height: 60)
        endOfTheAIRoundPopupView.addSubview(endOfAIRoundClosePopUpButton)
        
        endOfAIRoundClosePopUpButton.addTarget(self, action: #selector(endOfAIRoundClosePopUpButtonPressed), for: .touchUpInside)
        
        //Label in the end of round popup
        endOfaiPopupLabel.frame = CGRect(x: 12.5, y: 30, width: 345, height: 150)
        endOfaiPopupLabel.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 25)
        endOfaiPopupLabel.text = ""
        endOfaiPopupLabel.textAlignment = .center
        endOfaiPopupLabel.numberOfLines = 0
        endOfTheAIRoundPopupView.addSubview(endOfaiPopupLabel)
        
        //Creating the view for the popup
        endOfTheAIRoundPopupView.layer.cornerRadius = 5
        endOfTheAIRoundPopupView.frame = CGRect(x: 12.5, y: 250, width: 360, height: 300)
        endOfTheAIRoundPopupView.backgroundColor = .white
        endOfTheAIRoundPopupView.addSubview(endOfaiPopupLabel)
        endOfTheAIRoundPopupView.addSubview(endOfAIRoundClosePopUpButton)
        
        //MARK: Creating the UI for the final view
        finalView.frame = CGRect(x: 25, y: 25, width: 325, height: 617)
        finalView.backgroundColor = .white
        finalView.layer.cornerRadius = 20
        
        finalButton.frame = CGRect(x: 140, y: 559.5, width: 45, height: 45)
        let finalButtonImage = UIImage(named: "backButton") as UIImage?
        finalButton.setImage(finalButtonImage, for: .normal)
        
        finalButton.addTarget(self, action: #selector(returnToStartVC), for: .touchUpInside)
        
        finalEmoji.text = "👏🏼"
        finalEmoji.font = UIFont(name: "SanFranciscoDisplay-Black", size: 72)
        finalEmoji.frame = CGRect(x: 12.5, y: 25, width: 325, height: 75)
        finalEmoji.textAlignment = .center
        
        finalLabel.frame = CGRect(x: 12.5, y: 40, width: 300, height: 597)
        finalLabel.numberOfLines = 0
        finalLabel.font = UIFont(name: "SanFranciscoDisplay-Regular", size: 20)
    }
    
    //MARK: Functions that control the neural network requests
    func setupCoreMLRequest() {
        let my_model = pictionairy().model
        
        guard let model = try? VNCoreMLModel(for: my_model) else {
            fatalError("Cannot load Core ML Model")
        }
        
        // set up request
        let pictionairy_request = VNCoreMLRequest(model: model, completionHandler: handlePictionairyClassification)
        self.request = [pictionairy_request]
    }
    
    //Function that handles the classification
    func handlePictionairyClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results else {
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
        // The model takes input with 12 by 120 pixels, here we take a snapshot of the drawview and resize is before feeding it into our neural net.
        
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
    }
    
    //MARK: Buttons
    @objc func startRoundButtonPressed() {
        if roundNumber == 1 {
            animateIn()
            o = Int(arc4random_uniform(UInt32(objectNames.count)))
            var toDrawObject = objectNames[o]
            toDrawObjectLabel.text = "\(toDrawObject)"
        } else {
            o = Int(arc4random_uniform(UInt32(objectNames.count)))
            var toDrawObject = objectNames[o]
            toDrawObjectLabel.text = "\(toDrawObject)"
            startRoundButton.isHidden = true
            toDrawObjectLabel.isHidden = false
            numberOfSeconds = 100
            let fiveSecondsBeforeAnalyzingStarts = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(GameViewController.startAnalyzingDrawViewAfterPopUpClosed), userInfo: nil, repeats: false)
        }
    }
    
    //Clear the canvas when the clear button is pressed
    @objc func clearCanvasButtonPressed() {
        drawView.clearCanvas()
    }
    
    //Close the popup view
    @objc func closePopUpButtonPressed() {
        animateOut()
        UIView.animate(withDuration: 0.15) {
            self.closePopUpButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
        }
        let fiveSecondsBeforeAnalyzingStarts = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(GameViewController.startAnalyzingDrawViewAfterPopUpClosed), userInfo: nil, repeats: false)
        
        let showClearCanvasButton = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameViewController.showClearCanvasButton), userInfo: nil, repeats: false)
    
    }
    
    @objc func showClearCanvasButton() {
        clearCanvasButton.isHidden = false
    }
    
    //Function that keeps track of the points
    @objc func keepTrackOfPoints() {
          numberOfSeconds -= 1
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
            numberOfPoints = numberOfSeconds
            transferToAiRound(correctGuess: networkGuess!)
            roundNumber += 1
            objectNames.remove(at: o)
            playSound(soundURL: "correctSound")
        } else if numberOfSeconds < 0 {
            gameTimer.invalidate()
            pointsTimer.invalidate()
            failedToGuess = true
            roundNumber += 1
            transferToAiRound(correctGuess: toDrawObjectLabel.text!)
            objectNames.remove(at: o)
            playSound(soundURL: "wrongSound")
        }
    }
    
    @objc func transferToAiRound(correctGuess: String?) {
        if failedToGuess == true {
            aiPopupLabel.text = "I didn't figure out it was \(correctGuess!) 😢... \n\n You gained 0 points."
            animateInEndPopUp()
            hideAllUIAfterUserRound()
        } else {
            aiPopupLabel.text = "I found out it was \(correctGuess!) 🎉 \n \n \n You gained \(numberOfPoints) points!"
            animateInEndPopUp()
            hideAllUIAfterUserRound()
        }
        
    }
    
    //MARK: Code to animate in a second popup at the end of the round showing the amount of points the user got and a button to progress to the next round
    
    //Function that animates the appearing of the end of the round popup view
    func animateInEndPopUp() {
        
        failedToGuess = false
        
        self.view.addSubview(endOfTheRoundPopupView)
        endOfTheRoundPopupView.center = self.view.center
        
        endOfTheRoundPopupView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        endOfTheRoundPopupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.endOfTheRoundVisualEffectView.effect = self.endOfRoundEffect
            self.endOfTheRoundPopupView.alpha = 1
            self.endOfTheRoundPopupView.transform = CGAffineTransform.identity
        }
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
            UIView.animate(withDuration: 0.15) {
                self.endOfRoundClosePopUpButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
            }
            
            let showAllAIUI = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GameViewController.showAllUIForAIRound), userInfo: nil, repeats: false)
        
    }
    
    func hideAllUIAfterUserRound() {
        drawView.clearCanvas()
        drawView.isHidden = true
        clearCanvasButton.isHidden = true
        resultLabel.isHidden = true
        toDrawObjectLabel.isHidden = true
        scoreLabel.isHidden = true
        roundLabel.isHidden = true
    }
    
    @objc func showAllUIForAIRound() {
        if roundNumber == 2 {
        self.view.addSubview(aiDrawView)
        self.view.addSubview(guessOneButton)
        self.view.addSubview(guessTwoButton)
        self.view.addSubview(guessThreeButton)
        self.view.addSubview(infoLabel)
        self.view.addSubview(startAIRoundButton)
            
        guessOneButton.isEnabled = false
        guessTwoButton.isEnabled = false
        guessThreeButton.isEnabled = false
        currentScore += numberOfPoints
        scoreLabel.text = "Score: \(currentScore)"
        scoreLabel.isHidden = false
        determineRoundLabelText()
        roundLabel.isHidden = false
        } else {
        aiDrawView.isHidden = false
        guessOneButton.isHidden = false
        guessTwoButton.isHidden = false
        guessThreeButton.isHidden = false
        infoLabel.isHidden = false
        startAIRoundButton.isHidden = false
        guessOneButton.isEnabled = false
        guessTwoButton.isEnabled = false
        guessThreeButton.isEnabled = false
        currentScore += numberOfPoints
        scoreLabel.text = "Score: \(currentScore)"
        scoreLabel.isHidden = false
        determineRoundLabelText()
        roundLabel.isHidden = false
    }
}
    
    func determineRoundLabelText() {
    if roundNumber % 2 == 0 {
        roundLabel.text = "Round \(roundNumber), 💻 draws, 👱🏼 guesses"
    } else {
        roundLabel.text = "Round \(roundNumber), 👱🏼 draws, 💻 guesses."
    }
}
    
    //MARK: Function that draws the shape on the aidrawView
    @objc func drawForm() {
        i = Int(arc4random_uniform(UInt32(formNames.count)))
        var drawPath = actualFormNamesFromFormClass[i]
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 6
        shapeLayer.frame = CGRect(x: -115, y: 280, width: 350, height: 350)
        
        var paths: [UIBezierPath] = drawPath()
        let shapeBounds = shapeLayer.bounds
        let mirror = CGAffineTransform(scaleX: 1,
                                       y: -1)
        let translate = CGAffineTransform(translationX: 0,
                                          y: shapeBounds.size.height)
        let concatenated = mirror.concatenating(translate)
        
        for path in paths {
            path.apply(concatenated)
        }
        
        guard let path = paths.first else {
            return
        }
        
        paths.dropFirst()
            .forEach {
                path.append($0)
        }
        
        shapeLayer.transform = CATransform3DMakeScale(0.6, 0.6, 0)
        shapeLayer.path = path.cgPath
        
        self.view.layer.addSublayer(shapeLayer)
        
        strokeEndAnimation.duration = 30.0
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        shapeLayer.add(strokeEndAnimation, forKey: nil)
    }
    
    @objc func setButtonLabels() {
        guessOneButton.setTitle("\(formNames[Int(arc4random_uniform(UInt32(formNames.count)))])", for: .normal)
        guessTwoButton.setTitle("\(formNames[Int(arc4random_uniform(UInt32(formNames.count)))])", for: .normal)
        guessThreeButton.setTitle("\(formNames[Int(arc4random_uniform(UInt32(formNames.count)))])", for: .normal)
    }
    
    @objc func startAiRoundButtonPressed() {
        if roundNumber == 2 {
            startAIRoundButton.isHidden = true
            self.view.addSubview(reloadButtonLabelsButton)
            guessOneButton.isEnabled = true
            guessTwoButton.isEnabled = true
            guessThreeButton.isEnabled = true
            infoLabel.text = "Press 🔁 to get new buttons. \n You have one chance to choose the correct one!"
            drawForm()
            numberOfSeconds = 100
            aiRoundTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameViewController.keepTrackOfPoints), userInfo: nil, repeats: true)
        } else {
            startAIRoundButton.isHidden = true
            reloadButtonLabelsButton.isHidden = false
            guessOneButton.isEnabled = true
            guessTwoButton.isEnabled = true
            guessThreeButton.isEnabled = true
            infoLabel.text = "Press 🔁 to get new buttons. \n You have one chance to choose the correct one!"
            drawForm()
            numberOfSeconds = 100
            aiRoundTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameViewController.keepTrackOfPoints), userInfo: nil, repeats: true)
        }
       
    }
    
    @objc func checkIfButtonPressedIsCorrectAnswer(sender: UIButton) {
        let buttonPressed = sender
        let buttonTitle = buttonPressed.titleLabel!.text!
        if buttonTitle == formNames[i] {
            aiRoundTimer.invalidate()
            playSound(soundURL: "correctSound")
            roundNumber += 1
            numberOfPoints = numberOfSeconds
            currentScore += numberOfPoints
            scoreLabel.text = "Score: \(currentScore)"
            endOfaiPopupLabel.text = "🎊 Correct! The object was \(formNames[i])! \n\n\n You gained \(numberOfPoints) points!"
            view.addSubview(endOfTheAIRoundVisualEffectView)
            hideAllAIUi()
            animateInAIRoundEndPopUp()
            guessOneButton.isEnabled = false
            guessTwoButton.isEnabled = false
            guessThreeButton.isEnabled = false
            _ = actualFormNamesFromFormClass.remove(at: i)
            formNames.remove(at: i)
        } else {
            aiRoundTimer.invalidate()
            roundNumber += 1
            playSound(soundURL: "wrongSound")
            view.addSubview(endOfTheAIRoundVisualEffectView)
            endOfaiPopupLabel.text = "Wrong! The correct object was \(formNames[i])! \n\n\n You gained 0 points!"
            scoreLabel.text = "Score: \(currentScore)"
            animateInAIRoundEndPopUp()
            hideAllAIUi()
            guessOneButton.isEnabled = false
            guessTwoButton.isEnabled = false
            guessThreeButton.isEnabled = false
            _ = actualFormNamesFromFormClass.remove(at: i)
            formNames.remove(at: i)
        }
    }
    
    //MARK: Whether the game is over or not
    @objc func showAllHumanUI() {
        if roundNumber > 6 {
            self.startRoundButton.removeFromSuperview()
            self.clearCanvasButton.removeFromSuperview()
            self.scoreLabel.removeFromSuperview()
            self.roundLabel.removeFromSuperview()
            finalLabel.text = "Thanks for playing my playground! \n\n Your final score was \(currentScore), the highest score I ever achieved was 577 points. \n\n I hope you enjoyed this small game, and I hope to see you all at WWDC18 this summer, where you guys will hopefully unveill some really cool new things! \n\n Press the back button to go back to the home menu."
            self.view.addSubview(finalView)
            finalView.addSubview(finalLabel)
            finalView.addSubview(finalButton)
            finalView.addSubview(finalEmoji)
        } else {
            //Show all the Human Ai UI
            resultLabel.isHidden = false
            drawView.isHidden = false
            clearCanvasButton.isHidden = false
            toDrawObjectLabel.isHidden = true
            startRoundButton.isHidden = false
            scoreLabel.isHidden = false
            roundLabel.isHidden = false
            determineRoundLabelText()
            resultLabel.text = "💻 doesn't see anything yet..."
        }
    }

    @objc func hideAllAIUi() {
        //Hide all the ai ui
        infoLabel.isHidden = true
        aiDrawView.isHidden = true
        guessOneButton.isHidden = true
        guessTwoButton.isHidden = true
        guessThreeButton.isHidden = true
        reloadButtonLabelsButton.isHidden = true
        startAIRoundButton.isHidden = true
        self.shapeLayer.removeFromSuperlayer()
    }
    
    //MARK: Code to animate in a second popup at the end of the AI round showing the amount of points the user got and a button to progress to the next round
    
    //Function that animates the appearing of the end of the ai round popup view
    func animateInAIRoundEndPopUp() {
        
        self.view.addSubview(endOfTheAIRoundPopupView)
        endOfTheAIRoundPopupView.center = self.view.center
        
        endOfTheAIRoundPopupView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        endOfTheAIRoundPopupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.endOfTheAIRoundVisualEffectView.effect = self.endOfAIRoundEffect
            self.endOfTheAIRoundPopupView.alpha = 1
            self.endOfTheAIRoundPopupView.transform = CGAffineTransform.identity
        }
    }
    
    //Function that animates the disapearance of the end of the ai round popup view
    @objc func animateOutAIRoundEndPopUp() {
        UIView.animate(withDuration: 0.4, animations: {
            self.endOfTheAIRoundPopupView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            self.endOfTheAIRoundPopupView.alpha = 0
            
            self.endOfTheAIRoundVisualEffectView.effect = nil
            self.endOfTheAIRoundVisualEffectView.removeFromSuperview()

        }) { (success:Bool) in
            self.endOfTheAIRoundPopupView.removeFromSuperview()
        }
    }
    
    @objc func endOfAIRoundClosePopUpButtonPressed() {
        showAllHumanUI()
        UIView.animate(withDuration: 0.15) {
            self.endOfAIRoundClosePopUpButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
        }
        animateOutAIRoundEndPopUp()
    }
    
    //MARK: Play the correct or wrong sound effect depending on if the answer was or was not correct
    func playSound(soundURL: String) {
        //Prepare the audio player to play the correct sound file
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: soundURL, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
        } catch {
            print(error)
        }
        
        //start the audio player playback
        audioPlayer.play()
    }
    
    @objc func returnToStartVC() {
        let startVC = StartViewController()
        startVC.modalTransitionStyle = .coverVertical
        present(startVC, animated: true, completion: nil)
    }
    
}
