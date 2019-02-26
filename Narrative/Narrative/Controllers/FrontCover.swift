//
//  FrontCover.swift
//  Narrative
//
//  Created by James Castrejon on 2/21/19.
//  Copyright © 2019 James Castrejon. All rights reserved.
//

import UIKit
import Lottie

class FrontCover: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var buttonMenu: UIButton!
    @IBOutlet var buttonTemp: UIButton!
    
    @IBOutlet var buttonText: UIButton!
    @IBOutlet var buttonBackground: UIButton!
    @IBOutlet var buttonFullscreen: UIButton!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupButtons()
    }
    
    private func setupButtons() {
        setupButtonRadius()
        setupButtonShadows()
        setupButtonAnimations()
    }
    
    private func setupButtonRadius() {
        let buttonWidth = buttonText.bounds.size.width
        
        buttonText.layer.cornerRadius = 0.5 * buttonWidth
        buttonBackground.layer.cornerRadius = 0.5 * buttonWidth
        buttonFullscreen.layer.cornerRadius = 0.5 * buttonWidth
    }
    
    private func setupButtonShadows() {
        addShadows(for: buttonMenu)
        addShadows(for: buttonText)
        addShadows(for: buttonBackground)
        addShadows(for: buttonFullscreen)
    }
    
    private func addShadows(for button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
    }
    
    private func setupButtonAnimations() {
        addAnimations(for: buttonMenu, with: "HamburgerMenu", 100, 100)
    }
    
    private func addAnimations(for button: UIButton,with animation: String,_ width:CGFloat,_ height: CGFloat) {
        let animationView = LOTAnimationView(name: animation)
        animationView.frame = CGRect(
            x: button.layer.position.x,
            y: button.layer.position.y,
            width: width,
            height: height)
        animationView.center = button.center
        animationView.contentMode = .scaleAspectFit
        
        self.view.addSubview(animationView)
    }
    
    // MARK: Button Functionality
    
    @IBAction func hideUIElements(_ sender: Any) {
        
    }
    
}
