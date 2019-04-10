//
//  ViewController.swift
//  SieveOfEratosthenes
//
//  Created by Alexander on 10/04/2019.
//  Copyright © 2019 Alexander Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(SieveOfEratosthenes.getPrimeArray(for: 1000))
    }


}

