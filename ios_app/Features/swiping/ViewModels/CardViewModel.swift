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

    init(school: School) {
        self.school = school
        setupMapRegion()
    }

    /// Configures the map region based on the school's latitude and longitude
    private func setupMapRegion() {
        guard let lat = school.latitude, let lon = school.longitude else { return }
        mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon)),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }

    /// Provides formatted stats for the `StatTagList` view
    func statTags() -> [[String: String]] {
        [
            [
                "label": "Average ACT",
                "stat": school.actScore != nil ? "\(school.actScore!)" : "N/A",
                "match": "High",
            ],
            [
                "label": "Avg Aid",
                "stat": school.averageFinancialAid != nil ? "\(school.averageFinancialAid!)" : "N/A",
                "match": "Low",
            ],
            [
                "label": "Avg Tuition",
                "stat": school.inStateTuition != nil ? "\(school.inStateTuition!)" : "N/A",
                "match": "High",
            ]
        ]
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
