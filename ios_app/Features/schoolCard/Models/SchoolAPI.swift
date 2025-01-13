//
//  School.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//

struct SchoolsAPIResponse: Decodable {
    let results: [SchoolAPI]
}

struct SchoolAPI: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let city: String
    let state: String
    let longitude: Float?
    let latitude: Float?
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
    let areasOfStudy: [AreaOfStudy]?
    let carnegie: Int?
    let studentToFaculty: Float?

    // Admissions
    let act: Float?
    let sat: Float?
    let admissionsRate: Float?

    // Campus
    let size: Int?
    let locale: Int?
    let religiousAffiliation: Int?
    
    // Demographics
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
    
    // Employment Data
    let notWorkingNotEnrolled: Int?
    let workingNotEnrolled: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "school.name"
        case city = "school.city"
        case state = "school.state"
        case longitude = "location.lon"
        case latitude = "location.lat"
        case ownership = "school.ownership"
        case schoolUrl = "school.school_url"
        case priceCalculatorUrl = "school.price_calculator_url"

        // Costs
        case averageDebt = "latest.aid.median_debt.completers.overall"
        case averageNetPricePublic = "latest.cost.avg_net_price.public"
        case averageNetPricePrivate = "latest.cost.avg_net_price.private"
        case inStateTuition = "latest.cost.tuition.in_state"
        case outStateTuition = "latest.cost.tuition.out_of_state"
        case coaAcademicYear = "latest.cost.attendance.academic_year"

        // Academics
        case areasOfStudy = "latest.programs.cip_4_digit"
        case carnegie = "school.carnegie_size_setting"
        case studentToFaculty = "latest.student.demographics.student_faculty_ratio"

        // Admissions
        case act = "latest.admissions.act_scores.midpoint.cumulative"
        case sat = "latest.admissions.sat_scores.average.overall"
        case admissionsRate = "latest.admissions.admission_rate.overall"

        // Campus
        case size = "latest.student.size"
        case locale = "school.locale"
        case religiousAffiliation = "school.religious_affiliation"
        
        // Demographics
        case white = "latest.student.demographics.race_ethnicity.white"
        case black = "latest.student.demographics.race_ethnicity.black"
        case hispanic = "latest.student.demographics.race_ethnicity.hispanic"
        case asian = "latest.student.demographics.race_ethnicity.asian"
        case aian = "latest.student.demographics.race_ethnicity.aian"
        case nhpi = "latest.student.demographics.race_ethnicity.nhpi"
        case twoOrMore = "latest.student.demographics.race_ethnicity.two_or_more"
        case nonResidentAlien = "latest.student.demographics.race_ethnicity.non_resident_alien"
        case unknown = "latest.student.demographics.race_ethnicity.unknown"
        case whiteNonHispanic = "latest.student.demographics.race_ethnicity.white_non_hispanic"
        case blackNonHispanic = "latest.student.demographics.race_ethnicity.black_non_hispanic"
        case asianPacificIslander = "latest.student.demographics.race_ethnicity.asian_pacific_islander"
        case men = "latest.student.demographics.men"
        case women = "latest.student.demographics.women"

        // Outcomes
        case fourYearGradRate = "latest.completion.completion_rate_4yr_150nt"
        case fourYearRetentionRate = "latest.student.retention_rate.four_year.full_time_pooled"
        case lessThanFourYearRetentionRate = "latest.student.retention_rate.lt_four_year.full_time_pooled"
        case percentEarningMoreThanHSGrad = "latest.earnings.6_yrs_after_entry.gt_threshold"

        // Employment Data
        case notWorkingNotEnrolled = "latest.earnings.1_yr_after_completion.not_working_not_enrolled.overall_count"
        case workingNotEnrolled = "latest.earnings.1_yr_after_completion.working_not_enrolled.overall_count"

    }
    
    // Translated Ownership
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

    // Computed property for Average Financial Aid
    var averageFinancialAid: Int? {
        guard let coa = coaAcademicYear else { return nil }
        let netPrice = averageNetPricePublic ?? averageNetPricePrivate ?? 0
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
            guard let carnegie = self.carnegie else {
                return "Unknown Classification"
            }

            switch carnegie {
            case -2: return "Not applicable"
            case 0: return "(Not classified)"
            case 1: return "Two-year, very small"
            case 2: return "Two-year, small"
            case 3: return "Two-year, medium"
            case 4: return "Two-year, large"
            case 5: return "Two-year, very large"
            case 6: return "Four-year, very small, primarily nonresidential"
            case 7: return "Four-year, very small, primarily residential"
            case 8: return "Four-year, very small, highly residential"
            case 9: return "Four-year, small, primarily nonresidential"
            case 10: return "Four-year, small, primarily residential"
            case 11: return "Four-year, small, highly residential"
            case 12: return "Four-year, medium, primarily nonresidential"
            case 13: return "Four-year, medium, primarily residential"
            case 14: return "Four-year, medium, highly residential"
            case 15: return "Four-year, large, primarily nonresidential"
            case 16: return "Four-year, large, primarily residential"
            case 17: return "Four-year, large, highly residential"
            case 18: return "Exclusively graduate/professional"
            default: return "Unknown Classification"
            }
        }


    var localeDescription: String {
        guard let locale = self.locale else {
            return "Unknown Locale"
        }

        switch locale {
        case 11: return "City: Large (population of 250,000 or more)"
        case 12: return "City: Midsize (population of at least 100,000 but less than 250,000)"
        case 13: return "City: Small (population less than 100,000)"
        case 21: return "Suburb: Large (outside principal city, in urbanized area with population of 250,000 or more)"
        case 22: return "Suburb: Midsize (outside principal city, in urbanized area with population of at least 100,000 but less than 250,000)"
        case 23: return "Suburb: Small (outside principal city, in urbanized area with population less than 100,000)"
        case 31: return "Town: Fringe (in urban cluster up to 10 miles from an urbanized area)"
        case 32: return "Town: Distant (in urban cluster more than 10 miles and up to 35 miles from an urbanized area)"
        case 33: return "Town: Remote (in urban cluster more than 35 miles from an urbanized area)"
        case 41: return "Rural: Fringe (rural territory up to 5 miles from an urbanized area or up to 2.5 miles from an urban cluster)"
        case 42: return "Rural: Distant (rural territory more than 5 miles but up to 25 miles from an urbanized area or more than 2.5 and up to 10 miles from an urban cluster)"
        case 43: return "Rural: Remote (rural territory more than 25 miles from an urbanized area and more than 10 miles from an urban cluster)"
        default: return "Unknown Locale"
        }
    }

}
