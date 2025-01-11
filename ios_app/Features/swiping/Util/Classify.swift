//
//  Classify.swift
//  ios_app
//
//  Created by Kenny Morales on 1/11/25.
//


// Classify.swift
// Utility for classification of various statistics

import Foundation

struct Classify {

    static func classifyAverageDebt(_ debt: Float?) -> String {
        guard let debt = debt else { return "N/A" }
        if debt == 0 { return "N/A" }
        return debt < 10000 ? "Low" : debt < 30000 ? "Medium" : "High"
    }

    static func classifyInStateTuition(_ tuition: Float?) -> String {
        guard let tuition = tuition else { return "N/A" }
        if tuition == 0 { return "N/A" }
        return tuition < 5000 ? "Low" : tuition < 15000 ? "Medium" : "High"
    }

    static func classifyOutStateTuition(_ tuition: Float?) -> String {
        guard let tuition = tuition else { return "N/A" }
        if tuition == 0 { return "N/A" }
        return tuition < 10000 ? "Low" : tuition < 25000 ? "Medium" : "High"
    }

    static func classifyCOAAcademicYear(_ coa: Float?) -> String {
        guard let coa = coa else { return "N/A" }
        if coa == 0 { return "N/A" }
        return coa < 20000 ? "Low" : coa < 40000 ? "Medium" : "High"
    }

    static func classifyNetPricePublic(_ price: Float?) -> String {
        guard let price = price else { return "N/A" }
        if price == 0 { return "N/A" }
        return price < 8000 ? "Low" : price < 20000 ? "Medium" : "High"
    }

    static func classifyNetPricePrivate(_ price: Float?) -> String {
        guard let price = price else { return "N/A" }
        if price == 0 { return "N/A" }
        return price < 15000 ? "Low" : price < 30000 ? "Medium" : "High"
    }
    
    static func classifyACTScore(actual: Float?, target: Float?) -> String {
        guard let actual = actual, let target = target else { return "N/A" }
        let diff = abs(actual - target)
        return diff < 2 ? "High" : diff < 5 ? "Medium" : "Low"
    }

    static func classifySATScore(actual: Float?, target: Float?) -> String {
        guard let actual = actual, let target = target else { return "N/A" }
        let diff = abs(actual - target)
        return diff < 50 ? "High" : diff < 100 ? "Medium" : "Low"
    }

    static func classifyAdmissionsRate(_ rate: Float?) -> String {
        guard let rate = rate else { return "N/A" }
        return rate < 0.3 ? "High" : rate < 0.7 ? "Medium" : "Low"
    }

    static func classifyStudentFacultyRatio(_ ratio: Float?) -> String {
        guard let ratio = ratio else { return "N/A" }
        return ratio < 10 ? "High" : ratio < 20 ? "Medium" : "Low"
    }

    static func classifyAreasOfStudy(_ count: Int?) -> String {
        guard let count = count else { return "N/A" }
        return count > 50 ? "High" : count > 20 ? "Medium" : "Low"
    }
    
    static func classifyCampusSize(_ size: Float?) -> String {
        guard let size = size, size > 0 else { return "N/A" }
        if size < 1000 {
            return "Low"
        } else if size < 5000 {
            return "Medium"
        } else {
            return "High"
        }
    }


    static func classifyLocale(_ locale: String?) -> String {
        guard let locale = locale else { return "N/A" }
        return locale.contains("Urban") ? "High" : locale.contains("Suburban") ? "Medium" : "Low"
    }

    static func classifyReligiousAffiliation(_ affiliation: String?) -> String {
        guard let affiliation = affiliation else { return "N/A" }
        return affiliation.isEmpty ? "N/A" : "Medium" // Customize as needed
    }
    
    static func classifyGradRate(_ rate: Float?) -> String {
        guard let rate = rate, rate > 0 else { return "N/A" } // Handle nil and zero
        return rate < 0.5 ? "Low" : rate < 0.75 ? "Medium" : "High"
    }

    static func classifyEarningMore(_ rate: Float?) -> String {
        guard let rate = rate, rate > 0 else { return "N/A" } // Handle nil and zero
        return rate < 0.4 ? "Low" : rate < 0.7 ? "Medium" : "High"
    }

    static func classifyWorkingNotEnrolled(_ rate: Float?) -> String {
        guard let rate = rate, rate > 0 else { return "N/A" } // Handle nil and zero
        return rate < 0.3 ? "Low" : rate < 0.6 ? "Medium" : "High"
    }

}
