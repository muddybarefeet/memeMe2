//
//  ViewController.swift
//  memeMe_2
//
//  Created by Anna Rogers on 7/7/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    //    access the memes in the app delegate
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading the table view controller", memes.count)
    }
    
//    fuction to return the number of cells to make
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
//    function to tell the cell what it is
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableMemeCell")!
        let memeInfo = memes[indexPath.row]

        cell.textLabel?.text = memeInfo.topString + " " + memeInfo.bottomString
        cell.detailTextLabel?.text = ""
        cell.imageView?.image = memeInfo.memedImage
        
        return cell
        
    }
    
//    function for on selecting a cell what to do
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row].memedImage
        navigationController?.pushViewController(detailController, animated: true)
        
    }

}

