//
//  pokemon.swift
//  pokedex
//
//  Created by Pawan on 2016-02-01.
//  Copyright © 2016 Pawan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    //MARK: - Properties
    
    private var _name: String!
    private var _PokeId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolution: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonURL: String!
    private var _nextEvolutionId: String!
    
    var PokeId:Int {
        get{
            return _PokeId
        }
    }
    var name:String {
        return _name
    }
    var description: String{
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    var height: String{
        if _height == nil{
            _height = nil
        }
        return _height
    }
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    var attack: String{
        if _attack == nil{
            _attack = nil
        }
        return _attack
    }
    var nextEvolution: String{
        if _nextEvolution == nil{
            _nextEvolution = ""
        }
        return _nextEvolution
    }
    var nextEvolutionLvl: String{
        if _nextEvolutionLvl == nil{
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    var nextEvolutionId: String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    
    //MARK: - Init
    
    init(name:String,PokeId:Int){
        self._name = name
        self._PokeId = PokeId
        
        _pokemonURL = URL_BASE + URL_POKEMON + "\(PokeId)/"
    }
    
    
    func downloadPokemonDetails(completed: DownloadComplete){
        
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, url).responseJSON{ Response in
            let result = Response.result
            
            //converting JSON into a dictionary
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                //use if lets so app doesnt crash
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                //"where" -> condition
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0{
                    
                    if let type1 = types[0]["name"]{
                        self._type = type1.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name)".capitalizedString
                            }
                        }
                    }
                    
                }else{
                    self._type = ""
                    
                }
                if let pokemonDescription = dict["descriptions"] as? [Dictionary<String, String>] where pokemonDescription.count > 0{
                    
                    if let url = pokemonDescription[0]["resource_uri"]{
                        let nsurl = NSURL(string: URL_BASE + url)!
                        Alamofire.request(.GET, nsurl).responseJSON{ Response in
                            
                            let result = Response.result
                            
                            if let descArr = result.value as? Dictionary<String, AnyObject> {
                                
                                if let pokeDescription = descArr["description"] as? String{
                                    self._description = pokeDescription.stringByReplacingOccurrencesOfString("POKMON", withString: "pokemon")
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                    }
                    
                }else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                    
                    if let to = evolutions[0]["to"] as? String{
                        
                        //if its nil it means it wasnt found
                        //will support mega evolutions later
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"]{
                                
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                if num != ""{
                                        self._nextEvolutionId = num
                                    }else{
                                        self._nextEvolutionId = ""
                                }
                                
                                self._nextEvolution = to
                                
                                if let level = evolutions[0]["level"] {
                                    self._nextEvolutionLvl = "\(level)"
                                    
                                }
                                
                            }
                        }
                    }
                    
                }
              
            }
            
        }
    }
}