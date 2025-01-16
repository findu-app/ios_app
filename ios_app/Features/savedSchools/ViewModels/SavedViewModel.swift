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
    
    func sortLikedSchools(by field: SortField, ascending: Bool) {
        switch field {
        case .name:
            likedSchools.sort {
                ascending ? $0.name < $1.name : $0.name > $1.name
            }
        case .averageDebt:
            likedSchools.sort {
                ascending ? ($0.averageDebt ?? 0) < ($1.averageDebt ?? 0) : ($0.averageDebt ?? 0) > ($1.averageDebt ?? 0)
            }
        case .admissionsRate:
            likedSchools.sort {
                ascending ? ($0.admissionsRate ?? 0) < ($1.admissionsRate ?? 0) : ($0.admissionsRate ?? 0) > ($1.admissionsRate ?? 0)
            }
        case .actScore:
            likedSchools.sort {
                ascending ? ($0.actScore ?? 0) < ($1.actScore ?? 0) : ($0.actScore ?? 0) > ($1.actScore ?? 0)
            }
        case .satScore:
            likedSchools.sort {
                ascending ? ($0.satScore ?? 0) < ($1.satScore ?? 0) : ($0.satScore ?? 0) > ($1.satScore ?? 0)
            }
        case .averageAid:
            likedSchools.sort {
                ascending ? ($0.averageFinancialAid ?? 0) < ($1.averageFinancialAid ?? 0) : ($0.averageFinancialAid ?? 0) > ($1.averageFinancialAid ?? 0)
            }
        case .averageNetPrice:
            likedSchools.sort {
                let netPrice1 = $0.averageNetPricePublic ?? $0.averageNetPricePrivate ?? 0
                let netPrice2 = $1.averageNetPricePublic ?? $1.averageNetPricePrivate ?? 0
                return ascending ? netPrice1 < netPrice2 : netPrice1 > netPrice2
            }
        case .costOfAttendance:
            likedSchools.sort {
                ascending ? ($0.coaAcademicYear ?? 0) < ($1.coaAcademicYear ?? 0) : ($0.coaAcademicYear ?? 0) > ($1.coaAcademicYear ?? 0)
            }
        case .inStateTuition:
            likedSchools.sort {
                ascending ? ($0.inStateTuition ?? 0) < ($1.inStateTuition ?? 0) : ($0.inStateTuition ?? 0) > ($1.inStateTuition ?? 0)
            }
        case .outStateTuition:
            likedSchools.sort {
                ascending ? ($0.outStateTuition ?? 0) < ($1.outStateTuition ?? 0) : ($0.outStateTuition ?? 0) > ($1.outStateTuition ?? 0)
            }
        case .size:
            likedSchools.sort {
                ascending ? ($0.size ?? 0) < ($1.size ?? 0) : ($0.size ?? 0) > ($1.size ?? 0)
            }
        case .studentToFacultyRatio:
            likedSchools.sort {
                ascending ? ($0.studentToFacultyRatio ?? 0) < ($1.studentToFacultyRatio ?? 0) : ($0.studentToFacultyRatio ?? 0) > ($1.studentToFacultyRatio ?? 0)
            }
        }
    }

}

enum SortField {
    case name
    case averageDebt
    case admissionsRate
    case actScore
    case satScore
    case averageAid
    case averageNetPrice
    case costOfAttendance
    case inStateTuition
    case outStateTuition
    case size
    case studentToFacultyRatio
}
