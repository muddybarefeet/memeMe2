//
//  MemeDetailViewController.swift
//  memeMe_2
//
//  Created by Anna Rogers on 7/7/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme:UIImage!
    
    override func viewWillAppear(animated: Bool) {
        print("detail loaded")
        memeImage.image = meme
        memeImage.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    
    @IBAction func done(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
}
