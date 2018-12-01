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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (text == "\n") {
            //あなたのテキストフィールド
            contextTextView.resignFirstResponder()
            return false
        }
        return true
    }

}
