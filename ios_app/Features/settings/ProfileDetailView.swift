import SwiftUI

struct ProfileDetailView: View {
    @Binding var isOnSubPage: Bool
    @Binding var studentEmail: String
    @EnvironmentObject var globalStudentState: GlobalStudentDataState
    @Environment(\.presentationMode) var presentationMode

    @State private var activeSheet: SheetType? = nil  // Tracks the active sheet

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Custom Header with Back Button
            HStack {
                Button(action: {
                    isOnSubPage = false
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                        Text("Settings")
                            .font(
                                .custom("Plus Jakarta Sans Regular", size: 16))
                    }
                    .foregroundColor(Color("OnSurface"))
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)

            Text("Profile")
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                .foregroundColor(Color("OnSurface"))
                .padding(.horizontal, 16)
            
            // Profile Section
            List {
                // Account Info Section
                Section(
                    header: Text("Account Info").font(
                        .custom("Plus Jakarta Sans Regular", size: 14)
                    ).foregroundColor(.gray)
                ) {
                    ProfileRow(
                        label: "Name",
                        value: globalStudentState.studentInfo?.name
                            ?? "Kenny Morales",
                        action: {
                            activeSheet = .name
                        }
                    )
                    ProfileRow(
                        label: "Email",
                        value: studentEmail,
                        action: {
                            activeSheet = .email
                        }
                    )
                    ProfileRow(
                        label: "Phone",
                        value: globalStudentState.studentInfo?.phone
                            ?? "(308) - 850 - 6138",
                        action: {
                            activeSheet = .phone
                        }
                    )
                }

                // Academic Scores Section
                Section(
                    header: Text("Academic Scores").font(
                        .custom("Plus Jakarta Sans Regular", size: 14)
                    ).foregroundColor(.gray)
                ) {
                    ProfileRow(
                        label: "ACT",
                        value: String(
                            globalStudentState.studentInfo?.actScore ?? 24),
                        action: {
                            activeSheet = .act
                        }
                    )
                    ProfileRow(
                        label: "SAT",
                        value: String(
                            globalStudentState.studentInfo?.satScore ?? 1200),
                        action: {
                            activeSheet = .sat
                        }
                    )
                    ProfileRow(
                        label: "GPA",
                        value: String(
                            globalStudentState.studentInfo?.gpa ?? 3.8),
                        action: {
                            activeSheet = .gpa
                        })
                }
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(Color("Surface"))
        }
        .navigationBarHidden(true)
        .background(Color("Surface").ignoresSafeArea())
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .name:
                UpdateStudentNameSheet(
                    currentName: globalStudentState.studentInfo?.name ?? "N/A"
                ) { updatedName in
                    globalStudentState.studentInfo?.name = updatedName
                }
            case .email:
                UpdateStudentEmailSheet(studentEmail: $studentEmail)
            case .phone:
                UpdatePhoneSheet(
                    currentPhone: globalStudentState.studentInfo?.phone
                        ?? "(308) - 850 - 6138"
                ) { updatedPhone in
                    globalStudentState.studentInfo?.phone = updatedPhone
                }
            case .act:
                UpdateACTScoreSheet(
                    currentACTScore: globalStudentState.studentInfo?.actScore
                        ?? 24
                ) { updatedACTScore in
                    globalStudentState.studentInfo?.actScore = updatedACTScore
                }
            case .sat:
                UpdateSATScoreSheet(
                    currentSATScore: globalStudentState.studentInfo?.satScore
                        ?? 1200
                ) { updatedSATScore in
                    globalStudentState.studentInfo?.satScore = updatedSATScore
                }
            case .gpa:
                UpdateGPASheet(
                    currentGPA: globalStudentState.studentInfo?.gpa ?? 0.0
                ) { updatedGPA in
                    globalStudentState.studentInfo?.gpa = updatedGPA
                }

            }
        }
    }
}

// Enum for active sheet type
enum SheetType: Identifiable {
    case name, email, phone, act, sat, gpa

    var id: String {
        switch self {
        case .name: return "name"
        case .email: return "email"
        case .phone: return "phone"
        case .act: return "act"
        case .sat: return "sat"
        case .gpa: return "gpa"
        }
    }
}

struct UpdateScoreSheet: View {
    var title: String
    var score: Int
    var body: some View {
        Text("Update \(title): \(score)")
    }
}

struct ProfileRow: View {
    let label: String
    let value: String
    let action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.custom("Plus Jakarta Sans Regular", size: 14))
                    .foregroundColor(Color("Secondary"))
                Text(value)
                    .font(.custom("Plus Jakarta Sans Regular", size: 16))
                    .foregroundColor(Color("OnSurface"))
            }
            Spacer()
            Button(action: action) {
                HStack(spacing: 4) {
                    Text("Edit")
                        .font(.custom("Plus Jakarta Sans Regular", size: 16))
                        .foregroundColor(Color("Secondary"))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(Color("Secondary"))
                }
            }
        }
    }
}
