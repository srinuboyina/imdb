//
//  Genres.swift
//  imdb
//
//  Created by apple on 19/10/22.
//

import Foundation

struct Movie: Codable {
    var rating: Double
    var id: Int
    var revenue: Double? = 0
    var releaseDate: String
    var director: Director
    var posterUrl: String
    var cast: [Actor]
    var runtime: Int
    var title: String
    var overview: String
    var reviews: Int
    var budget: Double
    var language: String
    var genres: [String]
    var favourite: Bool? = false
    
    var year: String {
        return "(\(releaseDate.substring(to: 4)))"
    }
    
    var date: String {
        let temp = releaseDate.components(separatedBy: "-")
        var title = ""
        for i in 0..<temp.count {
            let t = temp[temp.count - i - 1]
            title += t
            if (i != temp.count - 1) {
                title += "."
            }
        }
        return title
    }
    
    var time: String {
        let hours = runtime/60
        let minutes = runtime%60
        return "\(hours)h \(minutes)m"
    }
    
    var dateAndTime: String {
        return "\(date)  .  \(time)"
    }
    
    var originalLanguage: String {
        return "English"
    }
    
    var ratingValue: String {
        return String(format: "%.2f", rating)
    }
}
