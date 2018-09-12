//
//  Task.swift
//  mvc-pattern
//
//  Created by 渡邊丈洋 on 2018/09/12.
//  Copyright © 2018年 takehiro. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    let text: String // タスクの内容
    let deadline: Date // タスクの締め切り時間
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(deadline, forKey: "deadline")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let text = aDecoder.decodeObject(forKey: "text") as? String {
            self.text = text
        } else {
            self.text = ""
        }
        
        if let deadline = aDecoder.decodeObject(forKey: "deadline") as? Date {
            self.deadline = deadline
        } else {
            self.deadline = Date()
        }
    }
    
    /*
     引数からtextとdeadlineを受け取りTaskを生成するイニシャライザメソッド
     */
    init(text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }
    
    /*
     引数のdictionaryからTaskを生成するイニシャライズ
     UserDefaultで保存したdictionaryから生成することを目的
     */
    init(from dictionary: [String: Any]) {
        if let text = dictionary["text"] as? String {
            self.text = text
        } else {
            self.text = ""
        }
        
        if let deadline = dictionary["deadline"] as? Date {
            self.deadline = deadline
        } else {
            self.deadline = Date()
        }
    }
}
