//
//  GestionnaireDeFilm.swift
//  Labo02
//
//  Created by Meryem  Nafougui  on 2024-10-29.
//

import Foundation
import UIKit

class MovieDownloader {
    static let shared = MovieDownloader()
    
    private init(){}
    
    let apikey = "79e3bbf2"
    func fetchFilms(for imdbID: String , completion: @escaping (FilmSchema?) -> Void) {
        let urlRef = "https://www.omdbapi.com/?apikey=79e3bbf2&i=\(imdbID)"
        guard let url = URL(string: urlRef) else{
            print("Invalid URL: \(urlRef)")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print ("Error: \(error)")
            }else if let data = data {
                let decoder = JSONDecoder()
                do{
                    let film = try decoder.decode(FilmSchema.self, from: data)
                    DispatchQueue.main.async{
                        completion(film)
                    }
                }catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
        task.resume()
        
    }
        
}
class WordDownloader {
    static let shared = WordDownloader()

    private init() {}

    func fetchRandomWord(completion: @escaping (String?) -> Void) {
        let urlRef = "https://random-word-api.herokuapp.com/word"
        guard let url = URL(string: urlRef) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                if let words = try JSONSerialization.jsonObject(with: data) as? [String], let word = words.first {
                    DispatchQueue.main.async {
                        completion(word)
                    }
                } else {
                    print("Invalid response format")
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
