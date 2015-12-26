//
//  ProfileCell.swift
//  XCHAT
//
//  Created by Mateo Garcia on 5/27/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numPhotosLabel: UILabel!
    @IBOutlet weak var numFavesLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUpCell()
    }
    
    override func prepareForReuse() {
        
        print("PREPARING CELL")
        
        self.setUpCell()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helpers
    
    func setUpCell() {
        if let photo = PFUser.currentUser()?.objectForKey("photo") as? PFFile {
            let pfImageView = PFImageView()
            
            pfImageView.image = UIImage(named: "LOGIN BACKGROUND 1")
            
            print(photo)
            pfImageView.file = photo as PFFile
            pfImageView.loadInBackground { (image: UIImage?, error: NSError?) -> Void in
                if let error = error {
                    // Log details of the failure
                    print("Error: \(error) \(error.userInfo)")
                    
                } else {
                    self.photoImageView.image = image
                }
            }
            
        } else {
            self.photoImageView.image = UIImage(named: "LOGIN BACKGROUND 1")
        }
        
        photoImageView.layer.cornerRadius = 3
        photoImageView.clipsToBounds = true
        
        if let name = PFUser.currentUser()?.objectForKey("name") as? String {
            nameLabel.text = name
            
        } else {
            nameLabel.text = "Tap here to setup profile"
        }
        
        if let username = PFUser.currentUser()?.objectForKey("username") as? String {
            usernameLabel.text = username
        }
        
        if let numPhotos = PFUser.currentUser()?.objectForKey("numPhotosPosted") as? Int {
            numPhotosLabel.text = "\(numPhotos) photos"
        }
        
        if let numFaves = PFUser.currentUser()?.objectForKey("totalNumFavesReceived") as? Int {
            numFavesLabel.text = "\(numFaves) faves received"
        }
    }

}
