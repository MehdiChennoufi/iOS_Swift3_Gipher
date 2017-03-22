//
//  SecondVC.swift
//  Gipher
//
//  Created by etudiant-06 on 20/03/2017.
//  Copyright © 2017 Mehdi Chennoufi. All rights reserved.
//

import UIKit
import FLAnimatedImage

class SecondVC: UIViewController {

    //MARK: - VARIBALES ET CONSTANTES
    
    var gif: Gif!

    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var spiningWheel: UIActivityIndicatorView!

    //MARK: - FONCTIONS DE LA VUE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingLabel.isHidden = false
        self.spiningWheel.isHidden = false
        self.spiningWheel.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: URL(string: self.gif.link)!)
                
                DispatchQueue.main.async {
                    let image = FLAnimatedImage(animatedGIFData: data)
                    let fAnimatedImage = FLAnimatedImageView()
                    
                    fAnimatedImage.animatedImage = image
                    fAnimatedImage.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.00)
                    fAnimatedImage.center = self.view.center
                    
                    self.loadingLabel.isHidden = true
                    self.spiningWheel.stopAnimating()
                    self.spiningWheel.isHidden = true
                    
                    self.view.addSubview(fAnimatedImage)
                }
            }
            catch {
                print("error could not load data")
            }
        }
    }
}
