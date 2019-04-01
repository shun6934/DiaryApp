//
//  PlaceHolderTextView.swift
//  DiaryApp
//
//  Created by shunichi hiraiwa on 2018/12/06.
//  Copyright © 2018年 shunichi. All rights reserved.
//

import UIKit

@IBDesignable class PlaceHolderTextView: UITextView {
    
    private lazy var placeHolderLabel = UILabel()
    
    var date: String!
    
    // プレースホルダー
    @IBInspectable var placeHolder: String = "" {
        didSet {
            self.placeHolderLabel.frame.size = CGSize(width: 20, height: 20)
            self.placeHolderLabel.layer.position = CGPoint(x: 0, y: 17)
            self.placeHolderLabel.textAlignment = NSTextAlignment.center
            self.placeHolderLabel.text = self.placeHolder
            self.placeHolderLabel.sizeToFit()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configurePlaceHolder()
        self.changeVisiblePlaceHolder()
        self.setTookBar()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textChanged),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    
    // プレースホルダーを構築する
    private func configurePlaceHolder() {
        self.placeHolderLabel.lineBreakMode = .byWordWrapping
        self.placeHolderLabel.font = self.font
        self.placeHolderLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
        self.placeHolderLabel.backgroundColor = .clear
        
        self.addSubview(placeHolderLabel)
    }
    
    // プレースホルダーの表示/非表示を切り替える
    private func changeVisiblePlaceHolder() {
        
        if self.placeHolder.isEmpty || !self.text.isEmpty {
            self.placeHolderLabel.alpha = 0.0
        } else {
            self.placeHolderLabel.alpha = 1.0
        }
    }
    
    private func setTookBar() {
        
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                           target: self,
                                           action: #selector(self.commitButtonTapped))
        kbToolBar.items = [spacer, commitButton]
        self.inputAccessoryView = kbToolBar
    }
    
    @objc func commitButtonTapped() {
        self.endEditing(true)
    }
    
    // - Parameter notification: 通知
    @objc private func textChanged(notification: NSNotification?) {
        changeVisiblePlaceHolder()
    }
}
