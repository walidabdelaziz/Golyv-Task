//
//  Extensions.swift
//  Golyv Task
//
//  Created by Walid Ahmed on 11/09/2023.
//

import Foundation
import UIKit

extension UIView{
    func dropShadow(radius: CGFloat, opacity: Float = 0.3, offset: CGSize = CGSize(width: 1.5, height: 3)) {
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.rasterizationScale = UIScreen.main.scale
    }
}
extension Date {
    func formattedString() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if let monthsAgo = calendar.dateComponents([.month], from: self, to: currentDate).month, monthsAgo < 6 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            return dateFormatter.string(from: self)
        } else {
            let components = calendar.dateComponents([.year, .month], from: self, to: currentDate)
            if let yearsAgo = components.year, yearsAgo > 0 {
                return "\(yearsAgo) year\(yearsAgo > 1 ? "s" : "") ago"
            } else {
                return "\(components.month ?? 0) month\(components.month ?? 0 > 1 ? "s" : "") ago"
            }
        }
    }
}
