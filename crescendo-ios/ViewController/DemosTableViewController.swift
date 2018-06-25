//
//  DemosTableViewController.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 24/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class DemoCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artworkNameLabel: UILabel!
    
    func updateview(for artwork: Artwork) {
        nameLabel.text = artwork.artistName
        artworkNameLabel.text = artwork.title
        
        if let url = URL(string: artwork.thumbnail) {
            thumbnailImageView.af_setImage(withURL: url)
        }
    }
}

class DemosTableViewController: UITableViewController {
    var artworks: [Artwork] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artworks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DemoCell
        
        cell.updateview(for: artworks[indexPath.row])
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateData() {
        let headers = ["Authorization" : "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Mjk5NDc1MDF9.WKmBLiLaMAEv6ZYHGcvRdt1uMfIzLH1GGTGPekSNtZM"]
        
        
        Alamofire.request(CrescendoApi.createArtworkUrl, headers: headers)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.artworks = Artwork.buildAll(from: json.arrayValue)
                    self.tableView!.reloadData()

                    print(json)

                case .failure(let error):
                    print(error)
                }
            })
        
        

    }

}
