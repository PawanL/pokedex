//
//  ViewController.swift
//  pokedex
//
//  Created by Pawan on 2016-02-01.
//  Copyright © 2016 Pawan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
        //Empty array with a dictionary inside
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var audioPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        parseCSV()
        initAudio()
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
    
    func initAudio() {
        
        let path = NSBundle.mainBundle().pathForResource("pokemonTheme", ofType: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            //audioPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    //MARK: - CollectionView
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? PokemonCell{
            
            let pokemonCharacters: Pokemon!
            
            if inSearchMode{
                pokemonCharacters = filteredPokemon[indexPath.row]
            }else{
                pokemonCharacters = pokemon[indexPath.row]
            }
            
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
        
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }
    
    //MARK:- Misc
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    @IBAction func playMusicBtn(sender: AnyObject) {
        
        if audioPlayer.playing {
            audioPlayer.stop()
        }else{
            audioPlayer.play()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
            
        }else{
            
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            //$0 is grabbing an element. Similiar to var pokemon = pokemon[23]
            //is a closure expression that will run for every element entered
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            
            collectionView.reloadData()
            
        }
    }

}

