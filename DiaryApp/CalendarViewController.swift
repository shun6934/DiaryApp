//
//  CalendarViewController.swift
//  DiaryApp
//
//  Created by shunichi hiraiwa on 2018/12/06.
//  Copyright © 2018年 shunichi. All rights reserved.
//

import UIKit
import JBDatePicker

class CalendarViewController: UIViewController, JBDatePickerViewDelegate {
    
    @IBOutlet weak var datePickerView: JBDatePickerView!
    @IBOutlet weak var writeButton: UIButton!
    
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePickerView.delegate = self
        
        self.navigationItem.title = datePickerView.presentedMonthView?.monthDescription

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        date = dateFormatter.string(from: dayView.date!)
    }
    
    func didPresentOtherMonth(_ monthView: JBDatePickerMonthView) {
        self.navigationItem.title = datePickerView.presentedMonthView.monthDescription
    }
    
    @IBAction func writeButtonPushed(_ sender: UIButton) {
        if date == nil {
            date = getToday()
        }
        self.performSegue(withIdentifier: "toDiary", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDiary" {
            let diaryView = segue.destination as! DiaryViewController
            diaryView.date = self.date
            
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM",
                                                        options: 0,
                                                        locale: Locale(identifier: "ja_JP"))
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()
    
    func getToday() -> String {
        let now = Date()
        let formatter = dateFormatter
        return formatter.string(from: now)
    }
    
}
