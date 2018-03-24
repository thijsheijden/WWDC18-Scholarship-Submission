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
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupCoreMLRequest()
        
        print("view loaded")
        
        //MARK: Variables and constants
        let yellowColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
        var roundNumber = 1
        var currentScore = 0
        
        
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
        resultLabel.frame = CGRect(x: 187.5, y: 100, width: 100, height: 50)
        resultLabel.text = "Hello"
        view.addSubview(resultLabel)
        
        //Adding the view which can be drawn on
        drawView.backgroundColor = UIColor.white
        drawView.frame = CGRect(x: 12.5, y: 200, width: 350, height: 350)
        drawView.layer.cornerRadius = 20
        view.addSubview(drawView)
        
        //Adding a button to start the round
        let startRoundButton = UIButton()
        let startRoundButtonImage = UIImage(named: "startButton.png") as UIImage?
        startRoundButton.setImage(startRoundButtonImage, for: .normal)
        startRoundButton.frame = CGRect(x: 252.5, y: 570, width: 110, height: 27)
        view.addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(startRoundButtonPressed), for: .touchUpInside)
        
        //Adding a button clear the canvas
        let clearCanvasButton = UIButton()
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
            self.resultLabel.text = text
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
        var gameTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(GameViewController.startAnalyzingDrawView), userInfo: nil, repeats: true)
        startAnalyzingDrawView()
        print("start button pressed")
    }
    
    //Clear the canvas when the clear button is pressed
    @objc func clearCanvasButtonPressed() {
        drawView.clearCanvas()
    }

}
