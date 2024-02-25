//
//  ViewController.swift
//  CatchTheTomGame
//
//  Created by Enes Kala on 25.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var imageList = [UIImageView] ()
    
    
    var timer = Timer()
    var time = 0
    
    var timeHiddenImage = Timer()
    
    var score = 0
    var highScore = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //GameTime
        time = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        
        
        //highScore
        
        let savedScore = UserDefaults.standard.object(forKey: "point")
        
        if savedScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        if let newScore = savedScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
       
        //imageView clicked
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true
        imageView5.isUserInteractionEnabled = true
        imageView6.isUserInteractionEnabled = true
        imageView7.isUserInteractionEnabled = true
        imageView8.isUserInteractionEnabled = true
        imageView9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        imageView1.addGestureRecognizer(gestureRecognizer1)
        imageView2.addGestureRecognizer(gestureRecognizer2)
        imageView3.addGestureRecognizer(gestureRecognizer3)
        imageView4.addGestureRecognizer(gestureRecognizer4)
        imageView5.addGestureRecognizer(gestureRecognizer5)
        imageView6.addGestureRecognizer(gestureRecognizer6)
        imageView7.addGestureRecognizer(gestureRecognizer7)
        imageView8.addGestureRecognizer(gestureRecognizer8)
        imageView9.addGestureRecognizer(gestureRecognizer9)
        
        
        //HiddenImage
        imageList = [imageView1,imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9]
        timeHiddenImage = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hiddenİmage), userInfo: nil, repeats: true)
        hiddenİmage()
        
    }
    
    
    
    @objc func hiddenİmage() {
        for image in imageList{
            image.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(imageList.count-1)))
        imageList[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func counter(){
        
        
        time -= 1
        timeLabel.text = "\(time)"
        
        if(time == 0) {
            timer.invalidate()
            timeHiddenImage.invalidate()
            timeLabel.text = "\(time)"
            
            for image in imageList{
                image.isHidden = true
            }
            
            //Save
            if(self.score >= self.highScore){
                self.highScore = self.score
                self.highScoreLabel.text = "\(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "point")
            }
            
            
        
            
            
            let alert = UIAlertController(title: "Alert", message: "Do you play again?", preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            let yesButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "\(self.score)"
                self.time = 10
                self.timeLabel.text = "\(self.time)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
                self.timeHiddenImage = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hiddenİmage), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(yesButton)
            alert.addAction(noButton)
            
            self.present(alert, animated: true, completion: nil)
            
         
            
        }

    }


}



