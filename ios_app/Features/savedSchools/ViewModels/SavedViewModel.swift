//
//  SavedViewModel.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/13/25.
//


import SwiftUI
import Supabase

@MainActor
class SavedViewModel: ObservableObject {
    @Published var likedSchools: [School] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // We’ll need access to your globalStudentState to get the student's ID
    private var globalStudentState: GlobalStudentDataState
    
    init(globalStudentState: GlobalStudentDataState) {
        self.globalStudentState = globalStudentState
    }

    /// Fetch all interactions for the current student that are liked,
    /// then fetch the corresponding schools and store them in `likedSchools`.
    func fetchLikedSchools() async {
        // Ensure we have a valid student profile
        guard let studentProfile = globalStudentState.studentInfo else {
            errorMessage = "No student profile available."
            return
        }
        
        isLoading = true
        errorMessage = nil

        do {
            // 1) Fetch all interactions for this student where liked == true
            //    If your table has different column names, adapt accordingly.
            let interactions: [StudentSchoolInteraction] = try await supabase
                .from("student_school_interactions")
                .select()
                .eq("student_id", value: studentProfile.id)  // studentProfile.id is presumably a String representation of the UUID
                .eq("liked", value: true)
                .execute()
                .value

            // 2) Extract unique school IDs
            let schoolIDs = interactions.map { $0.schoolId }
            let uniqueSchoolIDs = Array(Set(schoolIDs)) // remove duplicates

            // If no liked schools, just finish
            if uniqueSchoolIDs.isEmpty {
                likedSchools = []
                isLoading = false
                return
            }

            // 3) Fetch the actual School records from "schools"
            //    We'll do an ".in()" query. 
            //    Adjust the column name if your schools table calls it "id" or "school_id" differently.
            //    Because your `School.id` is a `UUID`, and you store them as text in DB, you might need to map to strings or do a raw query.
            let fetchedSchools: [School] = try await supabase
                .from("schools")
                .select()
                .in("id", values: uniqueSchoolIDs.map { $0.uuidString })
                .execute()
                .value

            // 4) Update our published list
            self.likedSchools = fetchedSchools
            
        } catch {
            self.errorMessage = "Failed to load liked schools: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
