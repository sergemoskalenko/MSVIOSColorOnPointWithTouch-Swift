
//
//  MSVIOSColorOnPointWithTouchView.h
//  MSVIOSColorOnPointWithTouch
//
//  Created by Serge Moskalenko on 9/10/18.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//  Copyright (c) 2018 Serge Moskalenko. All rights reserved.
//

import UIKit

@objc public enum MSVIOSColorOnPointWithTouchViewAction : Int {
    case began
    case moved
    case cancelled
    case ended
}

@objc public protocol MSVIOSColorOnPointWithTouchViewProtocol: NSObjectProtocol {
    @objc optional func msviosColorOnPoint(_ touchInfo: MSVIOSColorOnPointWithTouchView, didTouch action: MSVIOSColorOnPointWithTouchViewAction)
}

public class MSVIOSColorOnPointWithTouchView: UIView {
    public weak var delegateForColorTouch: MSVIOSColorOnPointWithTouchViewProtocol?
    var isClearForTouch = false
    private(set) var touchPoint = CGPoint.zero
    private(set) var touchPart = CGPoint.zero /* normalized */
    public var touchPointCurrent = CGPoint.zero
    private(set) var touchPartCurrent = CGPoint.zero /* normalized */
    public var colorAtTouchPoint: UIColor?
    
    private var isTouched = false
    
    func callDelegate(_ touches: Set<UITouch>?, action: MSVIOSColorOnPointWithTouchViewAction) {
        touchPointCurrent = (touches?.first)?.location(in: self) ?? CGPoint.zero
        colorAtTouchPoint = color(at: touchPointCurrent)
        if frame.size.width > 0 && frame.size.height > 0 {
            touchPartCurrent = CGPoint(x: touchPointCurrent.x / frame.size.width, y: touchPointCurrent.y / frame.size.height)
        } else {
            touchPartCurrent = CGPoint.zero
        }
        
        if delegateForColorTouch?.responds(to: #selector(MSVIOSColorOnPointWithTouchViewProtocol.msviosColorOnPoint(_:didTouch:))) ?? false {
            delegateForColorTouch?.msviosColorOnPoint!(self, didTouch: action)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        callDelegate(touches, action: .began)
        isTouched = true
        super.touchesBegan(touches, with: event)
        if isClearForTouch {
            next?.touchesBegan(touches, with: event)
        }
     }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        callDelegate(touches, action: MSVIOSColorOnPointWithTouchViewAction.moved)
        super.touchesMoved(touches, with: event)
        if isClearForTouch {
            next?.touchesMoved(touches, with: event)
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        callDelegate(touches, action: MSVIOSColorOnPointWithTouchViewAction.cancelled)
        isTouched = false
        touchPart = CGPoint.zero
        touchPoint = touchPart
        super.touchesCancelled(touches, with: event)
        if isClearForTouch {
            next?.touchesCancelled(touches, with: event)
        }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        callDelegate(touches, action: MSVIOSColorOnPointWithTouchViewAction.ended)
        if isTouched {
            touchPoint = (touches.first)?.location(in: self) ?? CGPoint.zero
            if frame.size.width > 0 && frame.size.height > 0 {
                touchPart = CGPoint(x: touchPoint.x / frame.size.width, y: touchPoint.y / frame.size.height)
            } else {
                touchPart = CGPoint.zero
            }
        }
        isTouched = false
        super.touchesEnded(touches, with: event)
        
        if isClearForTouch {
            next?.touchesEnded(touches, with: event)
        }
    }
}


extension UIView {
    typealias MSVColorStruct = (b: UInt8, g: UInt8, r: UInt8, a: UInt8)
    
    func image() -> UIImage? {
        return image(withScale: 0.0)
    }
    
    func image(withScale scale: CGFloat) -> UIImage? {
        layer.setNeedsDisplay()
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, scale)
        let ctx = UIGraphicsGetCurrentContext()
        if let aCtx = ctx {
            layer.render(in: aCtx)
        }
        let resultImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    func color(at point: CGPoint) -> UIColor? {
        let image: UIImage? = self.image(withScale: 1.0)
        // NSUInteger widthInt = (int)(image.size.width);
        let heightInt = Int(image?.size.height ?? 0)
    
        let pixelData = image?.cgImage!.dataProvider?.data
        let bufLength = CFDataGetLength(pixelData)
        let lineBytes: Int = bufLength / heightInt
        let colorBuf = CFDataGetBytePtr(pixelData)
        
        let ind = Int(point.y) * lineBytes + Int(point.x) * 4
        var c: MSVColorStruct = (0,0,0,0)
        memcpy(&c, (UnsafePointer<UInt8>)(colorBuf! + ind), 4)
        
        let ff: CGFloat = 255.0
        return UIColor(red: CGFloat(c.r) / ff, green: CGFloat(c.g) / ff, blue: CGFloat(c.b) / ff, alpha: CGFloat(c.a) / ff)
    }
}


