//
//  ContentView.swift
//  Sensor-App
//
//  Created by Volker Schmitt on 13.09.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Struct
struct ContentView: View {
    
    // MARK: - Initialize Classes
    
    
    // MARK: - @State Variables
    @State var showSettings = false
    
    
    // MARK: - Define Constants / Variables
    
    
    // MARK: - Methods
    
    
    // MARK: - Body
    var body: some View {
        
        // MARK: - Return View
        return NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: SettingsAPI.shared.backgroundColor), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                GeometryReader { g in
                    ScrollView {
                        VStack {
                            Spacer()
                            Group {
                                Text("Welcome to the \n Sensor-App")
                                    .modifier(ContentViewTitleModifier())
                            }
                            .frame(height: 100, alignment: .center)
                            Group {
                                NavigationLink(destination: LocationView()) {
                                    Text("Location")
                                        .modifier(ContentViewButtonModifier())
                                }
                                NavigationLink(destination: AccelerationView()) {
                                    Text("Acceleration")
                                        .modifier(ContentViewButtonModifier())
                                }
                                NavigationLink(destination: GravityView()) {
                                    Text("Gravity")
                                        .modifier(ContentViewButtonModifier())
                                }
                                NavigationLink(destination: GyroscopeView()) {
                                    Text("Gyroscope")
                                        .modifier(ContentViewButtonModifier())
                                }
                            }
                            .frame(height: 50, alignment: .center)
                            Group {
                                NavigationLink(destination: MagnetometerView()) {
                                    Text("Magnetometer")
                                        .modifier(ContentViewButtonModifier())
                                }
                                NavigationLink(destination: AttitudeView()) {
                                    Text("Attitude")
                                        .modifier(ContentViewButtonModifier())
                                }
                                NavigationLink(destination: AltitudeView()) {
                                    Text("Altitude")
                                        .modifier(ContentViewButtonModifier())
                                }
                                Button(action: { self.showSettings.toggle() }) {
                                    Text("Settings")
                                        .modifier(ContentViewButtonModifier())
                                }
                            }
                            .frame(height: 50, alignment: .center)
                        }
                        .navigationBarTitle("Home", displayMode: .inline)
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $showSettings) { SettingsView() }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewDevice("iPhone 11 Pro")
            ContentView().previewDevice("iPhone 11 Pro")
                .environment(\.colorScheme, .dark)
            //ContentView().previewDevice("iPad Pro (12.9-inch) (3rd generation)")
            //ContentView().previewDevice("iPad Pro (12.9-inch) (3rd generation)")
            //.environment(\.colorScheme, .dark)
        }
    }
}