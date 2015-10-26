//
//  SCPhotoFiltersViewController.swift
//  ImageFilters
//
//  Created by WJ on 15/10/26.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class SCPhotoFiltersViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredImages = preFilterImages()

    }
    
    let filters = ["CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant",
                   "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess",
                   "CIPhotoEffectTonal", "CIPhotoEffectTransfer"]
    
    let inputImage = CIImage(CGImage: UIImage(named: "shinobi-badge-head")!.CGImage!)

    var  filteredImages:[UIImage]?


    
    func preFilterImages()->[UIImage]{
        var images = [UIImage]()
        for filtername in filters{
            let filter = CIFilter(name: filtername)!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            
//            let cgImage = CIContext().createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
//            let image = UIImage(CGImage: cgImage)
            let image = UIImage(CIImage: filter.outputImage!)
            
            images.append(image)
        }
        return images
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages!.count + 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SCLabelledImageCell
        if indexPath.row > 0{
            cell.imageView.image = filteredImages![indexPath.row-1]
            cell.titleLabel.text = filters[indexPath.row-1]
        }else{
            cell.imageView.image = UIImage(CIImage: inputImage)
            cell.titleLabel.text = "Original"
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
