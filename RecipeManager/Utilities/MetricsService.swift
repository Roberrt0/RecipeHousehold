//
//  MetricsService.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 30/03/26.
//

//
// Service class that notifies the flask service whenever a certain event happens
//

import Foundation

class MetricsService {
    
    // the url of the flask service http://127.0.0.1:59496
    // static let serverURL = URL(string: "http://localhost:5050/ping")!
    static let serverURL = URL(string: "http://127.0.0.1:59496/ping")!

    static func sendEvent(_ eventType: EventType) {
        print("about to ping an event: \(eventType.rawValue)")
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("request created")

        let body: [String: String] = ["event": eventType.rawValue]
        request.httpBody = try? JSONEncoder().encode(body)
        
        print("body created")

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("❌ Metrics Error: \(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("✅ Metric Sent: \(eventType.rawValue)")
            }
        }.resume()
        print("data sent, waiting for response...")
    }
    
    // each string value represents the name of the associated event as it is defined in the flask service
    enum EventType: String, Codable {
        case recipeCreated = "recipe_created"
        case appOpened = "app_opened"
    }
}
