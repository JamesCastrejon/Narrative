//
//  FrontCover.swift
//  Narrative
//
//  Created by James Castrejon on 2/21/19.
//  Copyright © 2019 James Castrejon. All rights reserved.
//

import UIKit
import Lottie
import ChainableAnimations

class FrontCover: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var tapShow: UITapGestureRecognizer!
    
    @IBOutlet var buttonMenu: UIButton!
    @IBOutlet var buttonSave: UIButton!
    @IBOutlet var buttonExit: UIButton!
    
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
        addShadows(for: buttonExit)
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
        animationView.isUserInteractionEnabled = false
        
        button.addSubview(animationView)
    }
    
    // MARK: Button Functionality
    
    @IBAction func menuVisibility(_ sender: Any) {
        buttonMenu.isEnabled = false
        
        if !buttonExit.isEnabled {
            let animationView:LOTAnimationView = buttonMenu.subviews.first as! LOTAnimationView
            animationView.play(fromProgress: 0.0, toProgress: 0.5) { (completed) in
                self.buttonMenu.isEnabled = true
            }
            
            buttonSave.isEnabled = true
            buttonExit.isEnabled = true
            var animator: ChainableAnimator = ChainableAnimator(view: buttonSave)
            animator.move(y: 40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonExit)
            animator.move(y: 40).thenAfter(t: 0.2).move(y: 40).animate(t: 0.2)
        }
        else {
            let animationView:LOTAnimationView = buttonMenu.subviews.first as! LOTAnimationView
            animationView.play(fromProgress: 0.5, toProgress: 1.0) { (completed) in
                self.buttonMenu.isEnabled = true
            }
            
            buttonSave.isEnabled = false
            buttonExit.isEnabled = false
            var animator: ChainableAnimator = ChainableAnimator(view: buttonSave)
            animator.move(y: -40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonExit)
            animator.move(y: -40).thenAfter(t: 0.2).move(y: -40).animate(t: 0.2)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hideUIElements(_ sender: Any) {
        var animator: ChainableAnimator = ChainableAnimator(view: buttonMenu)
        animator.move(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonSave)
        animator.move(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonExit)
        animator.move(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonText)
        animator.move(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonBackground)
        animator.move(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonFullscreen)
        animator.move(x: 80).animate(t: 0.3)
        
        tapShow.isEnabled = true
    }
    
    // MARK: Tap Register
    
    @IBAction func showUIElements(_ sender: Any) {
        buttonMenu.isHidden = false
        var animator: ChainableAnimator = ChainableAnimator(view: buttonMenu)
        animator.move(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonSave)
        animator.move(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonExit)
        animator.move(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonText)
        animator.move(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonBackground)
        animator.move(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonFullscreen)
        animator.move(x: -80).animate(t: 0.3)
        tapShow.isEnabled = false
    }
    
}
