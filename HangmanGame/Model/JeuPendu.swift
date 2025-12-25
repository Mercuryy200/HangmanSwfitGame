//
//  JeuPendu.swift
//  Labo02
//
//  Created by Meryem  Nafougui  on 2024-10-29.
//

import Foundation

class JeuPendu {
    let maxErreur = imageNameSequence.count - 1
    var essai = 0
    var titre : String
    var lettreUtilisee = [Character]()
    var lettres = [Character]()
    
    init(mot : String){
        self.titre = mot
    }
    func dansTitre(_ letter: Character) -> Bool {
        let lettreMajuscule = Character(letter.uppercased())
        let motMajuscule = titre.uppercased()
        if( motMajuscule.contains(lettreMajuscule)){
             lettreUtilisee.append(letter)
            if (!lettres.contains(lettreMajuscule)){
                lettres.append(lettreMajuscule)
            }
             return true
         } else {
             lettres.append(lettreMajuscule)
             essai += 1
             return false
         }
        
    }
    
    func gameOver() -> Bool{
        return essai >= maxErreur || motDevinee()
    }
    
    
    func motDevinee() -> Bool {
        let lowercasedLettresUtilisees = lettreUtilisee.map { $0.lowercased() }

        return titre.lowercased().allSatisfy { $0 == " " || lowercasedLettresUtilisees.contains(String($0)) }
    }

}
