//
//  ViewController.swift
//  Pokemon
//
//  Created by Emily Baker-King on 10/23/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet weak var pokemonInfoLabel: UILabel!
    @IBOutlet weak var pokemonInfoText: UITextView!
    @IBOutlet weak var textField: UITextField!
    
    var abilities = ""
    var typeOfPokemon = ""
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pokemonInfoText.isHidden = true
        pokemonInfoLabel.isHidden = true
    }

    
    @IBAction func buttonClicked(_ sender: Any) {
        
        guard let pokemonNameOrID = textField.text else {
            return
        }
        
        //URL that we will use for our request
        let requestURL = baseURL + pokemonNameOrID.lowercased().replacingOccurrences(of: " ", with: "+") + "/"
        
        //making our request
        let request = Alamofire.request(requestURL)
        
        //carry out our request
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let speciesName = json["species"]["name"].string {
                    print(speciesName)
                }
                
                if let abilitiesJSON = json["abilities"].array {
                    
                    for ability in abilitiesJSON {
                        if let abilityName = ability["ability"]["name"].string {
                            print(abilityName)
                            self.abilities += abilityName
                        }
                    }
                }
                
                if let typeJSON = json["types"].array {
                    for type in typeJSON {
                        if let types = type["type"]["name"].string {
                            print(types)
                            self.typeOfPokemon += "\(types) \n"
                        }
                    }
                }
                
                var pokemonInfo = ""
                pokemonInfo += "species: \n \(json["species"]["name"].stringValue) \n \n"
                pokemonInfo += "Ability: \n \(self.abilities) \n \n"
                pokemonInfo += "type: \n \(self.typeOfPokemon) "
                
                self.pokemonInfoText.text = pokemonInfo
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        pokemonInfoLabel.isHidden = false
        pokemonInfoText.isHidden = false
        
    }
    

}

