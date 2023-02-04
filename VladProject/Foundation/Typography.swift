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
    static let subtitleFont = UIFont.systemFont(ofSize: 20, weight: .medium) /// ofSize: 20, weight: .medium
    static let smallFont = UIFont.systemFont(ofSize: 15, weight: .regular) /// ofSize: 15, weight: .regular
    static let actionFont = UIFont.systemFont(ofSize: 13, weight: .semibold) /// ofSize: 13, weight: .semibold,
                                                                            /// For uppercased() func
//  static let mediumFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    
}

enum AttributedFontStyle {
    
    // Headers
    static let largeFont = [NSAttributedString.Key.font: FontStyle.largeTitleFont]

}
