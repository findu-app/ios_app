//
//  AddressInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI
import MapKit

struct AddressInputView: View {
    @Binding var studentAddress: String

    @State private var addressInput: String = ""

    @State private var suggestions: [String] = []
    @State private var isSheetOpen: Bool = false
    @State private var mapRegion: MKCoordinateRegion?

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                Text("What's your address?").centeredTitleTextStyle()
                
                AddressButton(
                    selectedAddress: $studentAddress,
                    isSheetPresented: $isSheetOpen
                )
                
                Spacer()
                
                // Displays a map region when user selects an address.
                if let mapRegion = mapRegion {
                    MapPreview(mapRegion: mapRegion, selectedAddress: studentAddress, iconName: "house.fill")
                }
                
                Spacer()
            }
            .background(Color("Surface"))
            .padding(.horizontal, 1)
            .sheet(isPresented: $isSheetOpen) {
                VStack {
                    AddressDrawer(
                        address: $addressInput,
                        suggestions: $suggestions,
                        onSuggestionSelected: { suggestion in
                            handleAddressSelect(suggestion)
                            isSheetOpen = false
                        }
                    )
                }
                .presentationDragIndicator(.visible)
                .menuIndicator(.visible)
                .padding(.top, 24)
            }
        }
    }
    
    
    /// Updates the selected address and centers the map on its coordinates.
    /// - Parameter suggestion: The user-selected address suggestion.
    ///
    /// This function:
    /// 1. Updates the state for the selected address and clears suggestions.
    /// 2. Fetches the coordinates for the selected address.
    /// 3. Updates the map region or logs an error if fetching fails.
    private func handleAddressSelect(_ suggestion: String) {
        self.studentAddress = suggestion
        self.addressInput = suggestion
        self.suggestions = []

        LocationUtils.fetchCoordinates(for: suggestion) { result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    self.mapRegion = MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                }
            case .failure(let error):
                print("Error fetching coordinates: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    AddressInputView(studentAddress: .constant(""))
}
