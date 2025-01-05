//
//  SchoolsListView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//

//
//  SchoolsListView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//

import SwiftUI

struct SchoolsListView: View {
    @State private var schools: [School] = []
    @State private var searchQuery: String = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    let mockStudentInfo = StudentInfo(
        name: "Alex Johnson",
        phone: "555-123-4567",
        preferredContactMethod: "Email",
        address: "123 Maple Street, Lincoln, NE 68508",
        highSchoolName: "Lincoln High School",
        highSchoolAddress: "1000 S 70th St, Lincoln, NE 68510",
        graduationYear: 2025,
        gender: "Male",
        householdIncome: "65,000 - 120,000",
        financialAidNeed: true,
        gpa: 3.8,
        actScore: 29,
        satScore: 1100,
        classRank: "Top 10%",
        numAPClass: 5,
        activities: ["🤖   Robotics", "🎺   Band", "♟️   Chess Club"],
        hobbies: ["🎮   Esports", "📷   Photography", "🥾   Hiking"],
        volunteerHours: "50-100 hours",
        majors: ["Computer Science", "Mechanical Engineering"],
        preferredSize: "Medium",
        distanceFromHome: "Within 500 Miles",
        preferredSetting: "Suburban",
        rigor: "High",
        campusCulturePreferences: ["Diverse community", "STEM-focused programs"],
        specialPrograms: true,
        greekLifeInterest: false,
        researchInterest: true
    )


    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search schools...", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        fetchSchools()
                    }) {
                        Text("Search")
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .disabled(searchQuery.isEmpty)
                }
                .padding(.top)

                if isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if schools.isEmpty {
                    Text("No schools found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        ForEach(schools, id: \.id) { school in
                            SchoolCardView(school: school, student: mockStudentInfo)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                        }
                    }
                }
            }
            .navigationTitle("Search Colleges")
        }
    }

    private func fetchSchools() {
        guard !searchQuery.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        schools = []

        CollegeAPI.shared.fetchSchools(query: searchQuery) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let schools):
                    self.schools = schools
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    SchoolsListView()
}
