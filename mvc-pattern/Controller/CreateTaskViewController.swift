//
//  CreateTaskViewController.swift
//  mvc-pattern
//
//  Created by 渡邊丈洋 on 2018/09/16.
//  Copyright © 2018年 takehiro. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    fileprivate var createTaskView: CreateTaskView!
    
    fileprivate var dataSource: TaskDataSource!
    fileprivate var taskText: String?
    fileprivate var taskDeadline: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        /*
         CreateTaskViewを生成し、デリゲートにselfをセットしている
         */
        createTaskView = CreateTaskView()
        createTaskView.delegate = self
        view.addSubview(createTaskView)
        
        /*
         TaskDataSourceを生成
         */
        dataSource = TaskDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /*
         CreateTaskViewのレイアウト決めている
         */
        createTaskView.frame = CGRect(
            x: view.safeAreaInsets.left,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
            height: view.frame.size.height - view.safeAreaInsets.bottom
        )
    }
    
    /*
     保存が成功した時のアラート
     保存が成功したら、アラートを出し前の画面に戻る
     */
    fileprivate func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    /*
     タスクが未入力の時のアラート
     タスクが未入力の時に保存して欲しくない
     */
    fileprivate func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    /*
     締切日が未入力の時のアラート
     締切日が未入力の時に保存して欲しくない
     */
    fileprivate func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - CreateTaskViewDelegate
extension CreateTaskViewController: CreateTaskViewDelegate {
    func createView(taskEditting view: CreateTaskView, text: String) {
        /*
         タスク内容を入力している時に呼ばれるデリゲートメソッド
         CreateTaskViewからタスク内容を受け取りtaskTextに代入している
         */
        taskText = text
    }
    
    func createView(deadlineEditting view: CreateTaskView, deadline: Date) {
        /*
         締切日を入力している時に呼ばれるデリゲートメソッド
         CreateTaskViewからタスク内容を受け取りtaskDeadlineに代入している
         */
        taskDeadline = deadline
    }
    
    func createView(saveButtonDidTap view: CreateTaskView) {
        /*
         保存ボタンが押された時に呼ばれるデリゲードメソッド
         */
        guard let taskText = taskText else {
            showMissingTaskTextAlert()
            return
        }
        guard let taskDeadline = taskDeadline else {
            showMissingTaskDeadlineAlert()
            return
        }
        let task = Task(text: taskText, deadline: taskDeadline)
        dataSource.save(task: task)
        
        showSaveAlert()
    }
    
}
