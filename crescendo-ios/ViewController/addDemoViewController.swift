//
//  addDemoViewController.swift
//  crescendo-ios
//
//  Created by Franco Rivera Rivas on 6/25/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class addDemoViewController: UIViewController {
    
    let settings = SettingsRepository()
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var descriptionLabel: UITextField!
    
    @IBOutlet weak var videoLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addDemoAction(_ sender: BorderView) {
        //save to database and perform segue
        let headers = ["Authorization" : settings.auth_token!]
        if ((titleLabel.text != nil) && (descriptionLabel.text != nil) && (videoLabel.text != nil)){
            let videoId = videoLabel.text!
            let index32 = videoId.index(videoId.startIndex, offsetBy: 32)
            let parameters = ["title": titleLabel.text!,
                              "description": descriptionLabel.text!,
                              "videoId" : videoId[index32...]] as [String : Any]
            Alamofire.request(CrescendoApi.createArtworkUrl, method: .post, parameters: parameters, headers: headers)
                .validate()
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                          self.performSegue(withIdentifier: "returnToDemos", sender: self)
                    case .failure(let error):
                        print(error)
                    }
                })
        }
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
