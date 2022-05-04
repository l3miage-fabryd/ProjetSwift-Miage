//
//  GameViewController.swift
//  CringeRocket
//
//  Created by fabryd on 30/03/2022.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var rocketLeftMargin: NSLayoutConstraint!
    
    // TODO : murs
    // TODO : musique
    
    var speed = 0.0
    var position = 3
    var columns = 5
    
    var obstacles: Array<UIImageView> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVAudioPlayer(contentsOf: <#T##URL#>)
        
        speed = view.frame.size.width / Double(columns)
        rocketLeftMargin.constant = (view.frame.size.width - rocket.frame.width) / 2
        
        for i in 0...columns - 1 {
            let obstacle = UIImageView(frame: CGRect(x: i * Int(speed), y: 50, width: 50, height: 50))
            print(obstacle)
            obstacle.image =  UIImage(named: "the_colossal")
            view.addSubview(obstacle)
            obstacles.append(obstacle)
        }
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
        let randomInt = Int.random(in: 10...50)
    }
    
    func goRight() {
        if position < columns {
            rocketLeftMargin.constant += speed
            position += 1
        }
        
        print(rocketLeftMargin.constant)
        print(position)
    }
    
    func goLeft() {
        if position > 1 {
            rocketLeftMargin.constant -= speed
            position -= 1
        }
        
        print(rocketLeftMargin.constant)
        print(position)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos: CGPoint = (touches.first?.location(in: view))!
        
        if pos.x < view.frame.size.width / 2 {
            goLeft()
        } else {
            goRight()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
