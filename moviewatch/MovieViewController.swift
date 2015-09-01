//
//  MovieViewController.swift
//  moviewatch
//
//  Created by Zet on 8/29/15.
//  Copyright (c) 2015 pt. All rights reserved.
//

import UIKit
import AFNetworking

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (Response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
            }

        }  // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let movies = movies {
                return movies.count
            } else {
                return 0
            }
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
            let movie = movies![indexPath.row]
            cell.titleLabel.text = movie["title"] as? String
            cell.syopsisLabel.text = movie["syopsis"] as? String
            
            let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
            cell.posterView.setImageWithURL(url)
            
            return cell
        }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
