//
//  ViewController.swift
//  MyFirstAPI
//
//  Created by 小島満天 on 2020/07/19.
//  Copyright © 2020 Manchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //デレゲート、データソースの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        //カスタムセルの登録(TableViewのメソッドregisterを使う)
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.customLabel.text = "こんにちは〜"
        return cell
    }
    
    //セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //画面遷移
        //遷移先のstoryboard取得
        let storyboard = UIStoryboard(name: "Next", bundle: nil)
        //遷移先のviewControllerをインスタンス化（Entry Pointないとnil)
        guard let viewController = storyboard.instantiateInitialViewController() as? NextViewController else { return }
        //画面遷移実行時、値を受け渡す
        viewController.nextURL = "https://furiwake.alltimeneet.com/entries/clfd0F7GHit9JW7l"
        //画面遷移実行
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

