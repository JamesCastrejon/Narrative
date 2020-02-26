//
//  BackCover.swift
//  Narrative
//
//  Created by James Castrejon on 3/16/19.
//  Copyright © 2019 James Castrejon. All rights reserved.
//

import UIKit
import Lottie
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
    var animator: AnimationManager!
    var previousColor: UIColor = UIColor.white
    var colorPickerView: ColorPickerView!
    var proColorPickerView: ChromaColorPicker!
    let picker = YPImagePicker()
    // TODO: Replace this with loaded color/image, keep white if nonexistent
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bManager = ButtonManager()
        animator = AnimationManager()
        
        self.setupColorPicker()
        self.setupProColorPicker()
        self.setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelPageNumberEditor.alpha = 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animator.fade(labelPageNumberEditor, 1.0, 1.0, .curveLinear)
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
        proColorPickerView = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        proColorPickerView.delegate = self
        proColorPickerView.center = self.view.center
        proColorPickerView.padding = 5
        proColorPickerView.stroke = 3
        proColorPickerView.hexLabel.textColor = UIColor.white
        proColorPickerView.isHidden = true
        
        view.addSubview(proColorPickerView)
    }
    
    private func setupButtons() {
        bManager.addRadius(for: buttonBackground)
        bManager.addRadius(for: buttonPalette)
        bManager.addRadius(for: buttonProPalette)
        bManager.addRadius(for: buttonImport)
        bManager.addRadius(for: buttonFormat)
        bManager.addRadius(for: buttonFullscreen)
        bManager.addShadow(for: buttonMenu)
        bManager.addShadow(for: buttonExit)
        bManager.addShadow(for: buttonBackground)
        bManager.addShadow(for: buttonPalette)
        bManager.addShadow(for: buttonProPalette)
        bManager.addShadow(for: buttonImport)
        bManager.addShadow(for: buttonFormat)
        bManager.addShadow(for: buttonFullscreen)
        setupButtonAnimations()
    }
    
    private func setupButtonAnimations() {
        addAnimations(for: buttonMenu, with: "HamburgerMenu", 100, 100)
    }
    
    private func addAnimations(for button: UIButton,with animation: String,_ width:CGFloat,_ height: CGFloat) {
        let animationView = AnimationView(name: animation)
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
            
            let animationView:AnimationView = buttonMenu.subviews.first as! AnimationView
            animationView.play(fromProgress: 0.1, toProgress: 0.5) { (completed) in
                self.bManager.enable(self.buttonMenu)
            }
            
            bManager.enable(buttonReset)
            bManager.enable(buttonResetSave)
            bManager.enable(buttonSave)
            bManager.enable(buttonExit)
            bManager.show(buttonReset)
            bManager.show(buttonResetSave)
            bManager.show(buttonSave)
            bManager.show(buttonExit)
            
            animator.moveDown(buttonReset, 40, 0.2, .curveEaseOut)
            animator.moveDown(buttonResetSave, 80, 0.4, .curveEaseOut)
            animator.moveDown(buttonSave, 120, 0.6, .curveEaseOut)
            animator.moveDown(buttonExit, 160, 0.8, .curveEaseOut)
        }
        else {
            let animationView:AnimationView = buttonMenu.subviews.first as! AnimationView
            animationView.play(fromProgress: 0.6, toProgress: 1.0) { (completed) in
                self.bManager.enable(self.buttonMenu)
            }
            
            bManager.disable(buttonReset)
            bManager.disable(buttonResetSave)
            bManager.disable(buttonSave)
            bManager.disable(buttonExit)
            animator.moveUp(buttonReset, 40, 0.8, 0.0, .curveEaseOut) { _ in
                self.bManager.hide(self.buttonReset)
                self.bManager.hide(self.buttonResetSave)
                self.bManager.hide(self.buttonSave)
            }
            animator.moveUp(buttonResetSave, 80, 0.6, .curveEaseOut)
            animator.moveUp(buttonSave, 120, 0.4, .curveEaseOut)
            animator.moveUp(buttonExit, 160, 0.2, 0.0, .curveEaseOut) { _ in
                self.bManager.hide(self.buttonExit)
            }
            
            bManager.enable(buttonBackground)
            bManager.enable(buttonFormat)
            bManager.enable(buttonFullscreen)
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        print("Touched Reset")
    }
    
    @IBAction func resetSave(_ sender: Any) {
        print("Touched Reset & Save")
    }
    
    @IBAction func save(_ sender: Any) {
        print("Touched Save")
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
            
            bManager.show(buttonPalette)
            bManager.show(buttonProPalette)
            bManager.show(buttonImport)
            
            animator.moveLeft(buttonPalette, 55, 0.4, .curveEaseIn)
            animator.moveUp(buttonPalette, 60, 0.4, .curveEaseIn)
            animator.moveLeft(buttonProPalette, 55, 0.4, 0.1, .curveEaseIn, nil)
            animator.moveLeft(buttonImport, 55, 0.4, 0.2, .curveEaseIn, nil)
            animator.moveDown(buttonImport, 60, 0.4, 0.2, .curveEaseIn) { _ in
                self.bManager.enable(self.buttonBackground)
            }
            
            bManager.enable(buttonPalette)
            bManager.enable(buttonProPalette)
            bManager.enable(buttonImport)
        }
        else {
            bManager.disable(buttonPalette)
            bManager.disable(buttonProPalette)
            bManager.disable(buttonImport)
            
            animator.moveDown(buttonPalette, 60, 0.4, .curveEaseIn)
            animator.moveRight(buttonPalette, 55, 0.4, .curveEaseIn)
            animator.moveRight(buttonProPalette, 55, 0.4, 0.1, .curveEaseIn, nil)
            animator.moveUp(buttonImport, 60, 0.4, 0.2, .curveEaseIn, nil)
            animator.moveRight(buttonImport, 55, 0.4, 0.2, .curveEaseIn) { _ in
                self.bManager.hide(self.buttonPalette)
                self.bManager.hide(self.buttonProPalette)
                self.bManager.hide(self.buttonImport)
            }
            
            bManager.enable(buttonMenu)
            bManager.enable(buttonBackground)
            bManager.enable(buttonFormat)
            bManager.enable(buttonFullscreen)
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
        if proColorPickerView.isHidden {
            proColorPickerView.isHidden = false
            bManager.disable(buttonPalette)
            bManager.disable(buttonImport)
            bManager.disable(buttonBackground)
            tapVisibility.isEnabled = true
        }
        else {
            proColorPickerView.isHidden = true
            bManager.enable(buttonPalette)
            bManager.enable(buttonImport)
            bManager.enable(buttonBackground)
            tapVisibility.isEnabled = false
        }
        (self.parent as! BookManager).changeSwipeGesture(enabled: proColorPickerView.isHidden)
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
        print("Touched Format")
    }
    
    @IBAction func hideUIElements(_ sender: Any) {
        animator.moveLeft(buttonMenu, 80, 0.3, .curveEaseIn)
        animator.moveRight(buttonBackground, 80, 0.3, .curveEaseIn)
        animator.moveRight(buttonFormat, 80, 0.3, .curveEaseIn)
        animator.moveRight(buttonFullscreen, 80, 0.3, .curveEaseIn)
        
        tapVisibility.isEnabled = true
    }
    
    // MARK: Tap Register
    @IBAction func uielementsVisibility(_ sender: Any) {
        if !colorPickerView.isHidden || !proColorPickerView.isHidden {
            bManager.enable(buttonPalette)
            bManager.enable(buttonProPalette)
            bManager.enable(buttonImport)
            bManager.enable(buttonBackground)
            tapVisibility.isEnabled = false
            if !colorPickerView.isHidden {
                colorPickerView.isHidden = true
                (self.parent as! BookManager).changeSwipeGesture(enabled: colorPickerView.isHidden)
            }
            else if !proColorPickerView.isHidden {
                proColorPickerView.isHidden = true
                (self.parent as! BookManager).changeSwipeGesture(enabled: proColorPickerView.isHidden)
            }
        }
        else {
            animator.moveRight(buttonMenu, 80, 0.3, .curveEaseOut)
            animator.moveLeft(buttonBackground, 80, 0.3, .curveEaseOut)
            animator.moveLeft(buttonFormat, 80, 0.3, .curveEaseOut)
            animator.moveLeft(buttonFullscreen, 80, 0.3, .curveEaseOut)
            tapVisibility.isEnabled = false
        }
    }
    
}

// MARK: - ColorPickerViewDelegate
extension BackCover: ColorPickerViewDelegate {
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        // TODO: refactor this method
        // A color has been selected
        imageBackground.image = nil
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
        imageBackground.image = nil
        bManager.enable(buttonBackground)
        previousColor = color
        self.view.backgroundColor = color
        proColorPickerView.isHidden = true
        bManager.enable(buttonPalette)
        bManager.enable(buttonImport)
        (self.parent as! BookManager).changeSwipeGesture(enabled: true)
        tapVisibility.isEnabled = false
    }
}
