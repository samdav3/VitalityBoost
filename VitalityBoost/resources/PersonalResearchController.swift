//
//  PersonalResearchController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import WebKit

class PersonalResearchController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var rcvdUsername = ""
        
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }


        override func viewDidLoad() {
            super.viewDidLoad()
            
            let myURL = URL(string:"https://www.google.com")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    }
