//
//  Predeator.swift
//  Jurassic World Simulator
//
//  Created by Gourav  on 07/07/25.
//

//import basic foundation

import Foundation

class Predeator {
    //all name se variabke bna kr show krwaye ge taki land and air ka data allPedeator se le sake
    var allApexPredators : [ApexPredator] = []
    //store the value
    var apexPredeator : [ApexPredator] = []
    
    //call the function
    init(){
        decodeApexPredator()
        
    }
    
    func decodeApexPredator() {
        //if codition check for more security // url check in my application url
        //using Bundle.main.url for check store the value
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            //more security ke liye swift me do and catch ka use krte h
            
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                //snakecase ko camalCase me convort kne ke liye code
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // apixPredator ke under value daali decode kr ke
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredeator = allApexPredators
                //yha apex predeator ka data aa jaye ga
            }
            catch{
                print("any error in predetor")
            }
        }
    }
    
    //sort buy alphabatical function create
    //sort hoga 2 value ke base pr
    func sort(by alphabatical : Bool){
        apexPredeator.sort{predeator1 ,predeator2 in
            
            //condition to check using sort
            if alphabatical {
                predeator1.name < predeator2.name
            }
            else {
                predeator1.id < predeator2.id
            }
        }
    }
    
    //pass the data by enum = APType
    func filter(by type : APType){
        if type == .all{
            apexPredeator = allApexPredators
        }
        else{
        
            apexPredeator =  allApexPredators.filter{ Predeator in
                //predeator ka jo type h land or vp same hona chaiye current type ke
                Predeator.type == type
            }
            
        }
    }
    
}


