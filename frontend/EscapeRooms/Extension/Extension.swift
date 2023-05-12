//
//  UIColor.swift
//  EscapeRooms
//
//  Created by playhong on 2023/04/13.
//

import UIKit

extension UIColor {
    static let navy = UIColor(red: 29/255, green: 45/255, blue: 68/255, alpha: 1)
    static let customGray = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    static let customGreen = UIColor(red: 14/255, green: 173/255, blue: 105/255, alpha: 1)
    static let customOrange = UIColor(red: 227/255, green: 100/255, blue: 20/255, alpha: 1)
    static let customLightOrange = UIColor(red: 255/255, green: 191/255, blue: 105/255, alpha: 1)
    static let customBlack = UIColor(red: 37/255, green: 35/255, blue: 37/255, alpha: 1)
    static let recordDetailLabelColor = UIColor.white
    static let mainBackgroungColor = UIColor.white
}

extension UIImage {
    func loadImage(_ urlString: String, imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            guard urlString == url.absoluteString else {
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
}
