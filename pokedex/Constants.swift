//
//  Constants.swift
//  pokedex
//
//  Created by Pawan on 2016-02-04.
//  Copyright © 2016 Pawan. All rights reserved.
//

import Foundation

//MARK: - Variables
let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"

//closure created so data has time to download before view pops up 
typealias DownloadComplete = () -> ()