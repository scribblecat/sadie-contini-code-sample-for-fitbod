//
//  BaseReusableXibView.swift
//  FitBod-CodingSample-SadieContini
//
//  Created by sadie on 12/31/17.
//  Copyright © 2017 sadiecontini. All rights reserved.
//

import UIKit

@IBDesignable
class BaseReusableXibView: UIView {
    
    var contentView:UIView?
    @IBInspectable var nibName:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
}

