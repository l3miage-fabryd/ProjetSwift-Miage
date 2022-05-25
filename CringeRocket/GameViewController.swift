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
    
    @IBOutlet weak var ship: UIImageView!
    
    // TODO : murs
    
    var horizontalSpeed = 0.0
    var verticalSpeed = 0.0
    var playerPosition = 3
    var horizontalColumns = 5
    var verticalColumns = 5
    var stateShip = 1
    
    var obstacles: Array<UIImageView> = Array()
    var obstaclesPosition: Array<Int> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: AVAudioPlayer(contentsOf: <#T##URL#>)
        
        horizontalSpeed = view.frame.size.width / Double(horizontalColumns)
        verticalSpeed = view.frame.size.height / Double(verticalColumns)
        rocketLeftMargin.constant = (view.frame.size.width - rocket.frame.width) / 2
        
        for i in 0...horizontalColumns - 1 {
            let obstacle = UIImageView(frame: CGRect(x: i * Int(horizontalSpeed), y: 50, width: 50, height: 50))
            print(obstacle)
            obstacle.image =  UIImage(named: "the_colossal")
            view.addSubview(obstacle)
            obstacles.append(obstacle)
            obstaclesPosition.append(0)
        }
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
        let randomInt = Int.random(in: 0...obstacles.count - 1)
        obstacles[randomInt].frame.origin.y += verticalSpeed
        obstaclesPosition[randomInt] += 1
        
        if obstaclesPosition[randomInt] > verticalColumns {
            obstacles[randomInt].removeFromSuperview()
            obstacles.remove(at: randomInt)
        }
        
        if obstaclesPosition[randomInt] == 4 && randomInt == playerPosition {
            obstacles[randomInt].removeFromSuperview()
            obstacles.remove(at: randomInt)
            
        }
        
        if obstaclesPosition[randomInt] == 5  {
            obstacles[randomInt].removeFromSuperview()
            obstacles.remove(at: randomInt)
            stateShip += 1
            ship.image = UIImage(named: "thousand-sunny-" + String(stateShip))
            if stateShip == 0 {
                gameOver()
            }
        }
        
        if obstacles.count == 0 {
            gameOver()
        }
    }
    
    func goRight() {
        if playerPosition < horizontalColumns {
            rocketLeftMargin.constant += horizontalSpeed
            playerPosition += 1
        }
        
        print(rocketLeftMargin.constant)
        print(playerPosition)
    }
    
    func goLeft() {
        if playerPosition > 1 {
            rocketLeftMargin.constant -= horizontalSpeed
            playerPosition -= 1
        }
        
        print(rocketLeftMargin.constant)
        print(playerPosition)
    }
    
    func gameOver() {
        print("partie terminée")
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
