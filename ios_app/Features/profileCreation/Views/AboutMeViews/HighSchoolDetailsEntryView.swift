//
//  HighSchoolDetailsEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import MapKit
import SwiftUI

struct HighSchoolDetailsEntryView: View {
    @Binding var highSchoolName: String
    @Binding var highSchoolAddress: String

    @State private var suggestions: [String] = []
    @State private var isSheetPresented: Bool = false
    @State private var mapRegion: MKCoordinateRegion?

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                Text("What's your high school?").centeredTitleTextStyle()

                HighSchoolPickerButton(
                    selectedHighSchool: $highSchoolName,
                    isSheetOpen: $isSheetPresented
                )

                Spacer()

                // Map Preview if mapRegion is available
                if let mapRegion = mapRegion {
                    SelectedAddressMapPreview(
                        mapRegion: mapRegion,
                        selectedAddress: highSchoolName,
                        iconName: "graduationcap"
                    )
                }

                Spacer()
            }
            .padding(.horizontal, 1)
            .sheet(isPresented: $isSheetPresented) {
                VStack {
                    HighSchoolSuggestionsDrawer(
                        highSchool: $highSchoolAddress,
                        suggestions: $suggestions,
                        onSuggestionSelected: { suggestion in
                            handleHSSelect(suggestion)
                            isSheetPresented = false  // Close the sheet on selection
                        }
                    )
                }
                .presentationDragIndicator(.visible)
                .menuIndicator(.visible)
                .padding(.top, 24)
            }
        }
    }

    /// Handles the selection of a high school and updates the state and map region.
    /// - Parameter suggestion: The user-selected high school suggestion in the format "School Name, Address".
    ///
    /// This function:
    /// 1. Parses the suggestion into the school name and address.
    /// 2. Updates the selected high school and clears suggestions.
    /// 3. Fetches geographic coordinates for the selected high school's address.
    /// 4. Updates the map region to center around the fetched coordinates.
    /// 5. Logs an error if the coordinate-fetching process fails.
    private func handleHSSelect(_ suggestion: String) {
        let components = suggestion.split(separator: ",").map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        _ = components.first ?? ""
        let schoolAddress = components.dropFirst().joined(separator: ", ")

        self.highSchoolName = LocationUtils.formatHSSuggestion(suggestion)
        self.highSchoolAddress = suggestion  // Store the full suggestion string
        self.suggestions = []  // Clear suggestions after selection

        // Fetch coordinates using the full address
        LocationUtils.fetchCoordinates(for: schoolAddress) { result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    self.mapRegion = MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                }
            case .failure(let error):
                print(
                    "Error fetching coordinates: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    HighSchoolDetailsEntryView(
        highSchoolName: .constant(""), highSchoolAddress: .constant(""))
}
