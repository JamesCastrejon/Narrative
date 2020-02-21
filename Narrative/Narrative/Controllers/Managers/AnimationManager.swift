//
//  AnimationManager.swift
//  Narrative
//
//  Created by James Castrejon on 2/18/20.
//  Copyright © 2020 James Castrejon. All rights reserved.
//

import UIKit
import Toast_Swift

class AnimationManager {
    
    // MARK: - Button (UIControl) Animations
    func moveLeft(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
                       animations: {
                        button.frame.origin.x -= amount
        }, completion: nil)
    }
    
    func moveRight(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
                       animations: {
                        button.frame.origin.x += amount
        }, completion: nil)
    }
    
    func moveUp(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
                       animations: {
                        button.frame.origin.y -= amount
        }, completion: nil)
    }
    
    func moveDown(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
                       animations: {
                        button.frame.origin.y += amount
        }, completion: nil)
    }
    
    func moveLeft(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ delay: Double, _ speedOptions: UIView.AnimationOptions, _ completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: time, delay: delay, options: speedOptions,
        animations: {
            button.frame.origin.x -= amount
        }, completion: completion)
    }
    
    func moveRight(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ delay: Double, _ speedOptions: UIView.AnimationOptions, _ completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: time, delay: delay, options: speedOptions,
        animations: {
            button.frame.origin.x += amount
        }, completion: completion)
    }
    
    func moveUp(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ delay: Double, _ speedOptions: UIView.AnimationOptions, _ completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: time, delay: delay, options: speedOptions,
        animations: {
            button.frame.origin.y -= amount
        }, completion: completion)
    }
    
    func moveDown(_ button: UIButton, _ amount: CGFloat, _ time: Double, _ delay: Double, _ speedOptions: UIView.AnimationOptions, _ completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: time, delay: delay, options: speedOptions,
        animations: {
            button.frame.origin.y += amount
        }, completion: completion)
    }
    
    func scale(_ button: UIButton, _ amount: CGFloat, _ time: Double) {
        UIView.animate(withDuration: time) {
            button.transform = CGAffineTransform(scaleX: amount, y: amount)
        }
    }
    
    func pop(_ button: UIButton, _ amount: CGFloat, _ time: Double) {
        UIView.animate(withDuration: time, animations: {
            button.transform = CGAffineTransform(scaleX: amount, y: amount)
        }, completion: { _ in
            UIView.animate(withDuration: time) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    // MARK: - UIView Animations
    func moveUp(_ view: UIView, _ amount: CGFloat, _ time: Double, _ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            view.frame.origin.y -= amount
        }, completion: nil)
    }
    
    func moveDown(_ view: UIView, _ amount: CGFloat, _ time: Double, _ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: 0.0, options: speedOptions,
        animations: {
            view.frame.origin.y += amount
        }, completion: nil)
    }
    
    func fade(_ view: UIView, _ time: Double, _ delay: Double, _ speedOptions: UIView.AnimationOptions) {
        UIView.animate(withDuration: time, delay: delay, options: speedOptions,
        animations: {
            view.alpha = 0.0
        }, completion: nil)
    }
    
    // MARK: - Toast Animations
    func toast(_ view: UIView, _ message: String) {
        view.makeToast(message)
    }
    
}
