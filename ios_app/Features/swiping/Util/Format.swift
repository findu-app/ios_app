//
//  StatFormatter.swift
//  ios_app
//
//  Created by Kenny Morales on 1/12/25.
//

import Foundation
import SwiftUICore

struct StatFormatter {
    /// Formats a number into a dollar string with commas and no decimals.
    /// - Parameter value: The value to format.
    /// - Returns: A formatted string in the form of "$#,###", or "N/A" if the value is nil or zero.
    static func formatToDollarString(_ value: Float?) -> String {
        guard let value = value, value > 0 else {
            return "N/A"
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "$"

        return formatter.string(from: NSNumber(value: value)) ?? "N/A"
    }
    
    static func formatToDollarString(_ value: Int?) -> String {
        guard let value = value, value > 0 else {
            return "N/A"
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "$"

        return formatter.string(from: NSNumber(value: value)) ?? "N/A"
    }


    static func formatNetPrice(publicPrice: Int?, privatePrice: Int?) -> String
    {
        let netPrice: Float
        if let publicPrice = publicPrice, publicPrice != 0 {
            netPrice = Float(publicPrice)
        } else if let privatePrice = privatePrice, privatePrice != 0 {
            netPrice = Float(privatePrice)
        } else {
            return "N/A"
        }
        return formatToDollarString(netPrice)
    }

    static func formatNetPriceMatch(publicMatch: String?, privateMatch: String?)
        -> String
    {
        if let publicMatch = publicMatch, publicMatch != "N/A" {
            return publicMatch
        } else if let privateMatch = privateMatch, privateMatch != "N/A" {
            return privateMatch
        } else {
            return "N/A"
        }
    }

    static func formatURL(_ url: String?) -> String {
        guard let url = url else { return "https://example.com" }
        if url.hasPrefix("http://") || url.hasPrefix("https://") {
            return url
        } else {
            return "https://\(url)"
        }
    }

    static func formatStudentFacultyRatio(_ ratio: Float?) -> String {
        guard let ratio = ratio, ratio > 0 else { return "N/A" }
        return "\(Int(ratio)) to 1"
    }

    static func formatAdmissionsRate(_ rate: Float?) -> String {
        guard let rate = rate, rate > 0 else { return "N/A" }
        return "\(Int(rate * 100))%"
    }

    static func formatSATScore(_ score: Float?) -> String {
        guard let score = score, score > 0 else { return "N/A" }
        return "\(String(format: "%.0f", score))"
    }

    static func formatACTScore(_ score: Float?) -> String {
        guard let score = score, score > 0 else { return "N/A" }
        return "\(String(format: "%.0f", score))"
    }
    
    static func formatPercent(_ value: Float?) -> String {
            guard let value = value else { return "N/A" }
            return String(format: "%.2f%%", value * 100)
        }
    
    static func formatEmploymentRate(_ value: Float?) -> String {
        guard let value = value, value > 0 else { return "N/A" }
        return String(format: "%.0f%%", value)
    }
    
    static func colorForMatchScore(_ score: String) -> Color {
        switch score {
        case "A+", "A", "A-":
            return Color("A")
        case "B+", "B", "B-":
            return Color("B")
        case "C+", "C", "C-":
            return Color("C")
        default:
            return Color("Secondary") // Replace with your default/error color
        }
    }
    
    static func colorForMatchScoreCard(_ score: String) -> Color {
        switch score {
        case "A+", "A", "A-":
            return Color("A-card")
        case "B+", "B", "B-":
            return Color("B-card")
        case "C+", "C", "C-":
            return Color("C-card")
        default:
            return Color("Secondary") // Replace with your default/error color
        }
    }
}
