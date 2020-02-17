//
//  BackCover.swift
//  Narrative
//
//  Created by James Castrejon on 3/16/19.
//  Copyright © 2019 James Castrejon. All rights reserved.
//

import UIKit
import Lottie
import ChainableAnimations
import IGColorPicker
import ChromaColorPicker
import YPImagePicker

class BackCover: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var tapVisibility: UITapGestureRecognizer!
    
    @IBOutlet var buttonMenu: UIButton!
    @IBOutlet var buttonReset: UIButton!
    @IBOutlet var buttonResetSave: UIButton!
    @IBOutlet var buttonSave: UIButton!
    @IBOutlet var buttonExit: UIButton!
    
    @IBOutlet var buttonBackground: UIButton!
    @IBOutlet var buttonPalette: UIButton!
    @IBOutlet var buttonProPalette: UIButton!
    @IBOutlet var buttonImport: UIButton!
    
    @IBOutlet var buttonFormat: UIButton!
    @IBOutlet var buttonFullscreen: UIButton!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet var labelPageNumberEditor: UILabel!
    
    // MARK: Variables
    var bManager: ButtonManager!
    var previousColor: UIColor = UIColor.white
    var colorPickerView: ColorPickerView!
    var neatColorPicker: ChromaColorPicker!
    let picker = YPImagePicker()
    // TODO: Replace this with loaded color/image, keep white if nonexistent
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bManager = ButtonManager()
        
        self.setupColorPicker()
        self.setupProColorPicker()
        self.setupButtons()
    }
    
    private func setupColorPicker() {
        colorPickerView = ColorPickerView(frame: CGRect(x: 0.0, y: 0.0, width: 180, height: 200))
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.center = self.view.center
        colorPickerView.selectionStyle = ColorPickerViewSelectStyle.none
        colorPickerView.backgroundColor = UIColor.clear
        colorPickerView.isHidden = true
        
        view.addSubview(colorPickerView)
    }
    
    private func setupProColorPicker() {
        neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker.delegate = self
        neatColorPicker.center = self.view.center
        neatColorPicker.padding = 5
        neatColorPicker.stroke = 3
        neatColorPicker.hexLabel.textColor = UIColor.white
        neatColorPicker.isHidden = true
        
        view.addSubview(neatColorPicker)
    }
    
    private func setupButtons() {
        bManager.addRadius(for: buttonBackground)
        bManager.addRadius(for: buttonPalette)
        bManager.addRadius(for: buttonProPalette)
        bManager.addRadius(for: buttonImport)
        bManager.addRadius(for: buttonFormat)
        bManager.addRadius(for: buttonFullscreen)
        bManager.addShadow(for: buttonExit)
        bManager.addShadow(for: buttonBackground)
        bManager.addShadow(for: buttonPalette)
        bManager.addShadow(for: buttonProPalette)
        bManager.addShadow(for: buttonImport)
        bManager.addShadow(for: buttonFormat)
        bManager.addShadow(for: buttonFullscreen)
        bManager.hideShadow(for: buttonPalette)
        bManager.hideShadow(for: buttonProPalette)
        bManager.hideShadow(for: buttonImport)
        setupButtonAnimations()
    }
    
    private func setupButtonAnimations() {
        addAnimations(for: buttonMenu, with: "HamburgerMenu", 100, 100)
    }
    
    private func addAnimations(for button: UIButton,with animation: String,_ width:CGFloat,_ height: CGFloat) {
        let animationView = LOTAnimationView(name: animation)
        animationView.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: height)
        animationView.center = button.center
        animationView.contentMode = .scaleAspectFit
        animationView.isUserInteractionEnabled = false
        
        button.addSubview(animationView)
    }
    
    // MARK: Button Functionality
    @IBAction func menuVisibility(_ sender: Any) {
        bManager.disable(buttonMenu)
        
        if !buttonExit.isEnabled {
            // TODO: disable text
            bManager.disable(buttonBackground)
            bManager.disable(buttonFormat)
            bManager.disable(buttonFullscreen)
            
            let animationView:LOTAnimationView = buttonMenu.subviews.first as! LOTAnimationView
            animationView.play(fromProgress: 0.0, toProgress: 0.5) { (completed) in
                self.bManager.enable(self.buttonMenu)
            }
            
            bManager.enable(buttonReset)
            bManager.enable(buttonResetSave)
            bManager.enable(buttonSave)
            bManager.enable(buttonExit)
            var animator: ChainableAnimator = ChainableAnimator(view: buttonReset)
            animator.transform(y: 40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonResetSave)
            animator.transform(y: 40).thenAfter(t: 0.2).transform(y: 40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonSave)
            animator.transform(y: 40).thenAfter(t: 0.2).transform(y: 40).thenAfter(t: 0.2).transform(y: 40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonExit)
            animator.transform(y: 40).thenAfter(t: 0.2).transform(y: 40).thenAfter(t: 0.2).transform(y: 40).thenAfter(t: 0.2).transform(y: 40).animate(t: 0.2)
        }
        else {
            let animationView:LOTAnimationView = buttonMenu.subviews.first as! LOTAnimationView
            animationView.play(fromProgress: 0.5, toProgress: 1.0) { (completed) in
                self.bManager.enable(self.buttonMenu)
            }
            
            bManager.disable(buttonReset)
            bManager.disable(buttonResetSave)
            bManager.disable(buttonSave)
            bManager.disable(buttonExit)
            var animator: ChainableAnimator = ChainableAnimator(view: buttonReset)
            animator.transform(y: -40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonResetSave)
            animator.transform(y: -40).thenAfter(t: 0.2).transform(y: -40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonSave)
            animator.transform(y: -40).thenAfter(t: 0.2).transform(y: -40).thenAfter(t: 0.2).transform(y: -40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonExit)
            animator.transform(y: -40).thenAfter(t: 0.2).transform(y: -40).thenAfter(t: 0.2).transform(y: -40).thenAfter(t: 0.2).transform(y: -40).animate(t: 0.2) {
                self.bManager.enable(self.buttonBackground)
                self.bManager.enable(self.buttonFormat)
                self.bManager.enable(self.buttonFullscreen)
            }
        }
    }
    @IBAction func reset(_ sender: Any) {
        
    }
    
    @IBAction func resetSave(_ sender: Any) {
        
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backgroundMenuVisibility(_ sender: Any) {
        bManager.disable(buttonBackground)
        if !buttonPalette.isEnabled {
            bManager.disable(buttonMenu)
            bManager.disable(buttonFormat)
            bManager.disable(buttonFullscreen)
            
            var animator: ChainableAnimator = ChainableAnimator(view: buttonPalette)
            animator.transform(x: -55).thenAfter(t: 0.2).transform(y: -60).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonProPalette)
            animator.transform(x: -55).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonImport)
            animator.transform(x: -55).thenAfter(t: 0.2).transform(y: 60).animate(t: 0.2) {
                self.bManager.enable(self.buttonPalette)
                self.bManager.enable(self.buttonProPalette)
                self.bManager.enable(self.buttonImport)
                self.bManager.enable(self.buttonBackground)
                self.bManager.showShadow(for: self.buttonPalette)
                self.bManager.showShadow(for: self.buttonProPalette)
                self.bManager.showShadow(for: self.buttonImport)
            }
        }
        else {
            bManager.disable(buttonPalette)
            bManager.disable(buttonProPalette)
            bManager.disable(buttonImport)
            bManager.hideShadow(for: buttonPalette)
            bManager.hideShadow(for: buttonProPalette)
            bManager.hideShadow(for: buttonImport)
            
            var animator: ChainableAnimator = ChainableAnimator(view: buttonPalette)
            animator.transform(y: 60).thenAfter(t: 0.2).transform(x: 55).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonProPalette)
            animator.transform(x: 55).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonImport)
            animator.transform(y: -60).thenAfter(t: 0.2).transform(x: 55).animate(t: 0.2) {
                self.bManager.enable(self.buttonMenu)
                self.bManager.enable(self.buttonBackground)
                self.bManager.enable(self.buttonFormat)
                self.bManager.enable(self.buttonFullscreen)
            }
        }
    }
    
    @IBAction func changeBackgroundColorStandard(_ sender: Any) {
        if colorPickerView.isHidden {
            colorPickerView.isHidden = false
            bManager.disable(buttonProPalette)
            bManager.disable(buttonImport)
            bManager.disable(buttonBackground)
            tapVisibility.isEnabled = true
        }
        else {
            colorPickerView.isHidden = true
            bManager.enable(buttonProPalette)
            bManager.enable(buttonImport)
            bManager.enable(buttonBackground)
            tapVisibility.isEnabled = false
        }
        (self.parent as! BookManager).changeSwipeGesture(enabled: colorPickerView.isHidden)
    }
    
    @IBAction func changeBackgroundColorSpecial(_ sender: Any) {
        if neatColorPicker.isHidden {
            neatColorPicker.isHidden = false
            bManager.disable(buttonPalette)
            bManager.disable(buttonImport)
            bManager.disable(buttonBackground)
            tapVisibility.isEnabled = true
        }
        else {
            neatColorPicker.isHidden = true
            bManager.enable(buttonPalette)
            bManager.enable(buttonImport)
            bManager.enable(buttonBackground)
            tapVisibility.isEnabled = false
        }
        (self.parent as! BookManager).changeSwipeGesture(enabled: neatColorPicker.isHidden)
    }
    
    @IBAction func changeBackgroundImportImage(_ sender: Any) {
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.view.backgroundColor = UIColor.white
                self.imageBackground.image = photo.image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func changePageFormat(_ sender: Any) {
        print("Format")
    }
    
    @IBAction func hideUIElements(_ sender: Any) {
        var animator: ChainableAnimator = ChainableAnimator(view: buttonMenu)
        animator.transform(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonReset)
        animator.transform(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonResetSave)
        animator.transform(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonSave)
        animator.transform(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonExit)
        animator.transform(x: -80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonBackground)
        animator.transform(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonPalette)
        animator.transform(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonProPalette)
        animator.transform(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonImport)
        animator.transform(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonFormat)
        animator.transform(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonFullscreen)
        animator.transform(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: labelPageNumberEditor)
        animator.transform(y: 80).animate(t: 0.3)
        
        tapVisibility.isEnabled = true
    }
    
    // MARK: Tap Register
    @IBAction func uielementsVisibility(_ sender: Any) {
        if !colorPickerView.isHidden || !neatColorPicker.isHidden {
            bManager.enable(buttonPalette)
            bManager.enable(buttonProPalette)
            bManager.enable(buttonImport)
            bManager.enable(buttonBackground)
            tapVisibility.isEnabled = false
            if !colorPickerView.isHidden {
                colorPickerView.isHidden = true
                (self.parent as! BookManager).changeSwipeGesture(enabled: colorPickerView.isHidden)
            }
            else if !neatColorPicker.isHidden {
                neatColorPicker.isHidden = true
                (self.parent as! BookManager).changeSwipeGesture(enabled: neatColorPicker.isHidden)
            }
        }
        else {
            var animator: ChainableAnimator = ChainableAnimator(view: buttonMenu)
            animator.transform(x: 80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonReset)
            animator.transform(x: 80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonResetSave)
            animator.transform(x: 80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonSave)
            animator.transform(x: 80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonExit)
            animator.transform(x: 80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonBackground)
            animator.transform(x: -80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonPalette)
            animator.transform(x: -80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonProPalette)
            animator.transform(x: -80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonImport)
            animator.transform(x: -80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonFormat)
            animator.transform(x: -80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonFullscreen)
            animator.transform(x: -80).animate(t: 0.3)
            animator = ChainableAnimator(view: labelPageNumberEditor)
            animator.transform(y: -80).animate(t: 0.3)
            tapVisibility.isEnabled = false
        }
    }
    
}

// MARK: - ColorPickerViewDelegate
extension BackCover: ColorPickerViewDelegate {
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        // TODO: refactor this method
        // A color has been selected
        self.imageBackground.image = nil
        bManager.enable(buttonPalette)
        colorPickerView.isHidden = true
        bManager.enable(buttonProPalette)
        bManager.enable(buttonImport)
        if previousColor != colorPickerView.colors[indexPath.row] {
            previousColor = colorPickerView.colors[indexPath.row]
            self.view.backgroundColor = colorPickerView.colors[indexPath.row]
        }
        else {
            previousColor = UIColor.white
            self.view.backgroundColor = UIColor.white
        }
        (self.parent as! BookManager).changeSwipeGesture(enabled: true)
        tapVisibility.isEnabled = false
    }
}

// MARK: - ColorPickerViewDelegateFlowLayout
extension BackCover: ColorPickerViewDelegateFlowLayout {
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The size for each cell
        // 👉🏻 WIDTH AND HEIGHT MUST BE EQUALS!
        return CGSize(width: 30, height: 30)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Space between cells
        return 0.0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Space between rows
        return 0.0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

// MARK: - ChromaColorPicker Delegate
extension BackCover: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        self.imageBackground.image = nil
        bManager.enable(buttonBackground)
        previousColor = color
        self.view.backgroundColor = color
        neatColorPicker.isHidden = true
        bManager.enable(buttonPalette)
        bManager.enable(buttonImport)
        (self.parent as! BookManager).changeSwipeGesture(enabled: true)
        tapVisibility.isEnabled = false
    }
}
