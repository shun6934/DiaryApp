//
//  DiartViewController.swift
//  DiaryApp
//
//  Created by shunichi hiraiwa on 2018/06/09.
//  Copyright © 2018年 shunichi. All rights reserved.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contextTextView: UITextView!
    
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contextTextView.delegate = self
        
        let keyBoardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        keyBoardToolBar.barStyle = UIBarStyle.default
        keyBoardToolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                     target: self,
                                     action: nil)
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                           target: self,
                                           action: #selector(self.commitButtonTapped))
        keyBoardToolBar.items = [spacer, commitButton]
        contextTextView.inputAccessoryView = keyBoardToolBar
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = date
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            
            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
                let context = savedDiary.context
                DispatchQueue.main.async {
                    self.contextTextView.text = context
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPushed(_ sender: UIButton) {
        let realm = try! Realm()
        
        let diary = Diary()
        diary.date = date
        diary.context = contextTextView.text
        
        try! realm.write {
            realm.add(diary, update: true)
        }
        
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
}
