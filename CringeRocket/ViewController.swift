//
//  ViewController.swift
//  CringeRocket
//
//  Created by fabryd on 30/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func playAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController")
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
}

