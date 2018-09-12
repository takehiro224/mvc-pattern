//
//  TaskDataSource.swift
//  mvc-pattern
//
//  Created by 渡邊丈洋 on 2018/09/12.
//  Copyright © 2018年 takehiro. All rights reserved.
//

import Foundation

class TaskDataSource: NSObject {
    // Task一覧を保持するArray UITableViewに表示させるためのデータ
    private var tasks = [Task]()
    
    // UserDefaultsから保存したTask一覧を取得
    func loadData() {
        let userDefaults = UserDefaults.standard
//        guard let taskDictionaries = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
//        for dic in taskDictionaries {
//            let task = Task(from: dic)
//            tasks.append(task)
//        }
        guard let t = userDefaults.object(forKey: "tasks") as? Data else { return }
        guard let unArchivedData = NSKeyedUnarchiver.unarchiveObject(with: t) as? [Task] else { return }
        self.tasks = unArchivedData
    }
    
    // TaskをUserDefaultsに保存
    func save(task: Task) {
        tasks.append(task)
        
        let encodeTask = NSKeyedArchiver.archivedData(withRootObject: tasks)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodeTask, forKey: "tasks")
        userDefaults.synchronize()
    }
    
    // Taskの総数を返す。UITableViewのcellのカウントに使用
    func count() -> Int {
        return tasks.count
    }
    
    /*
     指定したindexに対応するTaskを返している indexにはUITableViewのIndexPath.rowがくることを想定
     */
    func data(at index: Int) -> Task? {
        if index < tasks.count {
            return tasks[index]
        }
        return nil
    }
}
