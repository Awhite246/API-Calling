//
//  ContentView.swift
//  API Calling
//
//  Created by Student on 2/3/22.
//
//https://community-open-weather-map.p.rapidapi.com/weather?q=Barrington,IL,US&units=imperial&rapidapi-key=cc6b0c5350msh5a3d7cf2c2a71fbp1bec8djsnecb6421d09a6

import SwiftUI

struct ContentView: View {
    @State private var weathers = [Weather]()
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Weather")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            
        }
        .onAppear {
            getWeather()
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }
    func getWeather() {
            let apiKey = "rapidapi-key=cc6b0c5350msh5a3d7cf2c2a71fbp1bec8djsnecb6421d09a6"
            let query = "https://community-open-weather-map.p.rapidapi.com/weather?q=Barrington,IL,US&units=imperial&\(apiKey)"
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    if json["success"] == true {
                        let contents = json["body"].arrayValue
                        for item in contents {
                            let overcast = item["weather"].stringValue
                            let main = item["main"].stringValue
                            let weather = Weather(overcast: overcast, main: main)
                            weathers.append(weather)
                        }
                        return
                    }
                }
            }
            showingAlert = true
        }
}
struct Weather: Identifiable{
    let id = UUID()
    var overcast : String
    var main : String
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
