//
//  HSDrawer.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI
import MapKit

struct HSDrawer: View {
    @Binding var HS: String
    @Binding var suggestions: [String]
    var onSuggestionSelected: (String) -> Void
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Start typing your high school...", text: $HS)
                .focused($isFocused)
                .onChange(of: HS) { query in
                    LocationUtils.fetchHSSuggestions(for: query) { newSuggestions in
                        DispatchQueue.main.async {
                            self.suggestions = newSuggestions
                        }
                    }
                }
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
            
            if !suggestions.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(suggestions.prefix(3), id: \.self) { suggestion in
                            Button(action: {
                                onSuggestionSelected(suggestion)
                                isFocused = false // Dismiss the keyboard
                            }) {
                                Text(LocationUtils.formatHSSuggestion(suggestion))
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .truncationMode(.tail)
                                    .lineLimit(1)
                                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
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
