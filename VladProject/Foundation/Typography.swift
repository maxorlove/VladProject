//
//  Typography.swift
//  VladProject
//
//  Created by Vladislav Kitov on 08.01.2023.
//

import UIKit

enum FontStyle {
    
    // Headers
    
    static let largeTitleFont = UIFont.systemFont(ofSize: 54, weight: .semibold) /// ofSize: 54, weight: .semibold
    static let regularTitleFont = UIFont.systemFont(ofSize: 37, weight: .semibold) /// ofSize: 37, weight: .semibold
    static let smallTitleFont = UIFont.systemFont(ofSize: 27, weight: .medium) /// ofSize: 27, weight: .medium
    static let subtitleFont = UIFont.systemFont(ofSize: 20, weight: .regular) /// ofSize: 20, weight: .semibold
    static let bodyFont = UIFont.systemFont(ofSize: 17, weight: .regular) /// ofSize: 17, weight: .regular
    static let smallFont = UIFont.systemFont(ofSize: 15, weight: .regular) /// ofSize: 15, weight: .regular
    static let extraSmallFont = UIFont.systemFont(ofSize: 13, weight: .regular) /// ofSize: 13, weight: .regular
    static let actionFont = UIFont.systemFont(ofSize: 13, weight: .semibold) /// ofSize: 13, weight: .semibold, For uppercased() func

    
}

enum AttributedFontStyle {
    
    // Headers
    static let largeFont = [NSAttributedString.Key.font: FontStyle.largeTitleFont]

}

