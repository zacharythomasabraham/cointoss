//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import AVFoundation
import SpriteKit
//start
var audioPlayer:AVAudioPlayer!
let questions = ["Will I win WWDC2018 scholarship?", "Will warriors win today's game?", "Is next IPhone Iphone 11?", "Will apple hire me?"]
let me = ["heads","tails"]



let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.black

let pairBlue = UIColor(red: (80.0/255.0), green: (226.0/255.0), blue: (194.0/255.0), alpha: 1.0)
let coinGameTitleImage = UIImageView(frame: CGRect(x: 160.0, y: 0.0, width: 200.0, height: 100.0))
    coinGameTitleImage.image = UIImage(named: "heads.gif")

//intoview
var coinGameIntroImageView = UIImageView(frame: CGRect(x: 50, y: 320.0, width: 300.0, height: 200.0))

coinGameIntroImageView.center = containerView.center

coinGameIntroImageView.animationImages = [
    UIImage(named: "flip.jpg")!,
    UIImage(named: "HEADS-TAILS.jpg")!,
    UIImage(named: "heads_or_tails.jpg")!,
    UIImage(named: "Game-Logo-Tap-To-Play-iOS.png")!]

let label = UILabel(frame: CGRect(x:600,y: 50, width:350, height:100))
label.center = CGPoint(x: 180, y: 600)
label.textColor = UIColor.white
label.contentMode = .scaleToFill
label.numberOfLines = 2

let label1 = UILabel(frame: CGRect(x:160,y: 0, width:100, height:100))
label1.center = CGPoint(x: 180, y: 300)
label1.textColor = UIColor.red
label1.text = "Yes!!"
label1.isHidden = true

let label2 = UILabel(frame: CGRect(x:600,y: 160, width:100, height:100))
label2.center = CGPoint(x: 180, y: 300)
label2.textColor = UIColor.red
label2.text = "Nooo..."
label2.isHidden = true


//titleview
let circle = UIButton(frame:  CGRect(x: 0.0, y: 0.0, width: 64.0, height: 64.0))
    circle.center = containerView.center
    circle.layer.cornerRadius = 22.0


let circle1 = UIButton(frame:  CGRect(x: 0.0, y: 0.0, width: 320, height: 220))
circle1.center = containerView.center
circle1.layer.cornerRadius = 22.0

let startingColor = pairBlue
    circle.backgroundColor = startingColor
    circle.layer.borderWidth = 2.0
    circle.layer.borderColor = pairBlue.cgColor
    circle1.backgroundColor = startingColor
    circle1.layer.borderWidth = 2.0
    circle1.layer.borderColor = pairBlue.cgColor

containerView.addSubview(circle);
containerView.addSubview(label);
containerView.addSubview(label1);
containerView.addSubview(label2);
var IntroSoundEffect: AVAudioPlayer?
var CoinSoundEffect: AVAudioPlayer?
let path = Bundle.main.path(forResource: "sound.mp3", ofType:nil)!
let url = URL(fileURLWithPath: path)

do {
    IntroSoundEffect = try AVAudioPlayer(contentsOf: url)
    IntroSoundEffect?.play()
} catch {
    // couldn't load file :(
}
let path1 = Bundle.main.path(forResource: "flip.mp4", ofType:nil)!
let url1 = URL(fileURLWithPath: path1)

do {
    CoinSoundEffect = try AVAudioPlayer(contentsOf: url1)
    
} catch {
    // couldn't load file :(
}

UIView.animate(withDuration: 2.0, animations: { () -> Void in
    let endingColor = UIColor.white
    circle.backgroundColor = endingColor
    
    // ROTATE ANIMATION
    let rotate = CGAffineTransform(rotationAngle: 360)
    //circle.transform = rotate
    
    // SCALE ANIMATION
    let scale = CGAffineTransform(scaleX: 5.0, y: 5.0)
    //circle.transform = scale
    
    // ROTATE AND SCALE ANIMATION
    circle.transform = rotate.concatenating(scale)
    
    coinGameTitleImage.center = containerView.center
    containerView.addSubview(coinGameTitleImage)
})

PlaygroundPage.current.liveView = containerView

class Responder : NSObject {
    @objc func action() {
    
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            circle.transform = scaleTransform
            circle.frame.origin.y = 10
            
            coinGameTitleImage.center = circle.center
            
            //introimageview
            coinGameIntroImageView.animationDuration = 3
            coinGameIntroImageView.startAnimating()
            containerView.addSubview(circle1);
            containerView.addSubview(coinGameIntroImageView)
        })
    }
}
class Responder1 : NSObject {
    @objc func action() {
        IntroSoundEffect?.stop()
        coinGameIntroImageView.stopAnimating()
        
       
        CoinSoundEffect?.play()
        while(CoinSoundEffect?.isPlaying)!{
            coinGameIntroImageView.stopAnimating()
            coinGameIntroImageView.stopAnimating()
            coinGameIntroImageView.image = UIImage(named: "headstailsintro.gif")
            }
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            let scaleTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            circle1.transform = scaleTransform
            
            if(circle1.backgroundColor ==  UIColor.black)
            {
                circle1.backgroundColor = UIColor.white
            }
            else
            {
                circle1.backgroundColor = UIColor.black
            }
            
            let rotate = CGAffineTransform(rotationAngle: 360)
            // SCALE ANIMATION
            let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
            //circle.transform = scale
            
            // ROTATE AND SCALE ANIMATION
            circle1.transform = rotate.concatenating(scale)
            
            let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
            label.text = questions[randomIndex]
            let guess = Int(arc4random_uniform(UInt32(2)))
            label.text = questions[randomIndex] + " Me ::" + me[guess]
                //+ "My Choice: \(me[guess])"
            print(arc4random_uniform(42) % 2)
            if(arc4random_uniform(42) % 2 == 0){
                coinGameIntroImageView.stopAnimating()
                coinGameIntroImageView.image = UIImage(named: "heads1.png")
                /*if me[guess] == "heads"{
                    label1.isHidden = false
                }else
                {
                    label2.isHidden = false
                }*/
            }else{ coinGameIntroImageView.image = UIImage(named: "tails1.png")
                /*if me[guess] == "tails"{
                    label1.isHidden = false
                }else
                {
                    label2.isHidden = false
                }*/
            }
           
        })
    }
}

let responder = Responder()
circle.addTarget(responder, action: #selector(Responder.action), for: .touchUpInside)

let responder1 = Responder1()
circle1.addTarget(responder1, action: #selector(Responder1.action), for: .touchUpInside)







