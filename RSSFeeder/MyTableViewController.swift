//
//  MyTableViewController.swift
//  RSSFeeder
//
//  Created by Jigar M on 05/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController, MWFeedParserDelegate {
    
    var items = [MWFeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        request()
    }

    func request() {
        let URL = Foundation.URL(string: "https://in.news.yahoo.com/rss/")
        let feedParser = MWFeedParser(feedURL: URL);
        feedParser?.delegate = self
        feedParser?.feedParseType = ParseTypeFull
        feedParser?.parse()
    }
    
    func feedParserDidStart(_ parser: MWFeedParser) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        self.items = [MWFeedItem]()
    }
    
    func feedParserDidFinish(_ parser: MWFeedParser) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        self.tableView.reloadData()
    }
    
    
    func feedParser(_ parser: MWFeedParser, didParseFeedInfo info: MWFeedInfo) {
        //println(info)
        self.title = info.title
    }
    
    func feedParser(_ parser: MWFeedParser, didParseFeedItem item: MWFeedItem) {
        //println(item)
        self.items.append(item)
    }
    
    // #pragma mark - Table view data source
    override func numberOfSections(in tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView!, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell {
        let cell:MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell

        // Configure the cell...
        let item = self.items[indexPath.row] as MWFeedItem
        //println(item.summary)
        cell.FeedLbl.text = item.title
        cell.FeedLbl.font = UIFont.systemFont(ofSize: 14.0)
        cell.FeedLbl.numberOfLines = 0
        cell.timestamp.text = item.date.description
        cell.img.image = UIImage(named:"a.png")
        //var projectURL:String = item.summary.componentsSeparatedByString("<img src=\"")[1] as String
        //projectURL = projectURL.componentsSeparatedByString(".jpg")[0]
        //cell.img.contentMode = UIViewContentMode.ScaleAspectFit
        //cell.img.setImageWithURL(imgURL, placeholderImage: UIImage(named: "a.png"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue?, sender: Any?) {
        if (segue!.identifier == "Detail") {
            let record = self.items[(self.tableView.indexPathForSelectedRow?.row)!] as MWFeedItem
            let WebicewVC = segue!.destination as!  WebviewController
            WebicewVC.url = record.link
            WebicewVC.Headline = record.title
        }
    }
}
