//
//  ButtonManager.swift
//  Narrative
//
//  Created by James Castrejon on 2/17/20.
//  Copyright © 2020 James Castrejon. All rights reserved.
//

import UIKit

class ButtonManager {
    
    func addRadius(for button: UIButton) {
        let buttonWidth = button.bounds.size.width
        button.layer.cornerRadius = 0.5 * buttonWidth
    }
    
    func addShadow(for button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
    }
    
    func showShadow(for button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
    }
    
    func hideShadow(for button: UIButton) {
        button.layer.shadowColor = UIColor.clear.cgColor
    }
    
    func enable(_ button: UIButton) {
        button.isEnabled = true
    }
    
    func disable(_ button: UIButton) {
        button.isEnabled = false
    }
    
    func hide(_ button: UIButton) {
        button.isHidden = true
    }
    
    func show(_ button: UIButton) {
        button.isHidden = false
    }
    
}
