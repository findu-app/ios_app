//
//  School.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/9/25.
//


import Foundation

struct School: Decodable, Identifiable, Equatable {
    // General Information
    let id: UUID
    let apiId: String
    let name: String
    let city: String?
    let state: String?
    let latitude: Float?
    let longitude: Float?
    let ownership: Int?
    let schoolUrl: String?
    let priceCalculatorUrl: String?

    // Costs
    let averageDebt: Float?
    let averageNetPricePublic: Int?
    let averageNetPricePrivate: Int?
    let inStateTuition: Float?
    let outStateTuition: Float?
    let coaAcademicYear: Int?

    // Academics
    let carnegie: Int?
    let studentToFacultyRatio: Float?
    let areasOfStudy: [AreaOfStudy]? // Decoded from JSONB

    // Admissions
    let actScore: Float?
    let satScore: Float?
    let admissionsRate: Float?

    // Campus
    let size: Int?
    let locale: Int?
    let religiousAffiliation: Int?
    let white: Float?
    let black: Float?
    let hispanic: Float?
    let asian: Float?
    let aian: Float? // American Indian/Alaska Native
    let nhpi: Float? // Native Hawaiian/Pacific Islander
    let twoOrMore: Float?
    let nonResidentAlien: Float?
    let unknown: Float?
    let whiteNonHispanic: Float?
    let blackNonHispanic: Float?
    let asianPacificIslander: Float?
    let men: Float?
    let women: Float?

    // Outcomes
    let fourYearGradRate: Float?
    let fourYearRetentionRate: Float?
    let lessThanFourYearRetentionRate: Float?
    let percentEarningMoreThanHSGrad: Float?
    let notWorkingNotEnrolled: Int?
    let workingNotEnrolled: Int?

    // Decoding keys
    enum CodingKeys: String, CodingKey {
        case id
        case apiId = "api_id"
        case name
        case city
        case state
        case latitude
        case longitude
        case ownership
        case schoolUrl = "school_url"
        case priceCalculatorUrl = "price_calculator_url"

        // Costs
        case averageDebt = "average_debt"
        case averageNetPricePublic = "average_net_price_public"
        case averageNetPricePrivate = "average_net_price_private"
        case inStateTuition = "in_state_tuition"
        case outStateTuition = "out_state_tuition"
        case coaAcademicYear = "coa_academic_year"

        // Academics
        case carnegie
        case studentToFacultyRatio = "student_to_faculty_ratio"
        case areasOfStudy = "areas_of_study"

        // Admissions
        case actScore = "act_score"
        case satScore = "sat_score"
        case admissionsRate = "admissions_rate"

        // Campus
        case size
        case locale
        case religiousAffiliation = "religious_affiliation"

        // Demographics
        case white
        case black
        case hispanic
        case asian
        case aian
        case nhpi
        case twoOrMore = "two_or_more"
        case nonResidentAlien = "non_resident_alien"
        case unknown
        case whiteNonHispanic = "white_non_hispanic"
        case blackNonHispanic = "black_non_hispanic"
        case asianPacificIslander = "asian_pacific_islander"
        case men
        case women

        // Outcomes
        case fourYearGradRate = "four_year_grad_rate"
        case fourYearRetentionRate = "four_year_retention_rate"
        case lessThanFourYearRetentionRate = "less_than_four_year_retention_rate"
        case percentEarningMoreThanHSGrad = "percent_earning_more_than_hs_grad"

        // Employment Data
        case notWorkingNotEnrolled = "not_working_not_enrolled"
        case workingNotEnrolled = "working_not_enrolled"
    }
    
    var ownershipDescription: String {
            switch ownership {
            case 1:
                return "Public"
            case 2:
                return "Private Nonprofit"
            case 3:
                return "Private For-Profit"
            default:
                return "Unknown Ownership Type"
            }
        }
    
    var averageFinancialAid: Int? {
        guard let coa = coaAcademicYear, coa > 0 else { return 0 }
        let netPrice = (averageNetPricePublic ?? averageNetPricePrivate ?? 0)
        guard netPrice > 0 else { return 0 }
        return max(0, coa - netPrice)
    }

    var calculatedEmploymentRate: Float? {
        guard let notWorking = notWorkingNotEnrolled, let working = workingNotEnrolled else {
            return nil
        }
        let total = notWorking + working
        return total > 0 ? (Float(working) / Float(total)) * 100 : nil
    }
    
    var religiousAffiliationDescription: String {
            guard let affiliation = self.religiousAffiliation else {
                return "Unknown Religious Affiliation"
            }

            switch affiliation {
            case -1: return "Not reported"
            case -2: return "Not applicable"
            case 22: return "American Evangelical Lutheran Church"
            case 24: return "African Methodist Episcopal Zion Church"
            case 27: return "Assemblies of God Church"
            case 28: return "Brethren Church"
            case 30: return "Roman Catholic"
            case 33: return "Wisconsin Evangelical Lutheran Synod"
            case 34: return "Christ and Missionary Alliance Church"
            case 35: return "Christian Reformed Church"
            case 36: return "Evangelical Congregational Church"
            case 37: return "Evangelical Covenant Church of America"
            case 38: return "Evangelical Free Church of America"
            case 39: return "Evangelical Lutheran Church"
            case 40: return "International United Pentecostal Church"
            case 41: return "Free Will Baptist Church"
            case 42: return "Interdenominational"
            case 43: return "Mennonite Brethren Church"
            case 44: return "Moravian Church"
            case 45: return "North American Baptist"
            case 47: return "Pentecostal Holiness Church"
            case 48: return "Christian Churches and Churches of Christ"
            case 49: return "Reformed Church in America"
            case 50: return "Episcopal Church, Reformed"
            case 51: return "African Methodist Episcopal"
            case 52: return "American Baptist"
            case 53: return "American Lutheran"
            case 54: return "Baptist"
            case 55: return "Christian Methodist Episcopal"
            case 57: return "Church of God"
            case 58: return "Church of Brethren"
            case 59: return "Church of the Nazarene"
            case 60: return "Cumberland Presbyterian"
            case 61: return "Christian Church (Disciples of Christ)"
            case 64: return "Free Methodist"
            case 65: return "Friends"
            case 66: return "Presbyterian Church (USA)"
            case 67: return "Lutheran Church in America"
            case 68: return "Lutheran Church - Missouri Synod"
            case 69: return "Mennonite Church"
            case 71: return "United Methodist"
            case 73: return "Protestant Episcopal"
            case 74: return "Churches of Christ"
            case 75: return "Southern Baptist"
            case 76: return "United Church of Christ"
            case 77: return "Protestant, not specified"
            case 78: return "Multiple Protestant Denomination"
            case 79: return "Other Protestant"
            case 80: return "Jewish"
            case 81: return "Reformed Presbyterian Church"
            case 84: return "United Brethren Church"
            case 87: return "Missionary Church Inc"
            case 88: return "Undenominational"
            case 89: return "Wesleyan"
            case 91: return "Greek Orthodox"
            case 92: return "Russian Orthodox"
            case 93: return "Unitarian Universalist"
            case 94: return "Latter Day Saints (Mormon Church)"
            case 95: return "Seventh Day Adventists"
            case 97: return "The Presbyterian Church in America"
            case 99: return "Other (none of the above)"
            case 100: return "Original Free Will Baptist"
            case 101: return "Ecumenical Christian"
            case 102: return "Evangelical Christian"
            case 103: return "Presbyterian"
            case 105: return "General Baptist"
            case 106: return "Muslim"
            case 107: return "Plymouth Brethren"
            default: return "Unknown Religious Affiliation"
            }
        }

    
    var carnegieDescription: String {
        guard let carnegie = self.carnegie else { return "Unknown" }
        let descriptions: [Int: String] = [
            -2: "N/A", 0: "Unclassified",
            1: "2-year (small)", 2: "2-year (medium)", 3: "2-year (large)",
            6: "4-year (nonresidential)", 7: "4-year (residential)",
            8: "4-year (highly residential)", 12: "4-year (medium)",
            15: "4-year (large)", 18: "Graduate/Professional"
        ]
        return descriptions[carnegie] ?? "N/A"
    }


    var localeDescription: String {
        guard let locale = self.locale else {
            return "N/A"
        }

        switch locale {
        case 11: return "City (pop. of 250,000)"
        case 12: return "City (pop. 100,000-250,000)"
        case 13: return "City (pop. < 100,000)"
        case 21: return "Suburb (pop. of 250,000)"
        case 22: return "Suburb (pop. 100,000-250,000)"
        case 23: return "Suburb (pop. < 100,000)"
        case 31: return "Town (fringe, <10 mi urban)"
        case 32: return "Town (distant, 10-35 mi)"
        case 33: return "Town (remote, >35 mi)"
        case 41: return "Rural (fringe, <5 mi urban)"
        case 42: return "Rural (distant, 5-25 mi urban)"
        case 43: return "Rural (remote, >25 mi urban)"
        default: return "Unknown Locale"
        }
    }

}
