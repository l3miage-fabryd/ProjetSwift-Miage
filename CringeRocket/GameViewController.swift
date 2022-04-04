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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goRight() {
        var viewSize = self.view.frame.size
        if self.rocketLeftMargin.constant + 10 <= viewSize.width {
            self.rocketLeftMargin.constant += 10
        }
        print(viewSize)
        print(self.rocketLeftMargin.constant)
    }
    @IBAction func goLeft() {
        if self.rocketLeftMargin.constant - 10 >= 0 {
            self.rocketLeftMargin.constant -= 10
        }
        print(self.rocketLeftMargin.constant)
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
