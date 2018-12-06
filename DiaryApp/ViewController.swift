//
//  ViewController.swift
//  DiaryApp
//
//  Created by shunichi hiraiwa on 2018/05/02.
//  Copyright © 2018年 shunichi. All rights reserved.
//

import UIKit
import JBDatePicker

class ViewController: UIViewController, JBDatePickerViewDelegate {
    
    @IBOutlet weak var datePickerView: JBDatePickerView!
    @IBOutlet weak var writeButton: UIButton!
    
     var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dateFormatter.string(from: dayView.date!))")
        date = dateFormatter.string(from: dayView.date!)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        datePickerView.updateLayout()
    }
    
    @IBAction func writeButtonPushed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toDiary", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDiary") {
            let diaryView = segue.destination as! DiaryViewController
            diaryView.date = self.date
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy    MM/dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()

}

