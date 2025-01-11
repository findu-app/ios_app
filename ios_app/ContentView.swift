//
//  ContentView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//

//
//  AppView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/28/24.
//

import SwiftUI

struct ContentView: View {
    @State var isAuthenticated = false
    @EnvironmentObject var globalStudentState: GlobalStudentDataState

    var body: some View {
        Group {
            if isAuthenticated {
                if globalStudentState.studentInfo == nil {
                    StudentProfileCreationFlow()
                } else {
                    HomeView()
                }
            } else {
                WelcomeView()
            }
        }
        .task {
            for await state in supabase.auth.authStateChanges {
                if [.initialSession, .signedIn, .signedOut].contains(
                    state.event)
                {
                    isAuthenticated = state.session != nil

                    if let userId = state.session?.user.id.uuidString,
                        isAuthenticated
                    {
                        await handleAuthentication(userId: userId)
                    }
                }
            }
        }
    }

    /// Handles fetching the student profile after authentication
    private func handleAuthentication(userId: String) async {
        do {
            if let studentProfile = try await fetchStudentProfile(
                userId: userId)
            {
                print("Fetched Student Profile:")
                print("Student ID: \(studentProfile.id)")
                print("User ID: \(studentProfile.userID)")

                // Update global state with fetched student profile
                DispatchQueue.main.async {
                    globalStudentState.saveStudentInfo(from: studentProfile)
                }
            } else {
                print("No student profile found for userId \(userId).")
            }
        } catch {
            print("Failed to fetch student profile: \(error)")
        }
    }
}

private func fetchStudentProfile(userId: String) async throws -> StudentInfo? {
    let client = supabase
    let table = client.from("students")

    let response =
        try await table
        .select(
            "id, user_id, name, phone, preferred_contact_method, address, high_school_name, high_school_address, graduation_year, gender, household_income, financial_aid_need, gpa, act_score, sat_score, class_rank, num_ap_classes, activities, hobbies, volunteer_hours, majors, preferred_size, distance_from_home, preferred_setting, rigor, campus_culture_preferences, special_programs, greek_life_interest, research_interest, ethnicity"
        )
        .eq("user_id", value: userId)
        .single()
        .execute()

    if let rawData = response.data as? Data {
        do {
            let decoder = JSONDecoder()
            let studentInfo = try decoder.decode(
                StudentInfo.self, from: rawData)
            return studentInfo
        } catch {
            print("Error decoding student info from raw Data:", error)
            throw error
        }
    } else {
        print("Unexpected response data type:", response.data ?? "nil")
        return nil
    }
}

#Preview {
    ContentView()
}
