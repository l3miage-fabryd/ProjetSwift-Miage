//
//  GameViewController.swift
//  CringeRocket
//
//  Created by fabryd on 30/03/2022.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var rocketLeftMargin: NSLayoutConstraint!
    
    var speed = 0.0
    var position = 3
    var columns = 5
    
    var obst1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speed = view.frame.size.width / Double(columns)
        rocketLeftMargin.constant = (view.frame.size.width - rocket.frame.width) / 2

        obst1 = UIImageView(frame: CGRect(x: 20, y: 50, width: 50, height: 50))
        obst1.image =  UIImage(systemName: "person.fill")
        self.view.addSubview(obst1)
    }
    
    @IBAction func goRight() {
        let viewSize = view.frame.size
        
        if position < columns {
            rocketLeftMargin.constant += speed
            position += 1
        }
        
        print(rocketLeftMargin.constant)
        print(position)
    }
    
    @IBAction func goLeft() {
        if position > 1 {
            rocketLeftMargin.constant -= speed
            position -= 1
        }
        
        print(rocketLeftMargin.constant)
        print(position)
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
