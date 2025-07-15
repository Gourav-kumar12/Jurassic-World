//
//  ApexPredeator.swift
//  Jurassic World Simulator
//
//  Created by Gourav  on 07/07/25.
//

//create struct mean structure of application convert in json data
// this is a inisilizter of the data in my json file / data
import SwiftUI
import MapKit

struct ApexPredator : Decodable, Identifiable {
    let id : Int
    let name : String
    let type : APType
    let latitude : Double
    let longitude : Double
    let movies : [String]
    let movieScenes : [MovieScene]
    let link : String
    
    //name ke according image ko lagane ke liye ..
    var image : String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    //location mapkit
    //store krwana pdega na
    var location :CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
     
    //dinasour ki movies ka array
    struct MovieScene : Decodable, Identifiable {
        let id : Int
        let movie : String
        let sceneDescription : String
    }
    //enum create to get right land ,sea , air type
    
    
}
//menditory fill the libaray key words
enum APType : String, Decodable,Identifiable, CaseIterable {
    case all
    case land
    case sea
    case air
    
    //identifiable ka use krne ke liye
    var id : APType{
        self
    }
    
    var background : Color {
        switch self {
        case .all:
                .gray
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        }
    }
    //switch case for icon filter
    var icon : String {
        
        switch self{
        case .all:
            ""
        case .land:
                "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
    
}
