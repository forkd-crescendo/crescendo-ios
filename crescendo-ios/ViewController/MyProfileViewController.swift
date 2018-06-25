//
//  MyProfileViewController.swift
//  crescendo-ios
//
//  Created by Franco Rivera Rivas on 6/25/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class MyProfileViewController: UIViewController {
    let settings = SettingsRepository()
    @IBAction func logoutAction(_ sender: BorderView) {
        settings.auth_token = nil
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
        
        let headers = ["Authorization" : settings.auth_token!]
        //me/
        
        Alamofire.request(CrescendoApi.meUrl, headers: headers)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.nameLabel.text = (json.dictionaryValue["name"]?.stringValue)!
                    self.bioLabel.text  = (json.dictionaryValue["bio"]?.stringValue)!
                    self.profileImageView.af_setImage(withURL: URL(string: (json.dictionaryValue["photo"]?.stringValue)!)! )
                case .failure(let error):
                    print(error)
                }
            })
        
        
        
    }

}
