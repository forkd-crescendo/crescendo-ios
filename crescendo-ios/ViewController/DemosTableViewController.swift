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
        nameLabel.text = artwork.title
        artworkNameLabel.text = artwork.description
        
        if let url = URL(string: artwork.thumbnail) {
            thumbnailImageView.af_setImage(withURL: url)
        }
    }
}

class DemosTableViewController: UITableViewController {
    var artworks: [Artwork] = []
    var currentArtworkIndex: Int = 0
    let settings = SettingsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

       self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Agregar", style: .plain, target: self, action: #selector(addTapped))
        
        updateData()
    }
    @objc func addTapped(){
        performSegue(withIdentifier: "showAddDemo", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        self.tableView!.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
        currentArtworkIndex = indexPath.row
        self.performSegue(withIdentifier: "ShowArtworkVideo", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowArtworkVideo" {
            let artworkViewController = (segue.destination as! UINavigationController).viewControllers.first as! ArtworkViewController
            currentArtworkIndex = (self.tableView.indexPathForSelectedRow?.row)!
            
            artworkViewController.artwork = artworks[currentArtworkIndex]
        }
        return
    }

    
    func updateData() {
        let headers = ["Authorization" : settings.auth_token!]
        
        
        Alamofire.request(CrescendoApi.createArtworkUrl, headers: headers)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.artworks = Artwork.buildAll(from: json.arrayValue)
                    self.tableView!.reloadData()

                case .failure(let error):
                    print(error)
                }
            })
        
        

    }

}
