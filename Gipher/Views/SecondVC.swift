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

    var gif: Gif!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: URL(string: self.gif.link)!)
                let image = FLAnimatedImage(animatedGIFData: data)
                let fAnimatedImage = FLAnimatedImageView()
                fAnimatedImage.animatedImage = image
                fAnimatedImage.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.00)
                fAnimatedImage.center = self.view.center
                self.view.addSubview(fAnimatedImage)
            }
            catch {
                print("error could not load data")
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
