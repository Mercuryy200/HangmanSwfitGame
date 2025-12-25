//
//  IndiceController 2.swift
//  NAFr_2028472_labo03
//
//  Created by Rima Nafougui on 2024-12-09.
//

import UIKit

class IndiceController: UIViewController{
    @IBOutlet weak var lblIndices: UILabel!
    
    var isFirstLoad = true
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            nouveauFilm()
        }
    
    func nouveauFilm(){
        MovieDownloader.shared.fetchFilms(for: ListeDeFilmsData.randomElement()!){
            film in
            guard let film else{
                print("Error: Invalude Data")
                return
            }
            let defaults = UserDefaults.standard
            defaults.set(film.Title, forKey: "Titre")
            self.lblIndices.text = "Indices: \n Annee: \(film.Year) \n Genre: \(film.Genre) \n Rating: \(film.imdbRating) \n Acteurs: \(film.Actors) \n Realisateur: \(film.Director) "
            print("Film: \(film.Title) actors: \(film.Actors) genre: \(film.Genre) director: \(film.Director) year: \(film.Year) rating: \(film.imdbRating)")
            _ = FilmSchema(imdbID: film.imdbID, Title: film.Title, Year: film.Year, imdbRating: film.imdbRating, Genre: film.Genre, Director: film.Director, Actors: film.Actors)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToViewController"{
            guard let destinationVC = segue.destination as? ViewController else{
                print("destination is not ViewController")
                return
            }
            destinationVC.filmReceived = sender as? FilmSchema
        }
    }
}
