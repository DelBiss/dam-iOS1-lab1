//
//  ViewController.swift
//  teki-story
//
//  Created by Philippe Allard-Rousse (Étudiant) on 2022-02-16.
//

import UIKit


//Extention pour coloré la string
//source: StackOverflow: https://stackoverflow.com/a/46786438
extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}

func randomIndex(max:Int) -> Int {
    return Int(arc4random_uniform(UInt32(max)))
}
func randomFloat()->CGFloat{
    return CGFloat(CGFloat(arc4random_uniform(100))/100.0)
}

func randomColor()->UIColor{
    return UIColor(red: randomFloat(), green: randomFloat(), blue: randomFloat(), alpha: 1)
}

//Classe qui gere les liste aléatoire
//Prend note aussi des terme qui ont été utilisé
class RandomList  {
    let list:[String]
    var picked:[Bool]
    var current:String
    
    init(_ list:[String]) {
        self.current = ""
        self.list = list
        self.picked = Array(repeating: false, count: self.list.count)
    }
    
    func get(new:Bool = true)->String{
        //Si aucun mots n'a été généré, ont en gener un malgré la demande de ne pas en faire
        if(new || (self.current=="")){
            let index = randomIndex(max: list.count)
            self.picked[index] = true
            self.current = list[index]
        }
        return self.current
    }
    
    func allPicked()->Bool{
        return self.picked.allSatisfy({$0})
    }
}

class ViewController: UIViewController {

    let actors : RandomList = RandomList([
        "John Doe",
        "Claude",
        "Peter Black",
        "Scarlet Messagegalnil"
    ])
    
    let part1 : RandomList = RandomList([
        "Les jardins",
        "La cité",
        "L'univers",
        "La maison hantée",
        "Ahuntsic"
    ])
    
    let part2 : RandomList = RandomList([
        "en suspens",
        "dans le ciel",
        "RECHARGÉE",
        "volume 2",
        "!",
        "CENSURÉ"
    ])
    
    let lien:String = "avec en vedette:"

    let randomFont: RandomList = RandomList([
        "Georgia",
        "Palatino",
        "Rockwell"
    ])

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var btnNewMovie: UIButton!
    @IBOutlet weak var page: UIView!
    @IBOutlet weak var ActorOnly: UISwitch!
    
    @IBAction func changeQuote() {
        
        //genere le texte
        let text = """
\(part1.get(new: !ActorOnly.isOn)) \(part2.get(new: !ActorOnly.isOn))
\(lien)
\(actors.get())
"""
        //Change la couleur du bouton en fonction de l'état de la liste
        btnNewMovie.backgroundColor = (part1.allPicked() && part2.allPicked() && actors.allPicked()) ? UIColor(named: "ButtonColorAllUsed") : UIColor(named: "ButtonColor")
        
        //Donne une police aléatoire
        quoteLabel.font = UIFont(name: randomFont.get(), size: quoteLabel.font.pointSize)
        
        //Couleur de fond alétatoir
        page.backgroundColor = randomColor()
        
        //Texte de couleur aléatoire
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedString.setColorForText(textForAttribute: part1.current, withColor: randomColor())
        attributedString.setColorForText(textForAttribute: part2.current, withColor: randomColor())
        attributedString.setColorForText(textForAttribute: actors.current, withColor: randomColor())
        
        quoteLabel.attributedText = attributedString
    }
    
    
}

