//
//  ViewController.swift
//  AgeScale
//
//  Created by admin5 on 02.03.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ageScaleView: AgeScaleView!

    override func viewDidLoad() {
        ageScaleView = AgeScaleView(frame: view.bounds)
        view.addSubview(ageScaleView)
    }
}

