//
//  Page.swift
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

class Page: UIViewController {
    
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
    @IBOutlet var buttonAddPage: UIButton!
    @IBOutlet var buttonDeletePage: UIButton!
    @IBOutlet var buttonFullscreen: UIButton!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet var labelPageNumberEditor: UILabel!
    
    // MARK: Variables
    var previousColor: UIColor = UIColor.white
    var colorPickerView: ColorPickerView!
    var neatColorPicker: ChromaColorPicker!
    let picker = YPImagePicker()
    // TODO: Replace this with loaded color/image, keep white if nonexistent
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelPageNumberEditor.text = "Page \(Book.pageNumber)"
        self.setupColorPicker()
        self.setupProColorPicker()
        self.setupButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        labelPageNumberEditor.text = "Page \(Book.pageNumber)"
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
        setupButtonRadius()
        setupButtonShadows()
        setupButtonAnimations()
    }
    
    private func setupButtonRadius() {
        let buttonWidth = buttonBackground.bounds.size.width
        
        buttonBackground.layer.cornerRadius = 0.5 * buttonWidth
        buttonPalette.layer.cornerRadius = 0.5 * buttonWidth
        buttonProPalette.layer.cornerRadius = 0.5 * buttonWidth
        buttonImport.layer.cornerRadius = 0.5 * buttonWidth
        
        
        buttonFormat.layer.cornerRadius = 0.5 * buttonWidth
        buttonAddPage.layer.cornerRadius = 0.5 * buttonWidth
        buttonDeletePage.layer.cornerRadius = 0.5 * buttonWidth
        buttonFullscreen.layer.cornerRadius = 0.5 * buttonWidth
    }
    
    private func setupButtonShadows() {
        addShadows(for: buttonExit)
        addShadows(for: buttonBackground)
        addShadows(for: buttonPalette)
        addShadows(for: buttonProPalette)
        addShadows(for: buttonImport)
        addShadows(for: buttonFormat)
        addShadows(for: buttonAddPage)
        addShadows(for: buttonDeletePage)
        addShadows(for: buttonFullscreen)
        buttonPalette.layer.shadowColor = UIColor.clear.cgColor
        buttonProPalette.layer.shadowColor = UIColor.clear.cgColor
        buttonImport.layer.shadowColor = UIColor.clear.cgColor
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
        buttonMenu.isEnabled = false
        
        if !buttonExit.isEnabled {
            // TODO: disable text, background, fullscreen
            buttonBackground.isEnabled = false
            buttonFormat.isEnabled = false
            buttonAddPage.isEnabled = false
            buttonDeletePage.isEnabled = false
            buttonFullscreen.isEnabled = false
            
            let animationView:LOTAnimationView = buttonMenu.subviews.first as! LOTAnimationView
            animationView.play(fromProgress: 0.0, toProgress: 0.5) { (completed) in
                self.buttonMenu.isEnabled = true
            }
            
            buttonReset.isEnabled = true
            buttonResetSave.isEnabled = true
            buttonSave.isEnabled = true
            buttonExit.isEnabled = true
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
                self.buttonMenu.isEnabled = true
            }
            
            buttonReset.isEnabled = true
            buttonResetSave.isEnabled = true
            buttonSave.isEnabled = false
            buttonExit.isEnabled = false
            var animator: ChainableAnimator = ChainableAnimator(view: buttonReset)
            animator.transform(y: -40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonResetSave)
            animator.transform(y: -40).thenAfter(t: 0.2).transform(y: -40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonSave)
            animator.transform(y: -40).thenAfter(t: 0.2).transform(y: -40).thenAfter(t: 0.2).transform(y: -40).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonExit)
            animator.transform(y: -40).thenAfter(t: 0.2).transform(y: -40).thenAfter(t: 0.2).transform(y: -40).thenAfter(t: 0.2).transform(y: -40).animate(t: 0.2) {
                self.buttonBackground.isEnabled = true
                self.buttonFormat.isEnabled = true
                self.buttonAddPage.isEnabled = true
                self.buttonDeletePage.isEnabled = true
                self.buttonFullscreen.isEnabled = true
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
        buttonBackground.isEnabled = false
        if !buttonPalette.isEnabled {
            buttonMenu.isEnabled = false
            buttonFormat.isEnabled = false
            buttonAddPage.isEnabled = false
            buttonDeletePage.isEnabled = false
            buttonFullscreen.isEnabled = false
            
            var animator: ChainableAnimator = ChainableAnimator(view: buttonPalette)
            animator.transform(x: -55).thenAfter(t: 0.2).transform(y: -60).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonProPalette)
            animator.transform(x: -55).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonImport)
            animator.transform(x: -55).thenAfter(t: 0.2).transform(y: 60).animate(t: 0.2) {
                self.buttonPalette.isEnabled = true
                self.buttonProPalette.isEnabled = true
                self.buttonImport.isEnabled = true
                self.buttonBackground.isEnabled = true
                self.buttonPalette.layer.shadowColor = UIColor.black.cgColor
                self.buttonProPalette.layer.shadowColor = UIColor.black.cgColor
                self.buttonImport.layer.shadowColor = UIColor.black.cgColor
            }
        }
        else {
            buttonPalette.isEnabled = false
            buttonProPalette.isEnabled = false
            buttonImport.isEnabled = false
            buttonPalette.layer.shadowColor = UIColor.clear.cgColor
            buttonProPalette.layer.shadowColor = UIColor.clear.cgColor
            buttonImport.layer.shadowColor = UIColor.clear.cgColor
            
            var animator: ChainableAnimator = ChainableAnimator(view: buttonPalette)
            animator.transform(y: 60).thenAfter(t: 0.2).transform(x: 55).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonProPalette)
            animator.transform(x: 55).animate(t: 0.2)
            animator = ChainableAnimator(view: buttonImport)
            animator.transform(y: -60).thenAfter(t: 0.2).transform(x: 55).animate(t: 0.2) {
                self.buttonMenu.isEnabled = true
                self.buttonBackground.isEnabled = true
                self.buttonFormat.isEnabled = true
                self.buttonAddPage.isEnabled = true
                self.buttonDeletePage.isEnabled = true
                self.buttonFullscreen.isEnabled = true
            }
        }
    }
    
    @IBAction func changeBackgroundColorStandard(_ sender: Any) {
        if colorPickerView.isHidden {
            colorPickerView.isHidden = false
            buttonProPalette.isEnabled = false
            buttonImport.isEnabled = false
            buttonBackground.isEnabled = false
            tapVisibility.isEnabled = true
        }
        else {
            colorPickerView.isHidden = true
            buttonProPalette.isEnabled = true
            buttonImport.isEnabled = true
            buttonBackground.isEnabled = true
            tapVisibility.isEnabled = false
        }
        (self.parent as! BookManager).changeSwipeGesture(enabled: colorPickerView.isHidden)
    }
    
    @IBAction func changeBackgroundColorSpecial(_ sender: Any) {
        if neatColorPicker.isHidden {
            neatColorPicker.isHidden = false
            buttonPalette.isEnabled = false
            buttonImport.isEnabled = false
            buttonBackground.isEnabled = false
            tapVisibility.isEnabled = true
        }
        else {
            neatColorPicker.isHidden = true
            buttonPalette.isEnabled = true
            buttonImport.isEnabled = true
            buttonBackground.isEnabled = true
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
    
    @IBAction func addPage(_ sender: Any) {
        if Book.orderedViewControllers.count < 20 && self.restorationIdentifier != "BackCover" {
            var book: Book = Book()
            book.addPage()
        } else {
            let alertController = UIAlertController(title: "Oh, no!", message: "Sorry but you cannot have more than 20 pages.\n:(", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Okay", style: .default)
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func deletePage(_ sender: Any) {
        if Book.orderedViewControllers.count > 3 && self.restorationIdentifier! != "FrontCover" && self.restorationIdentifier! != "BackCover" {
            let alertController = UIAlertController(title: "Stop!", message: "Are you sure?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Yes", style: .destructive) { (action:UIAlertAction) in
                (self.parent as! BookManager).goToPreviousPage(self)
                var book: Book = Book()
                book.deletePage()
            }
            let action2 = UIAlertAction(title: "No thanks.", style: .default)
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Oh, no!", message: "Sorry but you cannot delete more than 3 pages.\n:(", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Okay", style: .default)
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
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
        animator = ChainableAnimator(view: buttonAddPage)
        animator.transform(x: 80).animate(t: 0.3)
        animator = ChainableAnimator(view: buttonDeletePage)
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
            buttonPalette.isEnabled = true
            buttonProPalette.isEnabled = true
            buttonImport.isEnabled = true
            buttonBackground.isEnabled = true
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
            animator = ChainableAnimator(view: buttonAddPage)
            animator.transform(x: -80).animate(t: 0.3)
            animator = ChainableAnimator(view: buttonDeletePage)
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
extension Page: ColorPickerViewDelegate {
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        // TODO: refactor this method
        // A color has been selected
        self.imageBackground.image = nil
        buttonBackground.isEnabled = true
        colorPickerView.isHidden = true
        buttonProPalette.isEnabled = true
        buttonImport.isEnabled = true
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
extension Page: ColorPickerViewDelegateFlowLayout {
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
extension Page: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        self.imageBackground.image = nil
        buttonBackground.isEnabled = true
        previousColor = color
        self.view.backgroundColor = color
        neatColorPicker.isHidden = true
        buttonPalette.isEnabled = true
        buttonImport.isEnabled = true
        (self.parent as! BookManager).changeSwipeGesture(enabled: true)
        tapVisibility.isEnabled = false
    }
}
