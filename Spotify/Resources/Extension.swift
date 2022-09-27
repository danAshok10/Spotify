//
//  Extension.swift
//  Spotify
//
//  Created by user212878 on 6/20/22.
//

import Foundation
import UIKit
extension UIView{
    var width: CGFloat{
        return frame.size.width
    }
    var height: CGFloat{
        return frame.size.height
    }
    var left: CGFloat{
        return frame.origin.x
    }
    var right: CGFloat{
        return left + width
    }
    var top: CGFloat{
        return frame.origin.y
    }
    var bottom:CGFloat{
        return top + height
    }
}

//MARK: - UIImage View
extension UIImageView{
    func loadFrom(URLAddress: String){
        guard let urlString = URL(string: URLAddress) else{
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: urlString){
                if let loadImage = UIImage(data: imageData){
                    self?.image = loadImage
                }
            }
        }
    }
}

//MARK: - Date formatter

extension DateFormatter{
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
}

extension String{
    static func formattedDate(string: String) -> String{
        guard let date = DateFormatter.dateFormatter.date(from: string) else{
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}
