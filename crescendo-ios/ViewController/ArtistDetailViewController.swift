//
//  ArtistDetailViewController.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 24/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ArtworkCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func updateViews(for artwork: Artwork) {

        if let url = URL(string: artwork.thumbnail) {
            thumbnailImageView.af_setImage(withURL: url)
        }

        titleLabel.text = artwork.title
        descriptionLabel.text = artwork.description
    }

}

class ArtistDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let settings = SettingsRepository()


    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artworksTableView: UITableView!

    var artist: Artist?
    var artworks: [Artwork] = []
    var currentArtworkIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        artworksTableView.delegate = self

        if let artist = artist {
            nameLabel.text = artist.name
            if let url = URL(string: artist.photoUrl) {
                pictureImageView.af_setImage(withURL: url)
            }

        }

        // update cell height
        artworksTableView.beginUpdates()
        artworksTableView.endUpdates()

        updateData()

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworks.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtworkCell

        cell.updateViews(for: artworks[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowArtworkVideo" {
            let artworkViewController = (segue.destination as! UINavigationController).viewControllers.first as! ArtworkViewController
            currentArtworkIndex = (artworksTableView.indexPathForSelectedRow?.row)!
            artworkViewController.artwork = artworks[currentArtworkIndex]
        }
        return
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func updateData() {
        let headers = ["Authorization" : settings.auth_token! ]

        let getArtworksUrl = CrescendoApi.getArtworks(by: artist!.id)

        Alamofire.request(getArtworksUrl, headers: headers)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.artworks = Artwork.buildAll(from: json.arrayValue)
                    self.artworksTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })

    }

}
