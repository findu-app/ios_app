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
            URLQueryItem(name: "fields", value: "id,school.name,school.city,school.state,location.lat,location.lon,school.local,latest.student.size,latest.admissions.sat_scores.average.overall,latest.cost.tuition.in_state,latest.cost.attendance.academic_year,latest.cost.attendance.program_year,latest.aid.median_debt.completers.overall,latest.cost.attendance.avg_cost,latest.cost.tuition.in_state,latest.cost.tuition.out_of_state,latest.cost.avg_net_price.public,latest.cost.avg_net_price.private,latest.programs.cip_4_digit.title,latest.programs.cip_4_digit.code,latest.programs.cip_4_digit.credential.level,latest.program.cip_4_digit.credential.title,school.carnegie_size_setting,latest.student.demographics,latest.student.demographics.student_faculty_ratio,latest.admissions.act_scores.average.overall,latest.admissions.admission_rate.overall,latest.student.demographics.race_ethnicity.white,latest.student.demographics.race_ethnicity.black,latest.student.demographics.race_ethnicity.hispanic,latest.student.demographics.race_ethnicity.asian,latest.student.demographics.race_ethnicity.aian,latest.student.demographics.race_ethnicity.nhpi,latest.student.demographics.race_ethnicity.two_or_more,latest.student.demographics.race_ethnicity.non_resident_alien,latest.student.demographics.race_ethnicity.unknown,latest.student.demographics.race_ethnicity.white_non_hispanic,latest.student.demographics.race_ethnicity.black_non_hispanic,latest.student.demographics.race_ethnicity.asian_pacific_islander,latest.student.demographics.men,latest.student.demographics.women,school.religious_affiliation,latest.programs.cip_4_digit.earnings.1_yr.overall_median_earnings,latest.completion.completion_rate_4yr_150nt,latest.earnings.1_yr_after_completion.not_working_not_enrolled.overall_count,latest.earnings.1_yr_after_completion.working_not_enrolled.overall_count,latest.student.retention_rate.four_year.full_time_pooled,lateststudent.retention_rate.lt_four_year.full_time_pooled,latest.earnings.6_yrs_after_entry.gt_threshold,&all_programs_nested=true")
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

            // Print the raw JSON data to check the format
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response:\n\(jsonString)")
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
