//
//  LocationUtils.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import CoreLocation
import Foundation
import MapKit

/// Utility struct for handling location-related functionality, such as fetching coordinates for a given address.
struct LocationUtils {
    
    /// Fetches geographic coordinates for a given address.
    /// - Parameters:
    ///   - address: The address string to geocode.
    ///   - completion: A closure that returns a `Result` containing the coordinates (`CLLocationCoordinate2D`) or an error.
    ///
    /// This function:
    /// 1. Uses Apple's `CLGeocoder` to convert the provided address into geographic coordinates.
    /// 2. Returns the first result's coordinates via the completion handler if successful.
    /// 3. Passes an error to the completion handler if geocoding fails or no coordinates are found.
    static func fetchCoordinates(
        for address: String,
        completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void
    ) {
        let geocoder = CLGeocoder()
        
        // Geocode the address string to fetch placemark data
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Extract the location from the first placemark
            if let placemark = placemarks?.first,
               let location = placemark.location
            {
                completion(.success(location.coordinate))
            } else {
                let noResultError = NSError(
                    domain: "LocationUtils",
                    code: 404,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            "No coordinates found for the given address."
                    ]
                )
                completion(.failure(noResultError))
            }
        }
    }
    
    /// Fetches address suggestions based on the user's input query.
    /// - Parameters:
    ///   - query: The input string entered by the user.
    ///   - completion: A closure that returns an array of up to 3 unique address suggestions.
    ///
    /// This function:
    /// 1. Ensures the query is not empty; otherwise, it returns an empty list.
    /// 2. Creates an `MKLocalSearch.Request` to search for points of interest matching the query.
    /// 3. Extracts unique and valid address titles from the search response.
    /// 4. Returns up to 3 suggestions to the provided completion handler.
    static func fetchAddressSuggestions(
        for query: String, completion: @escaping ([String]) -> Void
    ) {
        guard !query.isEmpty else {
            completion([])  // Return empty suggestions for empty query
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            if let error = error {
                print(
                    "Error fetching suggestions: \(error.localizedDescription)")
                completion([])  // Return empty suggestions on error
                return
            }
            
            if let mapItems = response?.mapItems {
                let suggestions = Array(
                    Set(
                        mapItems.compactMap { item in
                            item.placemark.title
                        })
                ).prefix(3).map { $0 }  // Limit to 3 suggestions
                completion(suggestions)  // Pass the suggestions back via the closure
            } else {
                completion([])  // Return empty suggestions if no results
            }
        }
    }
    
    /// Fetches high school suggestions based on the user's input query.
    /// - Parameters:
    ///   - query: The input string entered by the user.
    ///   - completion: A closure that returns an array of up to 3 unique high school suggestions.
    ///
    /// This function:
    /// 1. Ensures the query is not empty and adds "high school" for better results.
    /// 2. Uses `MKLocalSearch` to search for high schools matching the query.
    /// 3. Processes the search results to extract both the name and address.
    /// 4. Returns up to 3 suggestions to the completion handler.
    static func fetchHSSuggestions(
        for query: String, completion: @escaping ([String]) -> Void
    ) {
        guard !query.isEmpty else {
            completion([])  // Return an empty array if the query is empty
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "\(query) high school"
        request.resultTypes = [.pointOfInterest]
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print(
                    "Error fetching high school suggestions: \(error.localizedDescription)"
                )
                completion([])
                return
            }
            
            if let mapItems = response?.mapItems {
                let suggestions = mapItems.compactMap { item -> String? in
                    guard let name = item.name, let address = item.placemark.title
                    else { return nil }
                    return "\(name), \(address)"
                }
                completion(Array(suggestions.prefix(3)))  // Limit to 3 suggestions
            } else {
                completion([])
            }
        }
    }
    
    /// Formats a high school suggestion to include only the school name, city, and state.
    /// - Parameter suggestion: A string in the format "Name of school, address, city, state, zip".
    /// - Returns: A formatted string containing the school name, city, and state. If the input format is invalid, the original suggestion string is returned unchanged.
    static func formatHSSuggestion(_ suggestion: String) -> String {
        let components = suggestion.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        guard components.count >= 4 else {
            return suggestion
        }
        
        let schoolName = components[0]
        let city = components[components.count - 3]
        let stateZip = components[components.count - 2]
        
        let state = stateZip.split(separator: " ").first.map(String.init) ?? stateZip

        // Return the formatted string
        return "\(schoolName), \(city), \(state)"
    }
}
