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
            // Fetch all interactions for this student where liked == true
            let interactions: [StudentSchoolInteraction] = try await supabase
                .from("student_school_interactions")
                .select()
                .eq("student_id", value: studentProfile.id)
                .eq("liked", value: true)
                .execute()
                .value

            // Extract unique school IDs
            let schoolIDs = interactions.map { $0.schoolId }
            let uniqueSchoolIDs = Array(Set(schoolIDs))

            // If no liked schools, just finish
            if uniqueSchoolIDs.isEmpty {
                likedSchools = []
                isLoading = false
                return
            }

            // Fetch the actual School records from "schools"
            let fetchedSchools: [School] = try await supabase
                .from("schools")
                .select()
                .in("id", values: uniqueSchoolIDs.map { $0.uuidString })
                .execute()
                .value

            // Update our published list
            self.likedSchools = fetchedSchools
            
        } catch {
            self.errorMessage = "Failed to load liked schools: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
