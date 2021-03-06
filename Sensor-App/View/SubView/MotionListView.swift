//
//  MotionListView.swift
//  Sensor-App
//
//  Created by Volker Schmitt on 13.10.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Struct
struct MotionListView: View {
    
    // MARK: - Initialize Classes
    let calculationAPI = CalculationAPI()
    let settings = SettingsAPI()
    
    // MARK: - @State / @ObservedObject / @Binding
    @State var type: SensorType
    @ObservedObject var motionVM = CoreMotionViewModel()
    
    
    // MARK: - Define Constants / Variables
    
    
    // MARK: - Methods
    
    
    // MARK: - Body - View
    var body: some View {
        
        
        // MARK: - Return View
        if type == .acceleration {
            return GeometryReader { g in
                AnyView(
                    List(self.motionVM.coreMotionArray.reversed(), id: \.counter) { index in
                        HStack{
                            Text("ID:\(self.motionVM.coreMotionArray[index.counter - 1].counter)")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("X:\(self.motionVM.coreMotionArray[index.counter - 1].accelerationXAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Y:\(self.motionVM.coreMotionArray[index.counter - 1].accelerationYAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Z:\(self.motionVM.coreMotionArray[index.counter - 1].accelerationZAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                        }
                        .font(.footnote)
                        //.background(Color("ListBackgroundColor"))
                    }
                    .id(UUID())
                    .frame(width: g.size.width - 10)
                    .cornerRadius(10)
                    .opacity(0.3)
                )
            }
        } else if  type == .gravity {
            return GeometryReader { g in
                AnyView(
                    List(self.motionVM.coreMotionArray.reversed(), id: \.counter) { index in
                        HStack{
                            Text("ID:\(self.motionVM.coreMotionArray[index.counter - 1].counter)")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("X:\(self.motionVM.coreMotionArray[index.counter - 1].gravityXAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Y:\(self.motionVM.coreMotionArray[index.counter - 1].gravityYAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Z:\(self.motionVM.coreMotionArray[index.counter - 1].gravityZAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                        }
                        .font(.footnote)
                        //.background(Color("ListBackgroundColor"))
                    }
                    .id(UUID())
                    .frame(width: g.size.width - 10)
                    .cornerRadius(10)
                    .opacity(0.3)
                )
            }
        } else if type == .gyroscope {
            return GeometryReader { g in
                AnyView(
                    List(self.motionVM.coreMotionArray.reversed(), id: \.counter) { index in
                        HStack{
                            Text("ID:\(self.motionVM.coreMotionArray[index.counter - 1].counter)")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("X:\(self.motionVM.coreMotionArray[index.counter - 1].gyroXAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Y:\(self.motionVM.coreMotionArray[index.counter - 1].gyroYAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Z:\(self.motionVM.coreMotionArray[index.counter - 1].gyroZAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                        }
                        .font(.footnote)
                        //.background(Color("ListBackgroundColor"))
                    }
                    .id(UUID())
                    .frame(width: g.size.width - 10)
                    .cornerRadius(10)
                    .opacity(0.3)
                )
            }
        } else if type == .magnetometer {
            return GeometryReader { g in
                AnyView(
                    List(self.motionVM.coreMotionArray.reversed(), id: \.counter) { index in
                        HStack{
                            Text("ID:\(self.motionVM.coreMotionArray[index.counter - 1].counter)")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("X:\(self.motionVM.coreMotionArray[index.counter - 1].magnetometerXAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Y:\(self.motionVM.coreMotionArray[index.counter - 1].magnetometerYAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Z:\(self.motionVM.coreMotionArray[index.counter - 1].magnetometerZAxis, specifier: "%.5f")")
                                .foregroundColor(Color("ListTextColor"))
                        }
                        .font(.footnote)
                        //.background(Color("ListBackgroundColor"))
                    }
                    .id(UUID())
                    .frame(width: g.size.width - 10)
                    .cornerRadius(10)
                    .opacity(0.3)
                )
            }
        } else if type == .attitude {
            return GeometryReader { g in
                AnyView(
                    List(self.motionVM.coreMotionArray.reversed(), id: \.counter) { index in
                        HStack{
                            Text("ID:\(self.motionVM.coreMotionArray[index.counter - 1].counter)")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("R:\(self.motionVM.coreMotionArray[index.counter - 1].attitudeRoll * 180 / .pi, specifier: "%.3f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("P:\(self.motionVM.coreMotionArray[index.counter - 1].attitudePitch * 180 / .pi, specifier: "%.3f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("Y:\(self.motionVM.coreMotionArray[index.counter - 1].attitudeYaw * 180 / .pi, specifier: "%.3f")")
                                .foregroundColor(Color("ListTextColor"))
                            Spacer()
                            Text("H:\(self.motionVM.coreMotionArray[index.counter - 1].attitudeHeading, specifier: "%.3f")")
                                .foregroundColor(Color("ListTextColor"))
                        }
                        .font(.footnote)
                        //.background(Color("ListBackgroundColor"))
                    }
                    .id(UUID())
                    .frame(width: g.size.width - 10)
                    .cornerRadius(10)
                    .opacity(0.3)
                )
            }
        } else if type == .altitude {
            return GeometryReader { g in
                AnyView(
                    List(self.motionVM.altitudeArray.reversed(), id: \.counter) { index in
                        HStack{
                            Text("ID:\(self.motionVM.altitudeArray[index.counter - 1].counter)")
                            Spacer()
                            Text("P:\(self.calculationAPI.calculatePressure(pressure: self.motionVM.altitudeArray[index.counter - 1].pressureValue, to: self.settings.fetchUserSettings().pressureSetting), specifier: "%.5f")")
                            Spacer()
                            Text("A:\(self.calculationAPI.calculateHeight(height: self.motionVM.altitudeArray[index.counter - 1].relativeAltitudeValue, to: self.settings.fetchUserSettings().altitudeHeightSetting), specifier: "%.5f")")
                        }
                        .foregroundColor(Color("ListTextColor"))
                        .font(.footnote)
                    }
                    .id(UUID())
                    .frame(width: g.size.width - 10)
                    .cornerRadius(10)
                    .opacity(0.3)
                )
            }
        } else {
            return GeometryReader { g in
                AnyView(
                    Text("Could not load the table!")
                )
            }
        }
    }
}


// MARK: - Preview
struct MotionListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            MotionListView(type: .acceleration)
                .colorScheme(scheme)
                .previewLayout(.sizeThatFits)
        }
    }
}
