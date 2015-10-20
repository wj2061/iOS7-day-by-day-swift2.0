//
//  SCViewController.swift
//  SpringCarousel
//
//  Created by WJ on 15/10/16.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SpringyCell"

class SCViewController: UICollectionViewController {
    let itemSize = CGSize(width: 70, height: 70)
    
    var viewLayout :UICollectionViewFlowLayout?
    
    var  collectionViewCellContent = [Int]()
    
    
    @IBAction func newViewButtonPressed() {
        let newTile = collectionViewCellContent.count
        let rightOfCenter = indexPathOfItemRightOfCenter()
        
        collectionViewCellContent.insert(newTile, atIndex: rightOfCenter.item)
        
        collectionView!.insertItemsAtIndexPaths([rightOfCenter])
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSpringyCarousel()
        
        createCells()
        
    }

    private func prepareSpringyCarousel(){
        viewLayout = SCSpringyCarousel(size: itemSize)
        viewLayout?.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.collectionViewLayout = viewLayout!
    }
    
    private func createCells(){
        for i in 0...30{
            collectionViewCellContent.append(i)
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellContent.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as!SCCollectionViewSampleCell
        cell.numberLabel.text = "\(collectionViewCellContent[indexPath.row])"
        return cell
    }

    // MARK: UICollectionViewDelegate
    
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return itemSize
    }
    
    //MARK: - Utility methods
    
    func indexPathOfItemRightOfCenter()->NSIndexPath{
        let visibleItems = collectionView!.indexPathsForVisibleItems()
        
        let midX = CGRectGetMidX(collectionView!.bounds)
        var indexOfItem = 0
        var curMin = CGFloat.max
        
        for indexPath in visibleItems{
            let cell = collectionView!.cellForItemAtIndexPath(indexPath)!
            if  abs(CGRectGetMidX(cell.frame) - midX ) < abs(curMin){
                curMin = CGRectGetMidX(cell.frame) - midX
                indexOfItem = indexPath.item
            }
        }
        
        if curMin < 0{
            indexOfItem += 1
        }
        return NSIndexPath(forItem: indexOfItem, inSection: 0)
    }

}
