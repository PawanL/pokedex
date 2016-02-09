//
//  PokemonCell.swift
//  pokedex
//
//  Created by Pawan on 2016-02-01.
//  Copyright © 2016 Pawan. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
 
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func cellContent (pokemon:Pokemon){
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbnailImage.image = UIImage(named: "\(self.pokemon.PokeId)")
    
    }
    override func awakeFromNib() {
        
        thumbnailImage.layer.cornerRadius = 10
        thumbnailImage.clipsToBounds = true
    }
    
}
