//
//  ViewController.swift
//  MyFirstAPI
//
//  Created by 小島満天 on 2020/07/19.
//  Copyright © 2020 Manchen. All rights reserved.
//

import UIKit
import APIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //デレゲート、データソースの設定
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        //カスタムセルの登録(TableViewのメソッドregisterを使う)
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        
        sendRequest()
        
    }
    
    var informations: [Informations]?
    
    private func sendRequest() {
        let request = FetchGithubRequest(baseURL: URL(string: "https://api.github.com")!)
        
        Session.send(request) { result in
            switch result {
            case .success(let response):
                print(response)
                self.informations = response
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                print("何かがおかしい")
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let informations = informations else { return 0 }
        return informations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        if let informations = informations {
            cell.customLabel.text = informations[indexPath.row].login
            cell.customImage.kf.setImage(with: URL(string: informations[indexPath.row].avator_url))
        }
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
        if let informations = informations {
            viewController.nextURL = informations[indexPath.row].html_url
        }
        //画面遷移実行
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        search(searchText)
    }
    
    func search(_ text: String) {
        var newArray: [Informations] = []
        if informations != nil {
            informations?.forEach({
                if $0.login.contains(text){
                    newArray.insert($0, at: 0)
                } else {
                    newArray.append($0)
                }
            })
        }
    }
}

