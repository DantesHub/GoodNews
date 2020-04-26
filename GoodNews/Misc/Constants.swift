

import Foundation
import UIKit

let largeConfiguration = UIImage.SymbolConfiguration(weight: .bold)
let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: largeConfiguration)
let brightPurple = hexStringToUIColor(hex: "#5351C0")
let lightBlue = hexStringToUIColor(hex: "#029CE8")
let lightLavender = hexStringToUIColor(hex: "#ABA9FF")
let backgroundColor = hexStringToUIColor(hex: "#C7B6F5")
let green = hexStringToUIColor(hex: "#196300")
let lightPurple = hexStringToUIColor(hex: "#B99AFF")
let neoWhite = hexStringToUIColor(hex: "#F1F3F6")
let superLightLavender = hexStringToUIColor(hex: "#E3DAFA")
let darkRed = hexStringToUIColor(hex: "#811301")
let darkPurple = hexStringToUIColor(hex:"#5E558A")
let goldYellow = hexStringToUIColor(hex: "#F4D104")
let twitterBlue = hexStringToUIColor(hex: "#379DED")
let bookmarkRed = hexStringToUIColor(hex: "#ED7B94")

struct K {
    static let newsCell = "NewsCell"
    
    struct FStore {
        static let collectionName = "userPreferences"
    }
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
