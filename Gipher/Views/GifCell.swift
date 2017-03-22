//
//  GifCell.swift
//  Gipher
//
//  Created by etudiant-06 on 20/03/2017.
//  Copyright © 2017 Mehdi Chennoufi. All rights reserved.
//

import UIKit

class GifCell: UITableViewCell {

    //MARK: - VARIABLES ET CONSTANTES
    @IBOutlet weak var slugLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    //MARK: - FONCTIONS DE LA CELLULE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
