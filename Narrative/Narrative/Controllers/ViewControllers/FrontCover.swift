//
//  FrontCover.swift
//  Narrative
//
//  Created by James Castrejon on 2/21/19.
//  Copyright © 2019 James Castrejon. All rights reserved.
//

import UIKit
import IGColorPicker
import ChromaColorPicker
import YPImagePicker

class FrontCover: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var tapVisibility: UITapGestureRecognizer!
    @IBOutlet var tapTitle: UITapGestureRecognizer!
    @IBOutlet var tapSubtitle: UITapGestureRecognizer!
    @IBOutlet var tapAuthor: UITapGestureRecognizer!
    
    @IBOutlet var viewCover: UIView!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSubtitle: UILabel!
    @IBOutlet var labelAuthor: UILabel!
    
    @IBOutlet var buttonMenu: UIButton!
    @IBOutlet var buttonReset: UIButton!
    @IBOutlet var buttonResetSave: UIButton!
    @IBOutlet var buttonSave: UIButton!
    @IBOutlet var buttonExit: UIButton!
    
    @IBOutlet var buttonEdit: UIButton!
    @IBOutlet var buttonEditPalette: UIButton!
    @IBOutlet var buttonEditProPalette: UIButton!
    @IBOutlet var buttonFontFamily: UIButton!
    
    @IBOutlet var buttonBackground: UIButton!
    @IBOutlet var buttonPalette: UIButton!
    @IBOutlet var buttonProPalette: UIButton!
    @IBOutlet var buttonImport: UIButton!
    
    @IBOutlet var buttonFormat: UIButton!
    
    @IBOutlet var buttonAddPage: UIButton!
    @IBOutlet var buttonFullscreen: UIButton!
    @IBOutlet var textFieldEdit: UITextField!
    @IBOutlet var labelPageNumberEditor: UILabel!
    
    // MARK: Variables
    var bManager: ButtonManager!
    var animator: AnimationManager!
    var selectedLabel: UILabel?
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
        textFieldEdit.delegate = self
        
        setupColorPicker()
        setupProColorPicker()
        setupButtons()
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
        bManager.addRadius(for: buttonEdit)
        bManager.addRadius(for: buttonEditPalette)
        bManager.addRadius(for: buttonEditProPalette)
        bManager.addRadius(for: buttonFontFamily)
        bManager.addRadius(for: buttonBackground)
        bManager.addRadius(for: buttonPalette)
        bManager.addRadius(for: buttonProPalette)
        bManager.addRadius(for: buttonImport)
        bManager.addRadius(for: buttonFormat)
        bManager.addRadius(for: buttonAddPage)
        bManager.addRadius(for: buttonFullscreen)
        bManager.addShadow(for: buttonMenu)
        bManager.addShadow(for: buttonExit)
        bManager.addShadow(for: buttonEdit)
        bManager.addShadow(for: buttonEditPalette)
        bManager.addShadow(for: buttonEditProPalette)
        bManager.addShadow(for: buttonFontFamily)
        bManager.addShadow(for: buttonBackground)
        bManager.addShadow(for: buttonPalette)
        bManager.addShadow(for: buttonProPalette)
        bManager.addShadow(for: buttonImport)
        bManager.addShadow(for: buttonFormat)
        bManager.addShadow(for: buttonAddPage)
        bManager.addShadow(for: buttonFullscreen)
    }
    
    // MARK: Button Functionality
    @IBAction func menuVisibility(_ sender: Any) {
        deselectLabel()
        bManager.disable(buttonMenu)
        if !buttonExit.isEnabled {
            // TODO: disable text
            bManager.disable(buttonBackground)
            bManager.disable(buttonFormat)
            bManager.disable(buttonAddPage)
            bManager.disable(buttonFullscreen)
            tapTitle.isEnabled = false
            tapSubtitle.isEnabled = false
            tapAuthor.isEnabled = false
            
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
            animator.moveDown(buttonExit, 160, 0.8, 0.0, .curveEaseOut) { _ in
                self.bManager.enable(self.buttonMenu)
            }
        }
        else {
            bManager.disable(buttonReset)
            bManager.disable(buttonResetSave)
            bManager.disable(buttonSave)
            bManager.disable(buttonExit)
            animator.moveUp(buttonReset, 40, 0.8, 0.0, .curveEaseOut) { _ in
                self.bManager.hide(self.buttonReset)
                self.bManager.hide(self.buttonResetSave)
                self.bManager.hide(self.buttonSave)
                self.bManager.enable(self.buttonMenu)
            }
            animator.moveUp(buttonResetSave, 80, 0.6, .curveEaseOut)
            animator.moveUp(buttonSave, 120, 0.4, .curveEaseOut)
            animator.moveUp(buttonExit, 160, 0.2, 0.0, .curveEaseOut) { _ in
                self.bManager.hide(self.buttonExit)
            }
            
            bManager.enable(buttonBackground)
            bManager.enable(buttonFormat)
            bManager.enable(buttonAddPage)
            bManager.enable(buttonFullscreen)
            tapTitle.isEnabled = true
            tapSubtitle.isEnabled = true
            tapAuthor.isEnabled = true
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
    
    @IBAction func editMenuVisibility(_ sender: Any) {
        bManager.disable(buttonEdit)
        if !buttonEditPalette.isEnabled {
            bManager.disable(buttonMenu)
            bManager.disable(buttonBackground)
            bManager.disable(buttonFormat)
            bManager.disable(buttonAddPage)
            bManager.disable(buttonFullscreen)
            tapTitle.isEnabled = false
            tapSubtitle.isEnabled = false
            tapAuthor.isEnabled = false
            textFieldEdit.isEnabled = false
            
            bManager.show(buttonEditPalette)
            bManager.show(buttonEditProPalette)
            bManager.show(buttonFontFamily)
            
            animator.moveLeft(buttonEditPalette, 55, 0.4, .curveEaseOut)
            animator.moveLeft(buttonEditProPalette, 55, 0.4, 0.08, .curveEaseOut, nil)
            animator.moveUp(buttonEditProPalette, 60, 0.4, 0.08, .curveEaseOut, nil)
            animator.moveUp(buttonFontFamily, 60, 0.4, 0.16, .curveEaseOut) { _ in
                self.bManager.enable(self.buttonEdit)
            }
            bManager.enable(buttonEditPalette)
            bManager.enable(buttonEditProPalette)
            bManager.enable(buttonFontFamily)
        } else {
            bManager.disable(buttonEditPalette)
            bManager.disable(buttonEditProPalette)
            bManager.disable(buttonFontFamily)
            
            animator.moveRight(buttonEditPalette, 55, 0.4, .curveEaseIn)
            animator.moveRight(buttonEditProPalette, 55, 0.4, 0.08, .curveEaseIn, nil)
            animator.moveDown(buttonEditProPalette, 60, 0.4, 0.08, .curveEaseIn, nil)
            animator.moveDown(buttonFontFamily, 60, 0.4, 0.16, .curveEaseIn) { _ in
                self.bManager.enable(self.buttonEdit)
                self.bManager.hide(self.buttonEditPalette)
                self.bManager.hide(self.buttonEditProPalette)
                self.bManager.hide(self.buttonFontFamily)
                self.bManager.enable(self.buttonMenu)
                self.bManager.enable(self.buttonBackground)
                self.bManager.enable(self.buttonFormat)
                self.bManager.enable(self.buttonAddPage)
                self.bManager.enable(self.buttonFullscreen)
                self.tapTitle.isEnabled = true
                self.tapSubtitle.isEnabled = true
                self.tapAuthor.isEnabled = true
                self.textFieldEdit.isEnabled = true
            }
        }
    }
    
    @IBAction func changeTextColorStandard(_ sender: Any) {
        if colorPickerView.isHidden {
            colorPickerView.isHidden = false
            bManager.disable(buttonEditProPalette)
            bManager.disable(buttonFontFamily)
            bManager.disable(buttonEdit)
            tapVisibility.isEnabled = true
        }
        else {
            colorPickerView.isHidden = true
            bManager.enable(buttonEditProPalette)
            bManager.enable(buttonFontFamily)
            bManager.enable(buttonEdit)
            tapVisibility.isEnabled = false
        }
        (self.parent as! BookManager).changeSwipeGesture(enabled: colorPickerView.isHidden)
    }
    
    @IBAction func changeTextColorSpecial(_ sender: Any) {
        if proColorPickerView.isHidden {
            proColorPickerView.isHidden = false
            bManager.disable(buttonEditPalette)
            bManager.disable(buttonFontFamily)
            bManager.disable(buttonEdit)
            tapVisibility.isEnabled = true
        }
        else {
            proColorPickerView.isHidden = true
            bManager.enable(buttonEditPalette)
            bManager.enable(buttonFontFamily)
            bManager.enable(buttonEdit)
            tapVisibility.isEnabled = false
        }
        (self.parent as! BookManager).changeSwipeGesture(enabled: proColorPickerView.isHidden)
    }
    
    @IBAction func changeFontFamily(_ sender: Any) {
        let alert = UIAlertController(title: "Choose a Font", message: "Note: Changing font will reset page format.", preferredStyle: .alert)
        let fontSize: CGFloat = (selectedLabel?.font.pointSize)!
        
        let font1 = UIAlertAction(title: "Arial Rounded (Default)", style: .default, handler: { _ in
            self.selectedLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: fontSize)
        })
        let font2 = UIAlertAction(title: "Bradley Hand", style: .default, handler: { _ in
            self.selectedLabel?.font = UIFont(name: "Bradley Hand", size: fontSize)
        })
        let font3 = UIAlertAction(title: "Chalkboard SE", style: .default, handler: { _ in
            self.selectedLabel?.font = UIFont(name: "Chalkboard SE", size: fontSize)
        })
        let font4 = UIAlertAction(title: "Helvetica", style: .default, handler: { _ in
            self.selectedLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        })
        let font5 = UIAlertAction(title: "Kefa", style: .default, handler: { _ in
            self.selectedLabel?.font = UIFont(name: "Kefa", size: fontSize)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(font1)
        alert.addAction(font2)
        alert.addAction(font3)
        alert.addAction(font4)
        alert.addAction(font5)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        editMenuVisibility(buttonEdit)
    }
    
    @IBAction func backgroundMenuVisibility(_ sender: Any) {
        deselectLabel()
        bManager.disable(buttonBackground)
        if !buttonPalette.isEnabled {
            bManager.disable(buttonMenu)
            bManager.disable(buttonFormat)
            bManager.disable(buttonAddPage)
            bManager.disable(buttonFullscreen)
            tapTitle.isEnabled = false
            tapSubtitle.isEnabled = false
            tapAuthor.isEnabled = false
            
            bManager.show(buttonPalette)
            bManager.show(buttonProPalette)
            bManager.show(buttonImport)
            
            animator.moveLeft(buttonPalette, 55, 0.4, .curveEaseOut)
            animator.moveUp(buttonPalette, 60, 0.4, .curveEaseOut)
            animator.moveLeft(buttonProPalette, 55, 0.4, 0.08, .curveEaseOut, nil)
            animator.moveLeft(buttonImport, 55, 0.4, 0.16, .curveEaseOut, nil)
            animator.moveDown(buttonImport, 60, 0.4, 0.16, .curveEaseOut) { _ in
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
            animator.moveRight(buttonProPalette, 55, 0.4, 0.08, .curveEaseIn, nil)
            animator.moveUp(buttonImport, 60, 0.4, 0.16, .curveEaseIn, nil)
            animator.moveRight(buttonImport, 55, 0.4, 0.16, .curveEaseIn) { _ in
                self.bManager.hide(self.buttonPalette)
                self.bManager.hide(self.buttonProPalette)
                self.bManager.hide(self.buttonImport)
                self.bManager.enable(self.buttonMenu)
                self.bManager.enable(self.buttonBackground)
                self.bManager.enable(self.buttonFormat)
                self.bManager.enable(self.buttonAddPage)
                self.bManager.enable(self.buttonFullscreen)
                self.tapTitle.isEnabled = true
                self.tapSubtitle.isEnabled = true
                self.tapAuthor.isEnabled = true
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
                self.viewCover.backgroundColor = UIColor.white
                self.imageBackground.image = photo.image
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        backgroundMenuVisibility(buttonBackground)
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func changePageFormat(_ sender: Any) {
        deselectLabel()
        let alert = UIAlertController(title: "Format Front Cover", message: "", preferredStyle: .alert)
        let width = viewCover.frame.width
        let height = viewCover.frame.height
        
        let format1 = UIAlertAction(title: "Center (Default)", style: .default, handler: { _ in
            self.animator.moveTo(self.labelTitle, (width/2) - (self.labelTitle.frame.width/2), (height/2) - (self.labelTitle.frame.height/2))
            self.animator.moveTo(self.labelSubtitle, (width/2) - (self.labelSubtitle.frame.width/2), (height/2) + (self.labelTitle.frame.height/2))
            self.animator.moveTo(self.labelAuthor, (width/2) - (self.labelAuthor.frame.width/2), height - self.labelAuthor.frame.height - 20)
        })
        let format2 = UIAlertAction(title: "Top", style: .default, handler: { _ in
            self.animator.moveTo(self.labelTitle, (width/2) - (self.labelTitle.frame.width/2), 8)
            self.animator.moveTo(self.labelSubtitle, (width/2) - (self.labelSubtitle.frame.width/2), self.labelTitle.frame.height)
            self.animator.moveTo(self.labelAuthor, (width/2) - (self.labelAuthor.frame.width/2), self.labelTitle.frame.height + self.labelSubtitle.frame.height + 2)
        })
        let format3 = UIAlertAction(title: "Bottom Left", style: .default, handler: { _ in
            self.animator.moveTo(self.labelTitle, 16, height - (self.labelAuthor.frame.height + self.labelSubtitle.frame.height + self.labelTitle.frame.height + 8))
            self.animator.moveTo(self.labelSubtitle, 16, height - (self.labelAuthor.frame.height + self.labelSubtitle.frame.height + 8))
            self.animator.moveTo(self.labelAuthor, 16, height - self.labelAuthor.frame.height - 8)
        })
        let format4 = UIAlertAction(title: "Hide All", style: .default, handler: { _ in
            self.labelTitle.isHidden = true
            self.labelSubtitle.isHidden = true
            self.labelAuthor.isHidden = true
        })
        let format5 = UIAlertAction(title: "Hide Subtitle", style: .default, handler: { _ in
            self.labelSubtitle.isHidden = true
        })
        let format6 = UIAlertAction(title: "Show All", style: .default, handler: { _ in
            self.labelTitle.isHidden = false
            self.labelSubtitle.isHidden = false
            self.labelAuthor.isHidden = false
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(format1)
        alert.addAction(format2)
        alert.addAction(format3)
        alert.addAction(format4)
        alert.addAction(format5)
        alert.addAction(format6)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addPage(_ sender: Any) {
        if Book.orderedViewControllers.count < 20 && self.restorationIdentifier != "BackCover" {
            var book: Book = Book()
            book.addPage()
            animator.pop(buttonAddPage, 1.5, 0.2)
        } else {
            let alertController = UIAlertController(title: "Oh, no!", message: "Sorry but you've reached a maximum of 20 pages.\n:(", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Okay", style: .default)
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func hideUIElements(_ sender: Any) {
        deselectLabel()
        animator.moveLeft(buttonMenu, 80, 0.3, .curveEaseIn)
        animator.moveRight(buttonBackground, 80, 0.3, .curveEaseIn)
        animator.moveRight(buttonFormat, 80, 0.3, .curveEaseIn)
        animator.moveRight(buttonAddPage, 80, 0.3, .curveEaseIn)
        animator.moveRight(buttonFullscreen, 80, 0.3, .curveEaseIn)
        
        tapVisibility.isEnabled = true
        tapTitle.isEnabled = false
        tapSubtitle.isEnabled = false
        tapAuthor.isEnabled = false
    }
    
    // MARK: Tap Register
    @IBAction func uielementsVisibility(_ sender: Any) {
        tapVisibility.isEnabled = false
        if !colorPickerView.isHidden {
            colorPickerView.isHidden = true
            (self.parent as! BookManager).changeSwipeGesture(enabled: colorPickerView.isHidden)
        }
        else if !proColorPickerView.isHidden {
            proColorPickerView.isHidden = true
            (self.parent as! BookManager).changeSwipeGesture(enabled: proColorPickerView.isHidden)
        }
        if !buttonPalette.isHidden || !buttonProPalette.isHidden {
            bManager.enable(buttonPalette)
            bManager.enable(buttonProPalette)
            bManager.enable(buttonImport)
            bManager.enable(buttonBackground)
        } else if !buttonEditPalette.isHidden || !buttonEditProPalette.isHidden {
            bManager.enable(buttonEditPalette)
            bManager.enable(buttonEditProPalette)
            bManager.enable(buttonFontFamily)
            bManager.enable(buttonEdit)
        }
        else {
            animator.moveRight(buttonMenu, 80, 0.3, .curveEaseOut)
            animator.moveLeft(buttonBackground, 80, 0.3, .curveEaseOut)
            animator.moveLeft(buttonFormat, 80, 0.3, .curveEaseOut)
            animator.moveLeft(buttonAddPage, 80, 0.3, .curveEaseOut)
            animator.moveLeft(buttonFullscreen, 80, 0.3, .curveEaseOut)
            
            tapTitle.isEnabled = true
            tapSubtitle.isEnabled = true
            tapAuthor.isEnabled = true
        }
    }
    
    @IBAction func editLabel(_ sender: UITapGestureRecognizer) {
        if selectedLabel != (sender.view as! UILabel) {
            bManager.show(buttonEdit)
            textFieldEdit.isHidden = false
            if selectedLabel != nil {
                selectedLabel!.isHighlighted = false
                textFieldEdit.text = ""
            }
            selectedLabel = (sender.view as! UILabel)
            selectedLabel!.isHighlighted = true
        } else {
            deselectLabel()
        }
    }
    
    func deselectLabel() {
        buttonEdit.isHidden = true
        if selectedLabel != nil {
            selectedLabel!.isHighlighted = false
            selectedLabel = nil
        }
        textFieldEdit.isHidden = true
    }
}

// MARK: - ColorPickerViewDelegate
extension FrontCover: ColorPickerViewDelegate {
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        // TODO: refactor this method
        // A color has been selected
        if !buttonPalette.isHidden {
            imageBackground.image = nil
            bManager.enable(buttonBackground)
            bManager.enable(buttonProPalette)
            bManager.enable(buttonImport)
            if previousColor != colorPickerView.colors[indexPath.row] {
                previousColor = colorPickerView.colors[indexPath.row]
                viewCover.backgroundColor = colorPickerView.colors[indexPath.row]
            }
            else {
                previousColor = UIColor.white
                viewCover.backgroundColor = UIColor.white
            }
        } else if !buttonEditPalette.isHidden {
            selectedLabel?.textColor = colorPickerView.colors[indexPath.row]
            bManager.enable(buttonEdit)
            bManager.enable(buttonEditProPalette)
            bManager.enable(buttonFontFamily)
        }
        colorPickerView.isHidden = true
        (self.parent as! BookManager).changeSwipeGesture(enabled: true)
        tapVisibility.isEnabled = false
    }
}

// MARK: - ColorPickerViewDelegateFlowLayout
extension FrontCover: ColorPickerViewDelegateFlowLayout {
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
extension FrontCover: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        if !buttonProPalette.isHidden {
            imageBackground.image = nil
            previousColor = color
            viewCover.backgroundColor = color
            bManager.enable(buttonBackground)
            bManager.enable(buttonPalette)
            bManager.enable(buttonImport)
        } else if !buttonEditProPalette.isHidden {
            selectedLabel?.textColor = color
            bManager.enable(buttonEdit)
            bManager.enable(buttonEditPalette)
            bManager.enable(buttonFontFamily)
        }
        proColorPickerView.isHidden = true
        (self.parent as! BookManager).changeSwipeGesture(enabled: true)
        tapVisibility.isEnabled = false
    }
}

// MARK: - UITextField Functionality
extension FrontCover: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func changeLabelText(_ sender: UITextField) {
        if sender.text != "" {
            selectedLabel!.text = sender.text
            sender.text = ""
        }
    }
}
