//
//  NextViewController.swift
//  MyFirstAPI
//
//  Created by 小島満天 on 2020/07/19.
//  Copyright © 2020 Manchen. All rights reserved.
//

import UIKit
import WebKit

class NextViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let nextURL = nextURL {
            openURL(nextURL)
        }
    }
    
    //遷移元から値を受け取るプロパティ
    var nextURL: String?
    
    //URLを開くメソッド
    private func openURL(_ string: String?) {
        guard let urlStr = string else { return }
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
