//
//  pokemon.swift
//  pokedex
//
//  Created by Pawan on 2016-02-01.
//  Copyright © 2016 Pawan. All rights reserved.
//

import Foundation

class Pokemon {
    
    //MARK: - Properties
    
    private var _name: String!
    private var _PokeId: Int!
    
    var name:String {
        return _name
    }
    
    var PokeId:Int {
        get{
            return _PokeId
        }
    }
    
    //MARK: - Init
    
    init(name:String,PokeId:Int){
        self._name = name
        self._PokeId = PokeId
    }
    
}