//
//  MemeCollectionViewController.swift
//  memeMe_2
//
//  Created by Anna Rogers on 7/7/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
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
        cell.memeView.image = item.memedImage
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row].memedImage
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        adjustFlowLayout(size)
    }
    
    func adjustFlowLayout(size: CGSize) {
        let space: CGFloat = 2.0
        let dimension:CGFloat = size.width >= size.height ? (size.width - (5 * space)) / 6.0 :  (size.width - (2 * space)) / 3.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
}