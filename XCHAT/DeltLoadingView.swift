//
//  DeltLoadingView.swift
//  XCHAT
//
//  Created by Mateo Garcia on 9/23/16.
//  Copyright © 2016 Mateo Garcia. All rights reserved.
//

import UIKit

class DeltLoadingView: UIView {
    
    private var shouldContinue = false
    
    func startAnimating() {
        self.shouldContinue = true
        self.animateDelts()
    }
    
    func stopAnimating() {
        self.shouldContinue = false
    }
    
    private func animateDelts() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            while self.shouldContinue {
                dispatch_async(dispatch_get_main_queue(), {
                    print("ADD DELT LABEL")
                    self.addDeltLabel()
                })
                NSThread.sleepForTimeInterval(0.3)
            }
        }
    }
    
    private func addDeltLabel() {
        let delt = self.deltLabel()
        delt.hidden = true
        self.addSubview(delt)
        UIView.transitionWithView(delt, duration: 0.5, options: .TransitionCrossDissolve, animations: {
            delt.hidden = false
            }, completion: { _ in
                UIView.transitionWithView(delt, duration: 0.5, options: .TransitionCrossDissolve, animations: {
                    delt.hidden = true
                    }, completion: { _ in
                        delt.removeFromSuperview()
                })
        })
    }
    
    // Returns ∆ label with random origin within this view's bounds.
    private func deltLabel() -> UILabel {
        let deltLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        deltLabel.text = "Δ"
        deltLabel.textColor = LayoutUtils.greenColor
        deltLabel.font = UIFont.systemFontOfSize(15)
        deltLabel.sizeToFit()
        deltLabel.frame.origin = self.randomOriginForRect(deltLabel.bounds)
        
        print("DELT FRAME:", deltLabel.frame)
        
        return deltLabel
    }
    
    private func randomOriginForRect(rect: CGRect) -> CGPoint {
        let maxWidth = self.frame.width - rect.width
        let maxHeight = self.frame.height - rect.height
        let randomX = CGFloat(arc4random()) / CGFloat(UInt32.max) * maxWidth
        let randomY = CGFloat(arc4random()) / CGFloat(UInt32.max) * maxHeight
        return CGPoint(x: randomX, y: randomY)
    }
}
