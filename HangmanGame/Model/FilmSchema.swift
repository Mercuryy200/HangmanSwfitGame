//
//  FilmSchema.swift
//  Labo02
//
//  Created by Meryem  Nafougui  on 2024-10-29.
//

import Foundation

struct FilmSchema: Decodable{
    let imdbID: String
    let Title: String
    let Year: String
    let imdbRating: String
    let Genre: String
    let Director: String
    let Actors: String
}
