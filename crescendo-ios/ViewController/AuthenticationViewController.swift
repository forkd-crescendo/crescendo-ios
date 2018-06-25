//
//  AuthenticationViewController.swift
//  crescendo-ios
//
//  Created by Franco Rivera Rivas on 6/24/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthenticationViewController: UIViewController {
  let settings = SettingsRepository()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "showMainApp"){
            if ((self.settings.auth_token) != nil){
                return true
            }
            else{
                return false
            }
        }
        return true
    }
    @IBAction func loginAction(_ sender: UIButton) {
        if (usernameTextField.text != nil && passwordTextField.text != nil){
            let parameters = ["email": usernameTextField.text!, "password":  passwordTextField.text!]
            Alamofire.request(CrescendoApi.authLoginUrl,
                              method: .post,
                              parameters: parameters)
                .responseJSON(completionHandler:
                    { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            if (json.dictionaryValue["message"] == "Invalid credentials"){
                                print("no son las credenciales")
                            }
                            else if(json.dictionaryValue["auth_token"] != nil){
                                self.settings.auth_token = (json.dictionaryValue["auth_token"]?.stringValue)!
                                print("bienvenido, token: " + self.settings.auth_token!)
                                self.performSegue(withIdentifier: "showMainApp", sender: self)
                            }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        if (settings.auth_token != nil){
            print("ya hay auth_token, intentar login")
            self.performSegue(withIdentifier: "showMainApp", sender: self)
        }
        
        
    }


}
