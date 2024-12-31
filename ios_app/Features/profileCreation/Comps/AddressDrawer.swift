//
//  AddressField.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI
import MapKit

struct AddressDrawer: View {
    @Binding var address: String
    @Binding var suggestions: [String]
    var onSuggestionSelected: (String) -> Void
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // TextField with styling
            TextField("Start typing your address...", text: $address)
                .focused($isFocused)
                .onChange(of: address, initial: false) {
                    LocationUtils.fetchAddressSuggestions(for: address) { fetchedSuggestions in
                        DispatchQueue.main.async {
                            self.suggestions = fetchedSuggestions
                        }
                    }                     }
                .padding(16.0)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SurfaceContainer"))
                        .stroke(isFocused ? Color("OnSurface") : Color("Border"), lineWidth: 1)
                )
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isFocused = false // Dismiss the keyboard
                        }
                    }
                }
            Spacer()
            
            // Suggestions Drawer
            if !suggestions.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(suggestions.prefix(3), id: \.self) { suggestion in
                            Button(action: {
                                onSuggestionSelected(suggestion)
                                isFocused = false // Dismiss the keyboard on selection
                            }) {
                                Text(suggestion)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .truncationMode(.tail)
                                    .lineLimit(1)
                                    .foregroundColor(Color("OnSurface"))
                                
                            }
                        }
                        
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddressDrawer(
        address: .constant(""),
        suggestions: .constant([]),
        onSuggestionSelected: { _ in }
    )
}
