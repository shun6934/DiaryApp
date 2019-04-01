//
//  Diary.swift
//  DiaryApp
//
//  Created by shunichi hiraiwa on 2018/05/02.
//  Copyright © 2018年 shunichi. All rights reserved.
//

import Foundation
import RealmSwift

class Diary: Object {
    @objc dynamic var date = ""
    @objc dynamic var context = ""
    
    override static func primaryKey() -> String {
        return "date"
    }
}
