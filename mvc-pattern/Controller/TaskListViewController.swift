//
//  TaskListViewController.swift
//  mvc-pattern
//
//  Created by 渡邊丈洋 on 2018/09/12.
//  Copyright © 2018年 takehiro. All rights reserved.
//

import UIKit

// Controller層: ModelとViewの仲介役を行う。データをロードし、UIに反映させる
class TaskListViewController: UIViewController {
    
    var dataSource: TaskDataSource!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = TaskDataSource()
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonTapped(_:)))
        navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.loadData() // 画面が表示されるたびに、データをロードする
        tableView.reloadData() // データをロードした後tableViewを更新する
    }
    
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
        // タスク作成画面へ遷移
        let controller = CreateTaskViewController()
        let navi = UINavigationController(rootViewController: controller)
        present(navi, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count() // dataSourceのカウントがcellの数になる
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskListCell
        // indexPath.rowに応じたTaskを取り出す
        cell.task = dataSource.data(at: indexPath.row)
        return cell
    }
}

// MARK: -
extension TaskListViewController: UITableViewDelegate {
    
}
