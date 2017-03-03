//
//  AgeScaleView.swift
//  AgeScale
//
//  Created by admin5 on 02.03.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

class AgeScaleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        backgroundColor = .red
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self,
                            action: #selector(handlePanGesture(_ : )))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        
        let side = 2 * CGFloat(M_PI) * frame.width/2 / 60
        
        let radianForSection:CGFloat = CGFloat(2 * M_PI / 16)
        var startAngle: CGFloat = 0
        var endAngle = radianForSection
        
        for _ in 1...16 {
            path.addArc(withCenter: CGPoint(x: rect.width / 2, y: rect.height / 2), radius: rect.width / 2 - 50 - side / 2 - 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            let x = (rect.width / 2 - 50) * cos(endAngle) + (rect.width / 2)
           
            let y = (rect.width / 2 - 50) * sin(endAngle) + (rect.height / 2)
        
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: side, height: side))
            button.center = CGPoint(x: x, y: y)
            
            button.transform = CGAffineTransform(rotationAngle: endAngle)

            button.backgroundColor = .blue
            
            addSubview(button)
            
            startAngle = endAngle
            endAngle = endAngle + radianForSection
        }

        path.lineWidth = 2.0;
        UIColor.green.setStroke()
        UIColor.clear.setFill()
        
        path.stroke()
    }
    
    private var beganPoint: CGPoint = .zero

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        var changedPoint: CGPoint = .zero
        
        if gesture.state == .began {
            beganPoint = gesture.location(in: self)
        }
        
        if gesture.state == .changed {
            changedPoint = gesture.location(in: self)
            let angle = atan2(changedPoint.y - center.y, changedPoint.x - center.x)  - atan2(beganPoint.y - center.y, beganPoint.x - center.x)
            transform = transform.rotated(by: angle)
        }
        
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: self.superview)
            
            let rotationAngle = velocity.y / (360 * 4) * CGFloat(M_PI)
    
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            rotateAnimation.toValue =  -rotationAngle
            rotateAnimation.duration = 2
        
            layer.add(rotateAnimation, forKey: nil)
        }

    }
}


