//
//  ViewController.swift
//  Gipher
//
//  Created by etudiant-06 on 20/03/2017.
//  Copyright © 2017 Mehdi Chennoufi. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SwiftyJSON
import Alamofire

class FirstVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - VARIABLES & CONSTANTES
    @IBOutlet weak var tableView: UITableView!
    var gifs = [Gif]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - FONCTIONS DE LA VUES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Appel des Trendings sur Giphy
        retrieveTrendingsFromGiphy()
    }
    
    //MARK: - FONCTIONS DE LA TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    // Personnalisation de la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gifToDisplay = gifs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "gifCell") as! GifCell
        cell.slugLabel.text = gifToDisplay.slug
        cell.ratingLabel.text = gifToDisplay.rating
        //cell.linkLabel.text = gifToDisplay.link
        
        return cell
    }
    
    // Transition vers la Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toView", sender: self)
    }
    
    //MARK: - SEGUES
    
    // Preparation de la Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toView" {
            if let destinationVC = segue.destination as? SecondVC {
                if let row = self.tableView.indexPathForSelectedRow?.row {
                    let gif = self.gifs[row]
                    
                    destinationVC.gif = gif
                }
            }
        }
    }
    
    //MARK: - FONCTIONS SUR LA SEARCHBAR
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil || searchBar.text != ""{
            
            let pathToSearch = searchBar.text!.lowercased()
            retrieveSearchFromGiphy(pathToSearch: pathToSearch)
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            // Méthode pour faire disparaitre le clavier lorsque je "clear" la searchBar via la petite croix
            perform(#selector(self.hideKeyboardWithSearchBar), with: searchBar, afterDelay: 0)
            
            // Je vide le tableau actuel (qui contient ma recherche) et je re-fait mon appel réseau initial (trendings)
            self.gifs.removeAll()
            retrieveTrendingsFromGiphy()
        }
    }
    
    //MARK: - AUTRES FONCTIONS DU PROGRAMME
    
    func hideKeyboardWithSearchBar(bar: UISearchBar) {
        bar.resignFirstResponder()
    }
    
    // Recherche des Trendings sur Giphy
    func retrieveTrendingsFromGiphy() {
        NetworkManager.sharedInstance.getInfo { (json: JSON?, error: Error?) in
            guard error == nil else {
                return
            }
            
            if let json = json {
                let jsonArray = json["data"].arrayValue
                for element in jsonArray {
                    let currentElement = Gif(json: element)
                    self.gifs.append(currentElement)
                }
                print("Received data : \(json)")
            }
        }
    }
    
    // Recherche de l'utilisateur sur Giphy
    func retrieveSearchFromGiphy(pathToSearch: String) {
        NetworkManager.sharedInstance.getInfoWithPath(path: pathToSearch, completion: { (json: JSON?, error: Error?) in
            guard error == nil else {
                print("error occurs")
                return
            }
            //Vidage du tableau chargé initialement
            self.gifs.removeAll()
            //Réalimentation du tableau avec la recherche
            if let json = json {
                let jsonArray = json["data"].arrayValue
                for element in jsonArray {
                    let currentElement = Gif(json: element)
                    self.gifs.append(currentElement)
                    self.view.endEditing(true)
                }
                print("Received data : \(json)")
            }
        })
    }
}
