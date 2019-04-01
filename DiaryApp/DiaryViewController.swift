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
    @IBOutlet weak var contextView: PlaceHolderTextView!
    
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contextView.delegate = self
        contextView.layer.borderColor = UIColor.black.cgColor
        contextView.layer.borderWidth = 1.0
        contextView.layer.cornerRadius = 10.0
        contextView.layer.masksToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = date
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            
            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
                let context = savedDiary.context
                DispatchQueue.main.async {
                    self.contextView.text = context
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
        diary.context = contextView.text
        
        try! realm.write {
            realm.add(diary, update: true)
        }
        
        self.dismiss(animated: true, completion: nil)

    }
}
