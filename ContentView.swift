//
//  ContentView.swift
//  Jurassic World Simulator
//
//  Created by Gourav  on 07/07/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    //import predator file
    let predeator = Predeator()
    
    //serach ke liye state
    @State var searchText = ""
    @State var alphabatical = false
    @State var currentIcon = APType.all
    
    var filterdDinoz : [ApexPredator] {
        //pass the filter function
        predeator.filter(by: currentIcon)
        
        //sort function work alphabatical or not
        predeator.sort(by: alphabatical)
        
        // now i have to do some conditions to work which one show i want
        if searchText.isEmpty{
            return predeator.apexPredeator
        }
        else {
            return predeator.apexPredeator.filter{ predeator in
                predeator.name.localizedCaseInsensitiveContains(searchText)
                
            }
        }
    }
    
    
    
    
    var body: some View {
        //navStack ka use as a sheet work krta h
        //pass also navLink and label
        //sara data label me pass hota h
        
        NavigationStack{
            
            VStack {
                HStack{
                    List(filterdDinoz) {predeator in
                        
                        //navigationLink use
                        // use like a button
                        
                        //also import MapKit in NavLink
                        //import the predeator value
                        NavigationLink{
                            predeatorDetails(predeator: predeator, position: .camera(MapCamera(centerCoordinate: predeator.location, distance: 30000)) )
                        } label: {
                            
                            HStack{
                                // image insert
                                //switch use nhi kr skta bhot sari image h
                                // image ko acess krne ke liye apexPredeator me name ke according string me
                                
                                Image(predeator.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .shadow(color: .white, radius: 1)
                                
                                VStack(alignment:.leading){
                                    //text insert
                                    Text(predeator.name)
                                        .fontWeight(.bold)
                                    //pass rawValue original vlaue name in json data
                                    Text(predeator.type.rawValue)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal,14)
                                        .padding(.vertical,5)
                                        .background(predeator.type.background)
                                        .clipShape(.capsule)
                                    
                                }
                                
                            }
                            
                        }
                    }
                }
            }
            .padding()
            .preferredColorScheme(.dark)
            .navigationTitle("Jurassic World")
            .searchable(text: $searchText)
            .animation(.default , value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        alphabatical.toggle()
                    } label:{
                        if alphabatical{
                            Image(systemName: "film")
                        }
                        else {
                            Image(systemName: "textformat")
                        }
                    }
                }
                
                ToolbarItem(placement : .topBarTrailing){
                    //use menu beacuse it is a clickable and show functionality
                    Menu{
                        
                        //use picker is use like button to open
                        //choice values type data
                        //pass the switch case to show icones
                        //use Label to show the icons rawValue
                        //selection kom currrentIcon s bind krna
                       // forEach pr ase
                        Picker("Filter", selection:$currentIcon.animation()){
                            ForEach(APType.allCases){
                                type in
                                Label(type.rawValue.capitalized,
                                      //icon jisme sari logo store ho rhe  h
                                      systemImage: type.icon)
                            }
                        }
                        
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
            }
            
            
        } 
    }
}

#Preview {
    ContentView()
}
