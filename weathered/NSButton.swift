//
//  NSButton.swift
//  weathered
//
//  Created by Beau Galbraith on 6/26/17.
//  Copyright © 2017 Beau Galbraith. All rights reserved.
//

import Cocoa

extension NSButton {
    func styleButtonText(button: NSButton, buttonName: String, fontColor: NSColor, alignment: NSTextAlignment, font: String, size: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        button.attributedTitle = NSAttributedString(string: buttonName, attributes: [NSForegroundColorAttributeName: fontColor, NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: NSFont(name: font, size: size)!])
    }
}
