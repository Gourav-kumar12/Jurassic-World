//
//  predeatorDetails.swift
//  Jurassic World Simulator
//
//  Created by Gourav  on 12/07/25.
//

import SwiftUI
import MapKit

struct predeatorDetails: View {
    
    //import apexPredeator
    // important part this is the ervery device to set the width and height use //GeomeryReader use this library function //
    let predeator : ApexPredator
    //mapKit state
    //asign the position value not declare
    @State var position : MapCameraPosition
    //zoom namespace pass
    @Namespace var namespace
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                 
                //right bottom use allignment
                ZStack(alignment:.bottomTrailing){
                    //first background image add
                    Image(predeator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay(LinearGradient(stops: [
                            Gradient.Stop(color: .clear, location: 0.8),
                            Gradient.Stop(color: .black, location: 1)

                        
                        ], startPoint: .top, endPoint: .bottom))
//                    
                    Image(predeator.image)
                        .resizable()
                        .scaledToFit()
                    //add geoReader
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.6)
                    //now give 3D effect
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 6)
                        .offset(y:20)
                }
                VStack(alignment: .leading){
                    
                    //titile  add
                    Text(predeator.name)
                        .font(.largeTitle)
                    
                    
                    //current location MapKit
                    //use NavigationLink pass kro taki new page open ho sake
                    //pase the predeatorMap preview property 
                    NavigationLink{
                        predeatorMap(position:.camera(MapCamera(centerCoordinate: predeator.location, distance: 1000, heading: 250, pitch: 80)))
                        
                        //destination animation passs paramter map open
                            .navigationTransition(.zoom(sourceID: 1, in:namespace ))
                            
                    } label: {
                        
                        Map(position: $position){
                            //annotation = In Swift, annotation usually refers to a marker or label on a map — like showing a location with a pin.
                            Annotation(predeator.name, coordinate: predeator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.bottom)
                        //page click  function work show
                        .overlay(alignment:.trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                        //page show current location
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .foregroundStyle(.white)
                                .background(.black.opacity(0.6))
                                .clipShape(.rect(cornerRadius: 12))
                                .padding(.trailing, 8)
                        }
                    }
                    
                    //pass the source paramter for animation map open
                    .matchedTransitionSource(id: 1, in: namespace)
                    //movies scense
                    Text("appears")
                        .font(.title3)
                    //array pass kr do forEach se movie scense ko
                    //movie ye variable h
                    ForEach(predeator.movies , id : \.self)
                    { movie in
                        Text("• " + movie)
                    }
                    //text ka discriptions
                    //scene is a variable pass
                    // movies array pass
                    Text("Movie Moments")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 4)
                    
                   //forEach loop
                    ForEach(predeator.movieScenes){
                        scene in
                        Text(scene.movie)
                            .font(.title3)
                            .padding(.vertical, 1)
                            .fontWeight(.semibold)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                        
                        
                        
                    }
                    //text link use
                    // ! use like provide its optional feature for security
                    Text("Read More ....")
                        .fontWeight(.semibold)
                    
                    Link(predeator.link, destination: URL(string: predeator.link)!)
                        .foregroundStyle(.blue)
                        
                    
                    
                    
                }
                .padding()
                .padding(.bottom)
               
                //descriptions add
                
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .toolbarBackground(.automatic)
    }
        
}

#Preview {
    //predeator me store krwa liya ..
    let predeator = Predeator().apexPredeator[7]
    
    predeatorDetails(predeator: predeator, position: .camera(MapCamera(centerCoordinate: predeator.location , distance: 30000)))
     
}

