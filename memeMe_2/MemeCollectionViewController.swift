//
//  MemeCollectionViewController.swift
//  memeMe_2
//
//  Created by Anna Rogers on 7/7/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
//    access the memes in the app delegate
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidAppear(animated: Bool) {
        print("loading view collection", memes.count)
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        adjustFlowLayout(view.frame.size)
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCellViewController", forIndexPath: indexPath) as! MemeCollectionCellViewController
        let item = memes[indexPath.row]
        cell.backgroundView = UIImageView(image: item.memedImage)
        return cell
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("transition called")
        adjustFlowLayout(size)
    }
    
    func adjustFlowLayout(size: CGSize) {
//        print("called", flowLayout)
        let space: CGFloat = 0.5
        let dimension:CGFloat = size.width >= size.height ? (size.width - (5 * space)) / 6.0 :  (size.width - (2 * space)) / 3.0
        flowLayout.minimumLineSpacing = 0.0
//        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.sectionInset = UIEdgeInsetsMake(-18, 0, 0, 0)
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }

//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let kWhateverHeightYouWant = 100
//        let space: CGFloat = 0.5
//        let dimension:CGFloat = view.frame.width >= view.frame.height ? (view.frame.width - (5 * space)) / 6.0 :  (view.frame.width - (2 * space)) / 3.0
//        flowLayout.minimumLineSpacing = 0.0
//        flowLayout.minimumInteritemSpacing = 0.0
//        return CGSizeMake(dimension, dimension)
//    }
    
}