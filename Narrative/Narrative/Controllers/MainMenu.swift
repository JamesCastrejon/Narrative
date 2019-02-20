//
//  MainMenu.swift
//  Narrative
//
//  Created by James Castrejon on 2/20/19.
//  Copyright © 2019 James Castrejon. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class MainMenu: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let animationView = LOTAnimationView(name: "Import") {
            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFill
            
            view.addSubview(animationView)
            
            animationView.play()
        }
        
    }
    
}
