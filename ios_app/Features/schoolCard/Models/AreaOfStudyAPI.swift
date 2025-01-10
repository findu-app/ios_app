//
//  AreaOfStudy.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/9/25.
//

struct CredentialAPI: Decodable, Equatable {
    let level: Int?
}

struct EarningsAPI: Decodable, Equatable {
    struct YearlyEarnings: Decodable, Equatable {
        let overallMedianEarnings: Int?

        enum CodingKeys: String, CodingKey {
            case overallMedianEarnings = "overall_median_earnings"
        }
    }

    let oneYear: YearlyEarnings?

    enum CodingKeys: String, CodingKey {
        case oneYear = "1_yr"
    }
}


struct AreaOfStudyAPI: Decodable, Equatable {
    let code: String?
    let title: String?
    let credential: CredentialAPI?
    let earnings: EarningsAPI?

    enum CodingKeys: String, CodingKey {
        case code
        case title
        case credential
        case earnings
    }

    var afterCollegeSalary: Int? {
        return earnings?.oneYear?.overallMedianEarnings
    }

    var cleanedTitle: String? {
        guard let title = title else { return nil }
        return title.hasSuffix(".") ? String(title.dropLast()) : title
    }
}
