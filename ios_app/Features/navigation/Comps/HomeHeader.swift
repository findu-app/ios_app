//
//  HomeHeader.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct HomeHeader: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isSearching = false
    @State private var query = ""
    @State private var suggestions: [School] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var debounceTask: Task<Void, Never>? = nil

    var body: some View {
        VStack {
            HStack {
                Image(
                    colorScheme == .dark
                        ? "finduLogoFull_dark" : "finduLogoFull_light"
                )
                .resizable()
                .scaledToFit()
                .frame(height: 24)

                Spacer()

                if isSearching {
                    HStack {
                        TextField("Search schools...", text: $query)
                            .onChange(of: query) { newValue in
                                debounceSearch(query: newValue)
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 8)

                        Button(action: {
                            withAnimation {
                                isSearching = false
                                query = ""
                                suggestions = []
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(height: 40)
                    .background(Color("Surface"))
                    .cornerRadius(10)
                    .padding(.horizontal, 8)
                } else {
                    Button(action: {
                        withAnimation {
                            isSearching = true
                        }
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("OnSurface"))
                                .padding(4)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)

            Divider()
                .frame(height: 1)
                .background(Color("Border"))

            // Display suggestions if available
            if isSearching && !suggestions.isEmpty {
                List(suggestions, id: \.id) { school in
                    Text(school.name)
                        .onTapGesture {
                            print("Selected school: \(school.name)")
                            // Handle school selection
                        }
                }
                .frame(maxHeight: 200) // Limit height of the suggestions list
            } else if isLoading {
                ProgressView()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
    }

    /// Debounces the search to avoid too many API calls
    private func debounceSearch(query: String) {
        print(suggestions)
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
            // Supabase query with a limit to avoid fetching too many suggestions
            let fetchedSuggestions: [School] = try await supabase
                .from("schools")
                .select()
                .textSearch("name", query: query)
                .limit(10) // Limit to 10 suggestions
                .execute()
                .value

            suggestions = fetchedSuggestions
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

#Preview {
    HomeHeader()
}
