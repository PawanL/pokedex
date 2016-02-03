//
//  ViewController.swift
//  pokedex
//
//  Created by Pawan on 2016-02-01.
//  Copyright © 2016 Pawan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Empty array with a dictionary inside
    var pokemon = [Pokemon]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        parseCSV()
    }

    func parseCSV (){
        //similiar to audio files
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            //parse through the rows and put them into an array
            for row in rows{
                let PokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let pokemonCharacter = Pokemon(name: name, PokeId: PokeId)
                pokemon.append(pokemonCharacter)
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    //MARK: - CollectionView
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? PokemonCell{
            
            let pokemonCharacters = pokemon[indexPath.row]
            cell.cellContent(pokemonCharacters)
            return cell
            
        }else{
            //precaution if data doesnt appear
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }
    
    //MARK:- Misc
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

