//
//  DonateViewController.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/10/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import ImageRow
import ColorPickerRow

class DonateViewController: FormViewController
{
    var type = ""
    var size = ""
    var style = ""
    var color = ""
    var gender = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        form.delegate = self
        title = "New Item"
        configForm()
    }
    
    @IBAction func tappedGetStarted(_ sender: Any)
    {
        UserDefaultsController.SawProcessSend = true
    }
    
    private func configForm()
    {
        form +++ Section("Basic Info")
            <<< ImageRow("image") { row in
                row.title = "Image"
                row.sourceTypes = [.PhotoLibrary, .Camera]
                row.clearAction = .yes(style: .destructive)
            }.cellUpdate { cell, row in
                cell.accessoryView?.layer.cornerRadius = 17
                cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            }
            <<< PushRow<String>("gender") { row in
                    row.title = "Gender"
                    row.options = ["Male", "Female", "Unisex"]
                    row.onChange { row in
                        self.gender = row.value ?? ""
                    }
                }
            <<< PushRow<String>("clothingType") { row in
                row.title = "Type"
                row.options = ClothingItem.ClothingType.options
                }.onChange { row in
                    let pantSection = self.form.sectionBy(tag: "pantsDetailsSection")
                    pantSection?.hidden = Condition(booleanLiteral: !self.row(withTag: "clothingType", isType: .pants))
                    pantSection!.evaluateHidden()
                    
                    let shirtSection = self.form.sectionBy(tag: "shirtDetailsSection")
                    shirtSection?.hidden = Condition(booleanLiteral: !self.row(withTag: "clothingType", isType: .shirt))
                    shirtSection!.evaluateHidden()
                }
            
         +++ Section("Pants Details") { section in
            section.hidden = Condition(booleanLiteral: !self.row(withTag: "clothingType", isType: .pants))
            section.tag = "pantsDetailsSection"
        }
        <<< SplitRow<DecimalRow, DecimalRow>() { splitRow in
            splitRow.rowLeft = DecimalRow("pantsWaist") { row in
                row.title = "Waist"
                row.placeholder = "34"
            }
            splitRow.rowRight = DecimalRow("pantsInseam") { row in
                row.title = "Inseam"
                row.placeholder = "32"
            }
            splitRow.onChange { splitRow in
                self.size = "\(splitRow.rowLeft?.value ?? 0.0)x\(splitRow.rowRight?.value ?? 0.0)"
            }
        }
        <<< PushRow<String>("pantsStyle") { row in
            row.title = "Style"
            row.options = ClothingItem.ClothingType.pantStyles
            row.onChange { row in
                self.style = row.value ?? ""
            }
        }
        <<< ColorPickerRow("pantsColor") { row in
            row.title = "Color"
            row.isCircular = true
            row.showsCurrentSwatch = true
            row.showsPaletteNames = false
            row.cellSetup { cell, row in
                cell.palettes = [ClothingItem.colorPalette]
            }
            row.onChange { row in
                self.color = row.value?.hexString() ?? ""
            }
        }
        
        +++ Section("Shirt Details") { section in
            section.hidden = Condition(booleanLiteral: !self.row(withTag: "clothingType", isType: .shirt))
            section.tag = "shirtDetailsSection"
        }
        <<< PickerInlineRow<String>("shirtSize") { row in
            row.title = "Size"
            row.options = ClothingItem.ClothingType.shirtSizes
            row.onChange { row in
                self.size = row.value ?? ""
            }
        }
        <<< PushRow<String>("shirtStyle") { row in
            row.title = "Style"
            row.options = ClothingItem.ClothingType.shirtStyles
            row.onChange { row in
                self.style = row.value ?? ""
            }
        }
        <<< ColorPickerRow("shirtColor") { row in
            row.title = "Dominant Color"
            row.isCircular = true
            row.showsCurrentSwatch = true
            row.showsPaletteNames = false
            row.cellSetup { cell, row in
                cell.palettes = [ClothingItem.colorPalette]
            }
            row.onChange { row in
                self.color = row.value?.hexString() ?? ""
            }
        }
        
        +++ Section()
        <<< ButtonRow("addButton") { row in
            row.disabled = Condition(booleanLiteral: !checkAllRows())
            row.title = "Add"
            row.onCellSelection { _, _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
        <<< ButtonRow("cancelButton") { row in
            row.title = "Cancel"
            row.cell.tintColor = UIColor.red
            row.onCellSelection { _, _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func valueHasBeenChanged(for base: BaseRow, oldValue: Any?, newValue: Any?)
    {
        super.valueHasBeenChanged(for: base, oldValue: oldValue, newValue: newValue)
        print("changed")
        if let row: BaseRow = form.rowBy(tag: "addButton") as? ButtonRow
        {
            row.disabled = Condition(booleanLiteral: !checkAllRows())
            row.evaluateDisabled()
        }
    }
    
    private func addItem()
    {
        if let baseRow: BaseRow = form.rowBy(tag: "clothingType"),
            let typeRow = baseRow as? PushRow<String>,
            let typeVal = typeRow.value
        {
            let type = ClothingItem.ClothingType(rawValue: typeVal)!
            let clothingItem = ClothingItem(type: type, colorStr: color, size: size, style: style, gender: gender)
            //TODO: Upload Clothing Item
        }
    }
    
    private func checkAllRows() -> Bool
    {
        var ret = true
        let basicKeys = ["image", "gender", "clothingType"]
        let pantsKeys = ["pantsWaist", "pantsInseam", "pantsStyle", "pantsColor"]
        let shirtKeys = ["shirtSize", "shirtStyle", "shirtColor"]
        
        if checkRows(withKeys: basicKeys),
            let baseRow: BaseRow = form.rowBy(tag: "clothingType"),
            let row = baseRow as? PushRow<String>,
            let val = row.value
        {
            if val == "Pants" { ret = ret && checkRows(withKeys: pantsKeys) }
            else { ret = ret && checkRows(withKeys: shirtKeys) }
        }
        else { return false }
        
        return ret
    }
    
    private func checkRows(withKeys keys: [String]) -> Bool
    {
        var ret = true
        for key in keys
        {
            ret = ret && checkRow(withTag: key)
        }
        return ret
    }
    
    private func checkRow(withTag tag: String) -> Bool
    {
        guard let row: BaseRow = form.rowBy(tag: tag) else
        {
            return false
        }
        return row.baseValue != nil
    }
    
    private func row(withTag tag: String, isType str: ClothingItem.ClothingType) -> Bool
    {
        if let baseRow: BaseRow = form.rowBy(tag: tag),
            let row = baseRow as? PushRow<String>,
            let val = row.value
        {
            return val == str.rawValue
        }
        else { return false }
    }
}
