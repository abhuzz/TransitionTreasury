//
//  ModalViewController.swift
//  TransitionTreasury
//
//  Created by 宋宋 on 12/30/15.
//  Copyright © 2015 TransitionTreasury. All rights reserved.
//

import UIKit
import TransitionTreasury

class ModalViewController: UIViewController, MainViewControllerDelegate {
    
    weak var modalDelegate: ModalViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}