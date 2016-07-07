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
        print("Loading the table view controller")
    }

}

