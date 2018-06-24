//
//  ArtistsTableViewController.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 24/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    func updateViews(from artist: Artist) {
        nameLabel.text = artist.name
        genreLabel.text = artist.genre
    }
    
    
}

class ArtistsTableViewController: UITableViewController {
    var artists: [Artist] = []
    var currentArtistIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // update cell height
        tableView.beginUpdates()
        tableView.endUpdates()

        generateMockData()
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
        return artists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ArtistTableViewCell
        
        cell.updateViews(from: artists[indexPath.row])
        

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentArtistIndex = indexPath.row
        self.performSegue(withIdentifier: "showArtistDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArtistDetail" {
            let artistsDetailViewController = (segue.destination as! ArtistDetailViewController)
            artistsDetailViewController.artist = artists[currentArtistIndex]
        }

    }
    
    func generateMockData() {
        for index in 1...10 {
            artists.append(Artist(name: "mi artista \(index)", genre: "mi genero \(index)"))
        }
    }


}