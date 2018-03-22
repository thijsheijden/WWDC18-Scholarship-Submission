import Foundation
import CoreML
import UIKit
import PlaygroundSupport

public class GameViewController : UIViewController {
    public override func loadView() {
        
        //MARK: Variables and constants
        let view = UIView()
        self.view = view
        view.backgroundColor = .white
        var timer = Timer()
        var timeInSeconds = 30
        var isTimerRunning = false
        
        let drawView = CanvasView()
        drawView.backgroundColor = UIColor.black
        drawView.frame = CGRect(x: 0, y: 250, width: 380, height: 600)
        view.addSubview(drawView)
        
        //MARK: Setting up the UI
        //Making the time left label
        var timeLabel = UILabel()
        timeLabel.text = "00:00:00"
        timeLabel.frame = CGRect(x: 0, y: 100, width: 100, height: 50)
        
        //Adding a button to start the round
        let startRoundButton = UIButton()
        startRoundButton.frame = CGRect(x: 0, y: 50, width: 100, height: 50)
        view.addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(startRoundButtonPressed), for: .touchUpInside)
        
        //MARK: Setting up a timer that displays the time left in the round
        //Function to start the timer
//        func startTimerFunction() {
//            
//            if isTimerRunning == false {
//                runTimer()
//            } else {
//                print("Timer was already running")
//            }
//            
//        }
        
//        func runTimer() {
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
//            isTimerRunning = true
//        }
//
//        func updateTimer() {
//            if timeInSeconds < 1 {
//                timer.invalidate()
//
//                //Timer is not running anymore so set that variable to false
//                isTimerRunning = false
//
//                //setting the label to 00 : 00 : 00 in case the app was closed when the timer reached 0
//                timeLabel.text = timeString(time: TimeInterval(0))
//
//
//            } else {
//                timeInSeconds -= 1
//                timeLabel.text = timeString(time: TimeInterval(timeInSeconds))
//            }
//        }
//
//        //Function that correctly formats the time for the time label
//        func timeString(time:TimeInterval) -> String {
//            let hours = Int(time) / 3600
//            let minutes = Int(time) / 60 % 60
//            let seconds = Int(time) % 60
//            return String(format:"%02i:%02i", minutes, seconds)
//        }

        
    }
    
    @objc func startRoundButtonPressed() {
        
    }
    
}
