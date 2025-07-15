//
//  predeatorMap.swift
//  Jurassic World Simulator
//
//  Created by Gourav  on 14/07/25.
//

import SwiftUI
import MapKit


struct predeatorMap: View {
    
    //import the predeator() file
    let predeator = Predeator()
    
    //state variable make
    //map check the state view which design
    @State var position: MapCameraPosition
    @State var satelight = false
    
    
    var body: some View {
        
        //variable ko call kiya h bs
        Map(position: $position){
            //forEach loop lgyaa predeator.apexpredeator
            ForEach(predeator.apexPredeator){ predeators in
                
                //anotation only pass the map functionality
                Annotation(predeators.name, coordinate: predeators.location) {
                    Image(predeators.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:150 )
                        .scaleEffect(x: -1)
                }
            }
        }
        //map ka view dekhne ke liye
        //condition state pass if else
        //turnarry oprater
        .mapStyle (satelight ? .imagery(elevation: .realistic): .standard(elevation : .realistic))
        
        .overlay(alignment : .bottomTrailing){
            Button{
                satelight.toggle()
            } label : {
                Image(systemName :satelight ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .padding(5)
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //pass bs cordinates and values
    predeatorMap(position:.camera(MapCamera(centerCoordinate: Predeator().apexPredeator[2].location, distance: 1000, heading: 250, pitch: 80)))
        .preferredColorScheme(.dark)
}
