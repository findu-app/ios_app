//
//  AreaOfStudy.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/9/25.
//


struct AreaOfStudy: Decodable, Equatable {
    let code: String? // Code for the area of study
    let title: String? // Title of the area of study
    let credential: Credential? // Credential information
    let earnings: Earnings? // Earnings information

    enum CodingKeys: String, CodingKey {
        case code
        case title
        case credential
        case earnings
    }

    // Computed property to extract overall median earnings
    var afterCollegeSalary: Int? {
        return earnings?.oneYear?.overallMedianEarnings
    }

    // Computed property to clean up the title (remove trailing ".")
    var cleanedTitle: String? {
        guard let title = title else { return nil }
        return title.hasSuffix(".") ? String(title.dropLast()) : title
    }
}

struct Credential: Decodable, Equatable {
    let level: Int? // Level of the credential (e.g., Bachelor's, Master's)
}

struct Earnings: Decodable, Equatable {
    struct YearlyEarnings: Decodable, Equatable {
        let overallMedianEarnings: Int? // Median earnings for one year after graduation

        enum CodingKeys: String, CodingKey {
            case overallMedianEarnings = "overall_median_earnings"
        }
    }

    let oneYear: YearlyEarnings? // One-year post-graduation earnings

    enum CodingKeys: String, CodingKey {
        case oneYear = "1_yr"
    }
}
