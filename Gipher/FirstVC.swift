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

class FirstVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - VARIABLES & CONSTANTES
    @IBOutlet weak var tableView: UITableView!
    var gifs = [Gif]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    //MARK : FONCTIONS DE LA VUES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        // Initialisation pour le JSON
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

    //MARK: FONCTIONS DE LA TABLEVIEW
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
}

