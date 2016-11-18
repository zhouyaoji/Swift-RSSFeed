//
//  WebviewController.swift
//  RSSFeeder
//
//  Created by Jigar M on 06/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

class WebviewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webview : UIWebView!
    @IBOutlet var activity : UIActivityIndicatorView!
    var url : String?
    var Headline : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.Headline
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let requestURL = URL(string: self.url!)
        let request = URLRequest(url: requestURL!)
        self.webview.delegate = self;
        self.webview.loadRequest(request)
        super.viewWillAppear(animated);
    }
    
    func webViewDidStartLoad(_ _webView: UIWebView){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        activity.startAnimating();
    }
    
    func webViewDidFinishLoad(_ _webView: UIWebView!){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
        activity.stopAnimating();
    }
    
    func webView(_ _webView: UIWebView!,
        shouldStartLoadWith request: URLRequest,
        navigationType _navigationType: UIWebViewNavigationType) -> Bool{
            NSLog("Loading URL :%@",request.url?.absoluteString ?? "<nil>");
            return true;
    }
    
    func webView(_ _webView: UIWebView!,
        didFailLoadWithError error: Error) {
            NSLog("Failed to load with error :%@",error.localizedDescription);
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
