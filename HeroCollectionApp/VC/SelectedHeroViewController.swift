//
//  SelectedHeroViewController.swift
//  HeroCollectionApp
//
//  Created by Юлия Алдохина on 03/08/22.
//

import UIKit

class SelectedHeroViewController: UIViewController {
    
    @IBOutlet var heroImageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroImageView.image = image
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
        
    }
}
