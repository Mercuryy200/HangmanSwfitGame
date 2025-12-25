//
//  ViewController.swift
//  Labo02
//
//  Created by Rima  Nafougui  on 2024-10-22.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    //outlets
   
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var btnValider: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelLettre: UILabel!

    
    //var
    var jeuPendu: JeuPendu?
    var iPadLabel: UILabel?
    let defaults = UserDefaults.standard
    var filmReceived: FilmSchema?   // <-- added

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
                   ajoutLabelIpad()
               }
        startNewGame()
    }
    
    func startNewGame() {
        image.image = UIImage(named: "0_echafaud")
        textInput.text = ""
        WordDownloader.shared.fetchRandomWord { word in
                guard let word = word else {
                    print("Error: Unable to fetch word")
                    return
                }
                
                DispatchQueue.main.async {
                    print("New Random Word: \(word)")
                    self.jeuPendu = JeuPendu(mot: word)
                    self.defaults.set(word, forKey: "Titre")
                    
                    self.updateUI()
                }
            }
    }
    
    
    @IBAction func submitLetter(){
        guard let letter = textInput.text?.first else { return }
        if let jeuPendu = jeuPendu {
            let isCorrect = jeuPendu.dansTitre(Character(letter.lowercased()))
            updateUI()
            checkGameOver(isCorrect: isCorrect)
        }
    }
    
    func updateUI() {
        guard let jeuPendu = jeuPendu else { return }
        movieName.text = formatWordDisplay()
        labelLettre.text = "Lettres utilisées : \(jeuPendu.lettres)"
        labelError.text = "Erreurs : \(jeuPendu.essai)"
        image.image = UIImage(named: imageNameSequence[jeuPendu.essai])
    }
    
    func formatWordDisplay() -> String {
        guard let jeuPendu = jeuPendu else { return "" }
        return jeuPendu.titre.map {
            !"abcdefghijklmnopqrstuvwxyz".contains($0.lowercased()) ? String($0) : (jeuPendu.lettres.contains($0.uppercased()) ? String($0) : "_")
        }.joined(separator: " ")
    }


    func checkGameOver(isCorrect: Bool) {
        guard let jeuPendu = jeuPendu else { return }
        
        if jeuPendu.gameOver() {
            let alert = UIAlertController(
                title: jeuPendu.motDevinee() ? "Gagné !" : "Perdu !",
                message: jeuPendu.motDevinee() ? "Bravo !" : "Le mot était : \(jeuPendu.titre)",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Nouvelle Partie", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            })
            
            present(alert, animated: true)
        }
    }
    
    func ajoutLabelIpad(){
        let label = UILabel()
        label.text = "Version iPad"
        view.addSubview(label)
        iPadLabel = label
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
                    label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ])
    }
    
}
