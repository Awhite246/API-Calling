//
//  ContentView.swift
//  API Calling
//
//  Created by Student on 2/3/22.
//
//https://community-open-weather-map.p.rapidapi.com/weather?q=Barrington,IL,US&units=imperial&rapidapi-key=cc6b0c5350msh5a3d7cf2c2a71fbp1bec8djsnecb6421d09a6

import SwiftUI

struct ContentView: View {
    @State private var city = ""
    @State private var state = ""
    var body: some View {
        NavigationView {
            VStack {
                Text("\(city)")
                    .padding()
                TextField("Your City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .frame(width: 200, height: 30, alignment: .center)
                    .font(.body)
                    .padding()
            }
        }
    }
    func getJokes() {
            let apiKey = "?rapidapi-key=(paste your Rapid API key here)"
            let query = "https://dad-jokes.p.rapidapi.com/joke/type/programming\(apiKey)"
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    if json["success"] == true {
                        let contents = json["body"].arrayValue
                        for item in contents {
                            let setup = item["setup"].stringValue
                            let punchline = item["punchline"].stringValue
                            let joke = Joke(setup: setup, punchline: punchline)
                            jokes.append(joke)
                        }
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
