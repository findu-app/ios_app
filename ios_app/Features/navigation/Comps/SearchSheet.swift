//
//  SearchSheet.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct SearchSheet: View {
    @Binding var isPresented: Bool
    @Binding var query: String
    @Binding var suggestions: [School]
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var debounceTask: Task<Void, Never>? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Search Bar
            TextField("Search schools...", text: $query)
                .onChange(of: query) { newValue in
                    debounceSearch(query: newValue)
                }
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SurfaceContainer"))
                        .stroke(Color("Border"), lineWidth: 1)
                )
                .padding(.horizontal, 16)
                .padding(.top, 32)

            // Suggestions or Loading/Error state
            if isLoading {
                ProgressView()
                    .padding(.horizontal, 16)
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                    .foregroundColor(.red)
                    .padding(.horizontal, 16)
            } else if !suggestions.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(suggestions.prefix(5), id: \.id) { school in
                            Button(action: {
                                print("Selected school: \(school.name)")
                                isPresented = false
                                query = ""
                                suggestions = []
                            }) {
                                Text(school.name)
                                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                                    .multilineTextAlignment(.leading)
                                    .padding(.vertical, 8)
                                    .lineSpacing(4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color("OnSurface"))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        }
                    }
                }
            } else if !query.isEmpty {
                Text("No results found")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 16)
            }

            Spacer()
        }
        .padding(.bottom, 16)
        .presentationDetents([.medium, .large]) // Allow resizing
        .presentationDragIndicator(.visible)
        .background(Color("Surface"))
    }

    /// Debounces the search to avoid too many API calls
    private func debounceSearch(query: String) {
        debounceTask?.cancel() // Cancel the previous task if it's still running

        debounceTask = Task { @MainActor in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 300ms delay
                Task { @MainActor in
                    await fetchSuggestions(for: query)
                }
            }
        }
    }

    /// Fetches suggestions based on the search query
    private func fetchSuggestions(for query: String) async {
        guard !query.isEmpty else {
            suggestions = []
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            // Replace spaces with `+` for the tsquery format
            let formattedQuery = query.replacingOccurrences(of: " ", with: "+")

            let fetchedSuggestions: [School] = try await supabase.rpc(
                "search_schools",
                params: ["prefix": formattedQuery]
            ).execute().value

            suggestions = fetchedSuggestions
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
