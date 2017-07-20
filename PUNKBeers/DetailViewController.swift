//
//  DetailViewController.swift
//  PUNKBeers
//
//  Created by Danny on 19/07/17.
//  Copyright © 2017 Danny. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var descriLabel: UILabel!
    
    @IBOutlet weak var abvLabel: UILabel!
    
    
    @IBOutlet weak var ibuLabel: UILabel!
    
    
    
    var nameString:String!
    var taglineString: String!
    var descriString:String!
    var abvString:String!
    var ibuString:String!
    var imageString:String!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    func updateUI() {
        self.nameLabel.text = nameString
        self.taglineLabel.text = taglineString
        self.abvLabel.text = abvString
        self.ibuLabel.text = ibuString
        self.descriLabel.text = descriString
        
        let imgURL = URL(string:imageString)
        
        let data = NSData(contentsOf: (imgURL)!)
        self.imageView.image = UIImage(data: data as! Data)
    }
}
