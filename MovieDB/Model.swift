//
//  Model.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 09/03/21.
//

import Foundation

struct MovieModel: Decodable {
    let results: [Movies]
}

struct Movies: Decodable {
    let backdrop_path: String?
    let poster_path: String?
    let release_date:String
    let id: Int
    let title: String
    let overview: String
}
