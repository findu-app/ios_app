//
//  CardViewModel.swift
//  ios_app
//
//  Created by Kenny Morales on 1/11/25.
//

import Foundation
import MapKit

class CardViewModel: ObservableObject {
    @Published var mapRegion: MKCoordinateRegion?
    @Published var isLoadingMap = true
    let school: School
    let studentMatch: StudentSchoolMatch // Store the full match object

    init(school: School, studentMatch: StudentSchoolMatch) {
        self.school = school
        self.studentMatch = studentMatch
        setupMapRegion()
    }

    private func setupMapRegion() {
        guard let lat = school.latitude, let lon = school.longitude else {
            return
        }
        mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: CLLocationDegrees(lat),
                longitude: CLLocationDegrees(lon)),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }

    /// Provides formatted stats for the `StatTagList` view
    func statTags() -> [[String: String]] {
        let tags = [
            [
                "label": "Avg ACT",
                "stat": StatFormatter.formatACTScore(school.actScore),
                "match": studentMatch.actScoreMatch
            ],
            [
                "label": "Avg Debt",
                "stat": StatFormatter.formatToDollarString(school.averageDebt),
                "match": studentMatch.averageDebt4YearMatch
            ],
            [
                "label": "Avg Tuition",
                "stat": StatFormatter.formatToDollarString(school.inStateTuition),
                "match": studentMatch.inStateTutionMatch
            ],
            [
                "label": "Grad Rate",
                "stat": StatFormatter.formatPercent(school.fourYearGradRate),
                "match": studentMatch.fourYearGradRateMatch
            ]
        ]

        // Filter out tags with "N/A" in the "stat" field
        return tags.filter { $0["stat"] != "N/A" }
    }


    /// Provides a formatted description of the school location
    func formattedLocation() -> String {
        "\(school.city ?? "Unknown City"), \(school.state ?? "Unknown State")"
    }

    /// Provides the school's name or a default placeholder
    func schoolName() -> String {
        school.name ?? "Unknown School"
    }
}
