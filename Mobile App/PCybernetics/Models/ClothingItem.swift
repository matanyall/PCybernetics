//
//  ClothingItem.swift
//  PCybernetics
//
//  Created by Daniel Smith on 3/11/18.
//  Copyright © 2018 Daniel Smith. All rights reserved.
//

import Foundation
import ColorPickerRow

class ClothingItem
{
    var imageUrl: URL?
    var type: ClothingType
    var colorStr: String
    var size: String
    var style: String
    var gender: String
    
    init(type: ClothingType, colorStr: String, size: String, style: String, gender: String)
    {
        self.type = type
        self.colorStr = colorStr
        self.size = size
        self.style = style
        self.gender = gender
    }
    
    public static let colorPalette = ColorPalette(name: "Material",
                                                  palette: [ColorSpec(hex: "#f44336", name: "red"),
                                                            ColorSpec(hex: "#E91E63", name: "pink"),
                                                            ColorSpec(hex: "#9C27B0", name: "purple"),
                                                            ColorSpec(hex: "#2196F3", name: "blue"),
                                                            ColorSpec(hex: "#4CAF50", name: "green"),
                                                            ColorSpec(hex: "#FFEB3B", name: "yellow"),
                                                            ColorSpec(hex: "#FFC107", name: "amber"),
                                                            ColorSpec(hex: "#795548", name: "brown"),
                                                            ColorSpec(hex: "#9E9E9E", name: "grey"),
                                                            ColorSpec(hex: "#607D8B", name: "bluegrey")])
    
    enum ClothingType: String
    {
        case Shirt
        case Pants
        
        public static let options = [Shirt.rawValue, Pants.rawValue]
        public static let pantStyles = ["Cargo", "Dress", "Jeans", "Shorts"]
        public static let shirtSizes = ["S", "M", "L", "XL", "XXL", "XXXL"]
        public static let shirtStyles = ["Dress", "Dry Fit", "Polo", "Sweater", "Tee"]
    }
}
