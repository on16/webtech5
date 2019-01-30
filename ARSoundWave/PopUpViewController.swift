//
//  PopUpViewController.swift
//  ARSoundWave
//
//  Created by Wostracky, David on 30.01.19.
//  Copyright © 2019 Benni . All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var modalView: UIView!

    override func viewDidLoad() {

        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.modalView.layer.cornerRadius = 10

        self.showAnimate()

        // Do any additional setup after loading the view.
    }

    func showAnimate()
    {
        popupState = true
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                popupState = false
            }
        });
    }
    @IBAction func closePopUp(_ sender: Any) {
        super.viewDidLoad()
        self.removeAnimate()
    }
    
}
