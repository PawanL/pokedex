//
//  DetailViewController.swift
//  pokedex
//
//  Created by Pawan on 2016-02-03.
//  Copyright © 2016 Pawan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvolution: UIImageView!
    @IBOutlet weak var nextEvolution: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!
    
    //MARK: - Variables
    var pokemon: Pokemon!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalizedString
        
        let img = UIImage(named: "\(pokemon.PokeId)")
        mainImage.image = img
        currentEvolution.image = img
        self.nextEvolution.hidden = true
        self.currentEvolution.hidden = true
        //called after download is done
        pokemon.downloadPokemonDetails { () -> () in
            
            self.updateUI()
        }
    }
    
    func updateUI(){
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexIdLabel.text = "\(pokemon.PokeId)"
        baseAttackLabel.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No evolutions"
            currentEvolution.hidden = true
            nextEvolution.hidden = true
        }else{
            currentEvolution.hidden = false
            nextEvolution.hidden = false
            nextEvolution.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: Lvl \(pokemon.nextEvolutionLvl) to \(pokemon.nextEvolution)"
            
            evolutionLabel.text = str
        }
        
    }
    

    //MARK: - Misc
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    

}
