//
//  CircularProgressBar.swift
//  EscapeRooms
//
//  Created by playhong on 2023/05/07.
//

import UIKit

class CircularProgressBar: UIView {
    
//    var progress: CGFloat = 0 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
    
    var progress: CGFloat = 0.756
    let ringWidth: CGFloat = 6
    let backgroundMask = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupLayers()
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path = circlePath.cgPath
        
        progressLayer.path = circlePath.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = UIColor.customOrange.cgColor
        progressLayer.lineWidth = ringWidth
        progressLayer.backgroundColor = UIColor.white.cgColor
    }
    
    func setupLayers() {
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask
        
        progressLayer.lineWidth = 10
        progressLayer.fillColor = UIColor.customBlack.cgColor
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }
    
    func createAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotationAnimation.fromValue = CGFloat(Double.pi / 2)
                rotationAnimation.toValue = CGFloat(2.5 * Double.pi)
                rotationAnimation.repeatCount = Float.infinity
                rotationAnimation.duration = 4
                progressLayer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
