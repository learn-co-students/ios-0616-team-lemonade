//
//  ZodiacSignsViewController.swift
//  Lemonade
//
//  Created by Bettina on 8/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//


import UIKit


private let reuseIdentifier = "collectionCell"

class ZodiacSignsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    
    let iconsArray: [String] = ["capricorn_black_parkjisun", "aquarius_black_parkjisun",  "pisces_black_parkjisun", "aries_black_parkjisun", "taurus_black_parkjisun", "gemini_black_parkjisun", "cancer_black_parkjisun",  "leo_black_parkjisun", "virgo_black_parkjisun",  "libra_black_parkjisun", "scorpio_black_parkjisun", "sagittarius_black_parkjisun"]
    
    let iconsDictionary: [String: String] = [ "capricorn_black_parkjisun" : "capricorn", "aquarius_black_parkjisun" : "aquarius", "pisces_black_parkjisun": "pisces", "aries_black_parkjisun" : "aries", "taurus_black_parkjisun": "taurus", "gemini_black_parkjisun" : "gemini", "cancer_black_parkjisun": "cancer", "leo_black_parkjisun": "leo","virgo_black_parkjisun" : "virgo", "libra_black_parkjisun" : "libra", "scorpio_black_parkjisun" : "scorpio", "sagittarius_black_parkjisun" : "sagittarius"]
    
    
    var passedHoroscopeString: String?
    var imageNASAView = UIImageView()
    var collectionViewHoroscopeString = ""
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        NASAApiPicture()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let xInset: CGFloat = 10
        let yInset: CGFloat = 20
        let padding: CGFloat = 10
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let collectionViewCenterYConstant = ((navBarHeight! + statusBarHeight) / 2) + yInset + padding
        
        layout.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        //layout.itemSize = CGSizeMake( 80, 80)
        
        collectionView = UICollectionView(frame: self.imageNASAView.frame, collectionViewLayout: layout)
        // collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        collectionView.backgroundColor = UIColor(white: 0.1, alpha: 0.0)
        self.view.addSubview(collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.collectionView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: collectionViewCenterYConstant).active = true
        self.collectionView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.75).active = true
        self.collectionView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.85).active = true
        
        self.collectionView.allowsSelection = true
        
        self.title = "Other Horoscopes"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Done, target: self, action: #selector(ZodiacSignsViewController.goBackToHomepage))
    }
    

    
    func goBackToHomepage()
    {
        performSegueWithIdentifier("goBackToHomePage", sender: self)
    }
    
    func NASAApiPicture () {
        
        self.view.addSubview(self.imageNASAView)
        self.imageNASAView.translatesAutoresizingMaskIntoConstraints = false
        self.imageNASAView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.imageNASAView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        self.imageNASAView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor).active = true
        self.imageNASAView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
//        self.view.sendSubviewToBack(self.imageNASAView)
        
        NASA_API_Client.getMediaType { (mediaType) in
            
            if mediaType == "video"
            {
                self.imageNASAView.image = UIImage.init(named: "spaceImage4.jpg")
            }
            else
            {
                NASA_API_Client.getPhotoOfDay { (spaceImage) in
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.imageNASAView.image = spaceImage
                    })
                }
            }
            
        }
        

        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.iconsArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath)
        
        print("cell \(indexPath.row) is getting created")
        
        cell.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        
        let zodiacName = UILabel()
        let signIconView = UIImageView()
        
        signIconView.contentMode = .ScaleAspectFit
        signIconView.clipsToBounds = true
        signIconView.tintColor = UIColor.whiteColor()
        
        
        zodiacName.textAlignment = NSTextAlignment.Center
        zodiacName.textColor = UIColor.whiteColor()
        zodiacName.font = UIFont(name: "BradleyHandITCTT-Bold", size: 16.0)
        zodiacName.adjustsFontSizeToFitWidth = true
        
        
        cell.addSubview(signIconView)
        cell.addSubview(zodiacName)
        
        signIconView.translatesAutoresizingMaskIntoConstraints = false
        signIconView.widthAnchor.constraintEqualToAnchor(cell.widthAnchor).active = true
        signIconView.heightAnchor.constraintEqualToAnchor(cell.heightAnchor, multiplier: 0.75).active = true
        signIconView.topAnchor.constraintEqualToAnchor(cell.topAnchor).active = true
        signIconView.leadingAnchor.constraintEqualToAnchor(cell.leadingAnchor).active = true
        
        zodiacName.translatesAutoresizingMaskIntoConstraints = false
        zodiacName.centerXAnchor.constraintEqualToAnchor(signIconView.centerXAnchor).active = true
        zodiacName.topAnchor.constraintEqualToAnchor(signIconView.bottomAnchor).active = true
        zodiacName.widthAnchor.constraintEqualToAnchor(cell.widthAnchor).active = true
        
        
        
        let icon = iconsArray[indexPath.row]
        signIconView.image = UIImage(named: icon)
        
        zodiacName.text = iconsDictionary[icon]?.capitalizedString
        
        cell.userInteractionEnabled = true
        
        signIconView.userInteractionEnabled = false
        zodiacName.userInteractionEnabled = false
        
        
        return cell
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(imageNASAView.frame.width/5.5, imageNASAView.frame.height/6.5)
        // return CGSizeMake(, collectionView.frame.height/4)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //self.performSegueWithIdentifier("dailyHoroscope", sender: iconsArray[indexPath.item])
        
        let iconArrayString = iconsArray[indexPath.row]
        
        if let unwrappedString = iconsDictionary[iconArrayString]
        {
            self.collectionViewHoroscopeString = unwrappedString
        }
        
        
        print(self.collectionViewHoroscopeString)
        self.performSegueWithIdentifier("dailyHoroscope", sender: self.collectionViewHoroscopeString)
        
        
        
        
    }
    
    //    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
    //
    //        let cell = UICollectionViewCell()
    //
    //        if cell.highlighted == true {
    //            cell.layer.borderColor = UIColor.purpleColor().CGColor
    //        } else {
    //
    //            cell.layer.borderColor = UIColor.clearColor().CGColor
    //        }
    //
    //    }
    //
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        print("prepare for segue")
        //
        //       print("\(sender) we're in the prepare for segue")
        //
        //
        //
        //        if segue.identifier == "dailyHoroscope" {
        //
        //            let destinationHoroscopeVC: HoroscopeViewController = segue.destinationViewController as! HoroscopeViewController
        //            let selectedCell = sender as! UICollectionViewCell
        //            let indexPath = self.collectionView.indexPathForCell(selectedCell)
        //            let zodiacImage = iconsArray[indexPath!.row]
        //
        //            let iconNameString = iconsDictionary[zodiacImage]
        //            destinationHoroscopeVC.passedHoroscopeString = iconNameString
        
        
        //print("segue is  == dailyHoro")
        
        //        }
        
       
        if segue.identifier == "dailyHoroscope"
        {
            let destinationVC = segue.destinationViewController as? HoroscopeViewController
            
            destinationVC?.passedHoroscopeString = self.collectionViewHoroscopeString
        }
        
    }
    
    
    
}