//
//  SpaceSeparationLine.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/10.
//

import UIKit



class SpaceSeparationLine: UIView {
    
    enum Axis {
        case vertical
        case horizon
    }

//    private var height: CGFloat?
    private var width: CGFloat?
    private var height: CGFloat?
    private var axis: Axis?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spaceSeparationLine(_ height: CGFloat) {
        return self.height = height
    }
}
