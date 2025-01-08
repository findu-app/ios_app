//
//  CollegeAPI.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//


import Foundation

class CollegeAPI {
    static let shared = CollegeAPI()
    private let baseURL = "https://api.data.gov/ed/collegescorecard/v1/schools"

    private init() {}

    func fetchSchools(query: String?, completion: @escaping (Result<[School], Error>) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API key is missing.")
        }

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "fields", value: "id,school.name,school.city,school.state,latest.student.size,latest.admissions.sat_scores.average.overall,latest.cost.tuition.in_state,latest.cost.attendance.academic_year,latest.cost.attendance.program_year")
        ]

        if let query = query {
            components.queryItems?.append(URLQueryItem(name: "school.name", value: query))
        }

        guard let url = components.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data returned", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SchoolsResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
