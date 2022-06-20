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
        
    var horizontalSpeed = 0.0
    var verticalSpeed = 0.0
    var playerPosition = 2
    var playerVerticalPosition = 6
    var horizontalColumns = 5
    var verticalColumns = 10
    var stateShip = 1
    
    var obstacles: Array<UIImageView> = Array()
    var aliveObstacles: Array<Int> = Array()
    var obstaclesPosition: Array<Int> = Array()
    
    var timer: Timer!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        horizontalSpeed = view.frame.size.width / Double(horizontalColumns)
        verticalSpeed = view.frame.size.height / Double(verticalColumns)
        rocketLeftMargin.constant = (view.frame.size.width - rocket.frame.width) / 2
        
        for i in 0...horizontalColumns - 1 {
            let obstacle = UIImageView(frame: CGRect(x: i * Int(horizontalSpeed), y: 50, width: 50, height: 50))
            print(obstacle)
            obstacle.image =  UIImage(named: "the_colossal")
            view.addSubview(obstacle)
            obstacles.append(obstacle)
            aliveObstacles.append(i)
            obstaclesPosition.append(0)
        }
        
        playAudioAsset("music")
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        let random = aliveObstacles.randomElement()!
        obstacles[random].frame.origin.y += verticalSpeed
        obstaclesPosition[random] += 1
        
        if obstaclesPosition[random] > verticalColumns {
            removeObstacle()
        }
        
        if obstaclesPosition[random] == playerVerticalPosition && random == playerPosition {
            removeObstacle()
        }
        
        if obstaclesPosition[random] == 9 {
            removeObstacle()
            stateShip += 1
            ship.image = UIImage(named: "thousand-sunny-" + String(stateShip))
            if stateShip >= 4 {
                gameOver(false)
            }
        }
        
        print(aliveObstacles.count)
        
        if aliveObstacles.count == 0 {
            gameOver(true)
        }
        
        print(obstaclesPosition)
                
        func removeObstacle() {
            playAudioAsset("sword")
            
            obstacles[random].removeFromSuperview()
            aliveObstacles = aliveObstacles.filter {$0 != random}
        }
        
    }
    
    func goRight() {
        if playerPosition < horizontalColumns - 1 {
            rocketLeftMargin.constant += horizontalSpeed
            playerPosition += 1
        }
        
        checkObstacle()
        
        print(playerPosition)
    }
    
    func goLeft() {
        if playerPosition > 0 {
            rocketLeftMargin.constant -= horizontalSpeed
            playerPosition -= 1
        }
        
        checkObstacle()
                
        print(playerPosition)
    }
    
    func checkObstacle() {
        if obstaclesPosition[playerPosition] == playerVerticalPosition {
            playAudioAsset("sword")

            obstacles[playerPosition].removeFromSuperview()
            aliveObstacles = aliveObstacles.filter {$0 != playerPosition}
            obstaclesPosition[playerPosition] = -1
        }
    }
    
    func gameOver(_ win: Bool) {
        timer.invalidate()
        
        print("partie terminée")
        
        let alert = UIAlertController(title: "Partie terminée", message: win ? "GG" : "claqué au sol", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            exit(EXIT_SUCCESS)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos: CGPoint = (touches.first?.location(in: view))!
        
        if pos.x < view.frame.size.width / 2 {
            goLeft()
        } else {
            goRight()
        }
    }
    
    func playAudioAsset(_ assetName : String) {
          guard let audioData = NSDataAsset(name: assetName)?.data else {
             fatalError("Unable to find asset \(assetName)")
          }

          do {
             audioPlayer = try AVAudioPlayer(data: audioData)
             audioPlayer.play()
          } catch {
             fatalError(error.localizedDescription)
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
