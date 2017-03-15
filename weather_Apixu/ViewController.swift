//
//  ViewController.swift
//  weather_Apixu
//
//  Created by arora_72 on 14/03/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var conditionLb: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    var degree: Int!
    var condition: String!
    var location: String!
    var city: String!
    
    //for the city name to exists
    
    var exists : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let urlRequest = URLRequest(url: URL(string: "http://api.apixu.com/v1/current.json?key=1700f79f3d194c689eb175153171403&q=\(searchBar.text!)")!)
        
        
        
         let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    
                    if let current = json["current"] as? [String:AnyObject]{

                        
                        //this is called as fucking chutiyapa
                        
                        // maa ki aankh
                        
//                        if let temp = json["temp_c"] as? Int {
//                            self.degree = temp;
//                        }
                        if let temp = current["temp_c"] as? Int {
                            self.degree = temp
                        }
                        if let condition = current["condition"] as? [String:AnyObject]
                        {
                            self.condition = condition["text"] as! String
                        }
                    }
                    if let location = json["location"] as? [String:AnyObject]
                    {
                        self.city = location["name"] as! String
                    }
                    if let _ = json["error"]
                    {
                        self.exists = false
                    }
                    
                    DispatchQueue.main.async {
                        if self.exists{
                            self.degreeLbl.isHidden = false
                            self.conditionLb.isHidden = false
                            self.cityLbl.isHidden = false
                            
                            self.degreeLbl.text = "\(self.degree.description)"
                            self.conditionLb.text = self.condition
                            self.cityLbl.text = self.city
                        }else{
                            self.degreeLbl.isHidden = true
                            self.conditionLb.isHidden = true
                            self.cityLbl.text = "no matching city found"
                        }
                    }
                    
                }catch let jsonerror{
                    print(jsonerror.localizedDescription)
                }
            }
        }
        
        task.resume();
        
    }
    

}

