import Foundation

class CollegeAPI {
    static let shared = CollegeAPI()
    private let baseURL = "https://api.data.gov/ed/collegescorecard/v1/schools"

    func fetchSchools(query: String, completion: @escaping (Result<[School], Error>) -> Void) {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API key is missing.")
        }

        let queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "school.name", value: query),
            URLQueryItem(name: "fields", value: "id,school.name,school.city,school.state,latest.student.size")
        ]

        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(apiResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
