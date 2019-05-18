//
//  ViewController.swift
//  GithubJSON
//
//  Created by MNA Developer on 17/05/2019.
//  Copyright © 2019 Naeem. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet weak var naemLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    var userString : String = ""
    
   
    
//   let url = "https://api.github.com/users/\(userNameTextField.text!)"
    
    
    
    var gitHubData = gitData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        

    }


    @IBAction func checkButton(_ sender: UIButton) {
        
        userString  = usernameLabel.text!
        let url = "https://api.github.com/users/\(userNameTextField.text!)"
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print(" **************** Success ****************")
                let gitJSON : JSON = JSON(response.result.value!)
                print(gitJSON)
                
                self.gettingJSON(json: gitJSON)
                
            }else{
                print("Error \(String(describing: response.result.error))")
            }
        }
        
        update()
        
    }
    
    
    func gettingJSON(json: JSON){
        
        gitHubData.gitBio = json["bio"].stringValue
        gitHubData.gitCompany = json["company"].stringValue
        gitHubData.gitLocation = json["location"].stringValue
        gitHubData.gitLogin = json["login"].stringValue
        gitHubData.gitName = json["name"].stringValue
        gitHubData.gitRepo = json["public_repos"].intValue
        
        update()
    }
    
   
    func update(){
        
        bioLabel.text = gitHubData.gitBio
        companyLabel.text = gitHubData.gitCompany
        naemLabel.text = gitHubData.gitName
        usernameLabel.text = gitHubData.gitLogin
        locationLabel.text = gitHubData.gitLocation
        repoLabel.text = String(gitHubData.gitRepo)
    }
    

}

