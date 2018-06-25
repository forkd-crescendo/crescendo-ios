//
//  ArtistsTableViewController.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 24/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!

//    func setFavoriteImage() {
//        let name = isFavorite ? "favorite-black" : "favorite-border"
//        //favoriteButton.imageView!.image = UIImage(named: name)
//        favoriteButton.setImage(UIImage(named: name), for: .normal)
//    }

    func updateViews(from artist: Artist, isFavorite: Bool) {
        nameLabel.text = artist.name
        genreLabel.text = artist.genre
        if let url = URL(string: artist.photoUrl) {
            pictureImageView.af_setImage(withURL: url)
        }

        let name = isFavorite ? "star-filled" : "star-border"
        likeButton.setImage(UIImage(named: name), for: .normal)
    }


}

class ArtistsTableViewController: UITableViewController {
    let settings = SettingsRepository()
    var artists: [Artist] = []
    var currentArtistIndex: Int = 0
    var favoritesIds: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // update cell height
        tableView.beginUpdates()
        tableView.endUpdates()

        // generateMockData()
        updateData()
        getFavoritesIds()
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



        cell.updateViews(from: artists[indexPath.row], isFavorite: isIdInFavorites(id: Int(artists[indexPath.row].id)!, ids: favoritesIds))

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

    @IBAction func likeAction(_ sender: UIButton) {

        // parent of parent
        if let index = self.tableView.indexPath(for: sender.superview?.superview?.superview as! ArtistTableViewCell)?.row {
            let selectedFavoriteId = artists[index].id
            let headers = ["Authorization" : settings.auth_token!]


            if isIdInFavorites(id: Int(selectedFavoriteId)!, ids: favoritesIds) {

                let deleteFavoriteURL = CrescendoApi.deleteFavoriteUrl(for: Int(selectedFavoriteId)!)

                Alamofire.request(deleteFavoriteURL, method: .delete, headers: headers)
                    .validate()
                    .responseJSON(completionHandler: { response in
                        switch response.result {
                        case .success(let value):

                            let json = JSON(value)
                            let name = "star-border"
                            sender.setImage(UIImage(named: name), for: .normal)

                            // finding index using index(where:) method
                            if let index = self.favoritesIds.index(where: { $0 ==  Int(selectedFavoriteId)!}) {
                                self.favoritesIds.remove(at: index)

                            }
                                // removing item


                        case .failure(let error):
                            print(error)
                        }
                    })

                print(selectedFavoriteId)

            } else {
                let parameters = ["favourite_id" : String(selectedFavoriteId)]

                Alamofire.request(CrescendoApi.createFavoriteUrl, method: .post, parameters: parameters, headers: headers)
                    .validate()
                    .responseJSON(completionHandler: { response in
                        switch response.result {
                        case .success(let value):

                            let json = JSON(value)
                            let name = "star-filled"
                            sender.setImage(UIImage(named: name), for: .normal)
                        self.favoritesIds.append(Int(selectedFavoriteId)!)

                        case .failure(let error):
                            print(error)
                        }
                    })

                print(selectedFavoriteId)
            }
        }

    }

    func updateData() {

        let headers = ["Authorization" : settings.auth_token! ]

        Alamofire.request(CrescendoApi.artistsUrl, headers: headers)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    self.artists = Artist.buildAll(from: json.arrayValue)
                    self.tableView!.reloadData()

                case .failure(let error):
                    print(error)
                }
            })
    }

    func getFavoritesIds() {

        self.favoritesIds = []

        let headers = ["Authorization" : settings.auth_token!]

        Alamofire.request(CrescendoApi.createFavoriteUrl, headers: headers)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    for jsonitem in json.array! {
                        self.favoritesIds.append(Int(jsonitem["favourite_id"].stringValue)!)
                    }

                case .failure(let error):
                    print(error)
                }
            })
    }

    func isIdInFavorites(id: Int, ids: [Int]) -> Bool {
        for idItem in ids {
            if idItem == id {
                return true
            }
        }
        return false
    }

}
