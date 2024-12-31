//
//  MapPreview.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI
import MapKit

struct MapPreview: View {
    var mapRegion: MKCoordinateRegion
    var selectedAddress: String?
    var iconName: String?

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Map Preview")
                .font(Font.custom("Plus Jakarta Sans Medium", size: 20))
                .foregroundColor(Color("OnSurface"))
            
            Map(coordinateRegion: .constant(mapRegion))
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Border"), lineWidth: 1)
                )
            if let selectedAddress = selectedAddress {
                HStack(spacing: 16) {
                    if let iconName = iconName {
                        Image(systemName: iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 32)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                    }
                    Text(selectedAddress)
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                        .foregroundColor(Color("OnSurface"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color("SurfaceContainer"))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Border"), lineWidth: 1)
                )
      
            }
        }
    }
}

#Preview {
    MapPreview(
        mapRegion: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ),
        selectedAddress: "123 Main St, San Francisco, CA",
        iconName: "house.fill"
    )
}
