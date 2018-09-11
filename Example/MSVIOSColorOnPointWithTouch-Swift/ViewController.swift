
//  MSVViewController
//  MSVIOSColorOnPointWithTouch
//
//  Created by Serge Moskalenko on 08/01/2018.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//  Copyright (c) 2018 Serge Moskalenko. All rights reserved.
//

import UIKit
import MSVIOSColorOnPointWithTouch_Swift

class MSVViewController:  UIViewController, MSVIOSColorOnPointWithTouchViewProtocol {
    @IBOutlet private weak var viewForTouch: MSVIOSColorOnPointWithTouchView!
    @IBOutlet private weak var displayView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForTouch.delegateForColorTouch = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func msviosColorOnPoint(_ touchInfo: MSVIOSColorOnPointWithTouchView, didTouch action: MSVIOSColorOnPointWithTouchViewAction) {
        displayView.backgroundColor = viewForTouch.colorAtTouchPoint
        
        //  _imageView.image = self.view.image;
    }
}
