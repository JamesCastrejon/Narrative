//
//  AnimationManager.swift
//  Narrative
//
//  Created by James Castrejon on 2/18/20.
//  Copyright © 2020 James Castrejon. All rights reserved.
//

import UIKit

class AnimationManager {
    
    // MARK: - Button (UIControl) Animations
    func moveLeft(_ button: UIButton,_ amount: CGFloat,_ time: Double,_ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            var frame = button.frame
            frame.origin.x -= amount
            button.frame = frame
        }, completion: nil)
    }
    
    func moveRight(_ button: UIButton,_ amount: CGFloat,_ time: Double,_ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            var frame = button.frame
            frame.origin.x += amount
            button.frame = frame
        }, completion: nil)
    }
    
    func moveUp(_ button: UIButton,_ amount: CGFloat,_ time: Double,_ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            var frame = button.frame
            frame.origin.y -= amount
            button.frame = frame
        }, completion: nil)
    }
    
    func moveDown(_ button: UIButton,_ amount: CGFloat,_ time: Double,_ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            var frame = button.frame
            frame.origin.y += amount
            button.frame = frame
        }, completion: nil)
    }
    
    // MARK: - UIView Animations
    func moveUp(_ view: UIView,_ amount: CGFloat,_ time: Double,_ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            var frame = view.frame
            frame.origin.y -= amount
            view.frame = frame
        }, completion: nil)
    }
    
    func moveDown(_ view: UIView,_ amount: CGFloat,_ time: Double,_ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            var frame = view.frame
            frame.origin.y += amount
            view.frame = frame
        }, completion: nil)
    }
    
}
