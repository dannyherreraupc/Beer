//
//  ViewController.swift
//  PUNKBeers
//
//  Created by Danny on 19/07/17.
//  Copyright © 2017 Danny. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    final let urlString = "https://api.punkapi.com/v2/beers"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var abvArray = [String]()
    var imgURLArray = [String]()
    var taglineArray = [String]()
    var ibuArray = [String]()
    var descriptionArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonWithURL()
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]]{
                
                for beershow in jsonObj! {
                    if let name = beershow["name"] as? String {
                        self.nameArray.append(name)
                    }
                    
                    if let abv = beershow ["abv"] as? Double {
                        self.abvArray.append("\(abv)")
                    }
                    
                    if let name = beershow ["image_url"] as? String {
                        self.imgURLArray.append(name)
                    }
                    
                    if let descri = beershow ["description"] as? String {
                        self.descriptionArray.append(descri)
                    }
                    
                    if let tagl = beershow ["tagline"] as? String {
                        self.taglineArray.append(tagl)
                    }
                    
                    if let ibu  = beershow ["ibu"] as? Double {
                        self.ibuArray.append("\(ibu)")
                    }
                    
                }
                
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        }).resume()
    }
    
    
    func downloadJsonWithTask() {
        
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData!)
            
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.abvLabel.text = abvArray[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.imgView.image = UIImage(data: data as! Data)
        }
        
        return cell
    }
    
    /// para mostrar dados na tela de detalhes
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.imageString = imgURLArray[indexPath.row]
        vc.nameString = nameArray[indexPath.row]
        vc.abvString = abvArray[indexPath.row]
        vc.descriString = descriptionArray[indexPath.row]
        vc.taglineString = taglineArray[indexPath.row]
        vc.ibuString = ibuArray[indexPath.row]
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

