//
//  Icons.swift
//  VladProject
//
//  Created by Vladislav Kitov on 15.02.2023.
//

import UIKit


enum Icons {

    case tile
    case starStroked
    case starFilled
    case search
    case profile
    case list
    case heartStroked
    case heartFilled
    case compass
    case chevronLeft
    case chevronDown
    
    var image: UIImage {
        switch self {
            
        case .tile: return UIImage(named: "Ico_Tile")!
        case .starStroked: return UIImage(named: "Ico_Star_Stroked")!
        case .starFilled: return UIImage(named: "Ico_Star_Filled")!
        case .search: return UIImage(named: "Ico_Search")!
        case .profile: return UIImage(named: "Ico_Profile")!
        case .list: return UIImage(named: "Ico_List")!
        case .heartStroked: return UIImage(named: "Ico_Heart_Stroked")!
        case .heartFilled: return UIImage(named: "Ico_Heart_Filled")!
        case .compass: return UIImage(named: "Ico_Compass")!
        case .chevronLeft: return UIImage(named: "Ico_Chevron_Left")!
        case .chevronDown: return UIImage(named: "Ico_Chevron_Down")!
        }
    }
}
