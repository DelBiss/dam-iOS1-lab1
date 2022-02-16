//
//  ViewController.swift
//  teki-story
//
//  Created by Philippe Allard-Rousse (Étudiant) on 2022-02-16.
//

import UIKit

class ViewController: UIViewController {

    let celebrities = ["le Steve Jobs", "le Zinedine Zidane", "la Madonna", "le Karl Lagarfeld", "la Scarlett Johansson"]
    let activities = ["du dancefloor", "du barbecue", "de la surprise ratée", "des blagues lourdes", "de la raclette party"]
    @IBOutlet weak var quoteLabel: UILabel!

    @IBAction func changeQuote() {
        let celebrity = celebrities[Int(arc4random_uniform(UInt32(celebrities.count)))]
        let activity = activities[Int(arc4random_uniform(UInt32(activities.count)))]
        print("Youpi ! Notre action fonctionne parfaitement !")
        
        quoteLabel.text = "Tu es " + celebrity + " " + activity
    }
    

}

