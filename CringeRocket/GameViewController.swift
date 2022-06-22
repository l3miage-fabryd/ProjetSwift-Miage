//
//  GameViewController.swift
//  CringeRocket
//
//  Created by fabryd on 30/03/2022.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var rocketLeftMargin: NSLayoutConstraint!
    @IBOutlet weak var rocket: UIImageView!
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
    
    var musicPlayer: AVAudioPlayer!
    var soundPlayer: AVAudioPlayer!
    
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
        
        musicPlayer = createAudioPlayerFromAsset("music")
        soundPlayer = createAudioPlayerFromAsset("sword")
        
        musicPlayer.play()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        print(aliveObstacles)
        print(aliveObstacles.count)
        
        if aliveObstacles.count == 0 {
            print("before")
            gameOver(true)
            print("after")
            return
        }
        
        let random = aliveObstacles.randomElement()!
        obstacles[random].frame.origin.y += verticalSpeed
        obstaclesPosition[random] += 1
        
        if obstaclesPosition[random] > verticalColumns {
            removeObstacle(random)
        }
        
        if obstaclesPosition[random] == playerVerticalPosition && random == playerPosition {
            removeObstacle(random)
        }
        
        if obstaclesPosition[random] == 9 {
            removeObstacle(random)
            stateShip += 1
            ship.image = UIImage(named: "thousand-sunny-" + String(stateShip))
            if stateShip >= 4 {
                gameOver(false)
            }
        }
        
        print(obstaclesPosition)
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
    
    func removeObstacle(_ index: Int) {
        soundPlayer.play()
        soundPlayer.volume = 0.1
        
        obstacles[index].removeFromSuperview()
        aliveObstacles = aliveObstacles.filter {$0 != index}
        obstaclesPosition[index] = -1
    }
    
    func checkObstacle() {
        if obstaclesPosition[playerPosition] == playerVerticalPosition {
            removeObstacle(playerPosition)
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
    
    func createAudioPlayerFromAsset(_ assetName : String) -> AVAudioPlayer {
          guard let audioData = NSDataAsset(name: assetName)?.data else {
             fatalError("Unable to find asset \(assetName)")
          }

          do {
             return try AVAudioPlayer(data: audioData)
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
