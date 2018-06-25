//
//  SignupViewController.swift
//  crescendo-ios
//
//  Created by Franco Rivera Rivas on 6/24/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignupViewController: UIViewController {
    let settings = SettingsRepository()

    @IBOutlet weak var genreTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var roleTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func registerAction(_ sender: BorderView) {
        if ((genreTextField.text != nil) && (nameTextField.text != nil) && (roleTextField.text != nil) && (
            emailTextField.text != nil) && (passwordTextField.text != nil) && (confirmPasswordTextField.text != nil)){
            let parameters = ["email": emailTextField.text!,
                              "password": passwordTextField.text!,
                              "pasword_confirm": confirmPasswordTextField.text!,
                              "name": nameTextField.text!,
                              "genre": genreTextField.text!,
                              "role": roleTextField.text!,
                              "photo": "https://uinames.com/api/photos/male/1.jpg"]
            Alamofire.request(CrescendoApi.signUpUrl, method: .post, parameters: parameters)
            .responseJSON(completionHandler:
                { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print(json.dictionaryValue)
                        if (json.dictionaryValue["message"] == "Invalid credentials"){
                            print("no son las credenciales")
                        }
                        else if(json.dictionaryValue["auth_token"] != nil){
                            self.settings.auth_token = (json.dictionaryValue["auth_token"]?.stringValue)!
                            print("bienvenido")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
