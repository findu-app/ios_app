import SwiftUI

struct SettingsView: View {
    @Binding var isOnSubPage: Bool
    @AppStorage("selectedAppearance") private var selectedAppearance: String =
        "system"
    @EnvironmentObject var globalStudentState: GlobalStudentDataState

    @State private var userId: String = ""
    @State private var userEmail: String = ""
    @State private var isDeletingAccount: Bool = false
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            List {
                // Profile Section
                Section("Profile") {
                    NavigationLink(
                        destination: ProfileDetailView(
                            isOnSubPage: $isOnSubPage,
                            studentEmail: $userEmail
                        )
                        .onAppear { isOnSubPage = true }
                        .onDisappear { isOnSubPage = false }
                    ) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(globalStudentState.studentInfo?.name ?? "N/A")
                                .font(
                                    .custom(
                                        "Plus Jakarta Sans Regular", size: 16))
                            Text(userEmail)
                                .font(
                                    .custom(
                                        "Plus Jakarta Sans Regular", size: 14)
                                )
                                .foregroundColor(Color("Secondary"))
                        }
                    }
                }

                // App Settings Section
                Section("App Settings") {
                    NavigationLink(
                        destination: AppearanceSettingsView(
                            isOnSubPage: $isOnSubPage
                        )
                        .onAppear { isOnSubPage = true }
                        .onDisappear { isOnSubPage = false }
                    ) {
                        HStack {
                            Text("Appearance")
                                .font(
                                    .custom(
                                        "Plus Jakarta Sans Regular", size: 16))
                            Spacer()
                            Text(displayAppearanceText())  // Dynamic appearance
                                .font(
                                    .custom(
                                        "Plus Jakarta Sans Regular", size: 16)
                                )
                                .foregroundColor(Color("Secondary"))
                        }
                    }
                }

                // About FindU Section
                Section("About FindU") {
                    Link(
                        destination: URL(
                            string:
                                "https://findu.notion.site/176756e3cc2780898ddcd7f67a50dc4f?pvs=105"
                        )!
                    ) {
                        Text("Send us feedback!")
                            .font(
                                .custom("Plus Jakarta Sans Regular", size: 16))
                    }
                    NavigationLink(
                        destination: AboutAppView(isOnSubPage: $isOnSubPage)
                            .onAppear { isOnSubPage = true }
                            .onDisappear { isOnSubPage = false }
                    ) {
                        Text("About the app")
                            .font(
                                .custom("Plus Jakarta Sans Regular", size: 16))

                    }
                }
                Section {
                    VStack(spacing: 12) {
                        Button {
                            Task {
                                await signOutUser()
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "door.left.hand.open")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("Secondary"))
                                Text("Sign Out")
                                    .font(
                                        .custom(
                                            "Plus Jakarta Sans Medium",
                                            size: 16)
                                    )
                                    .foregroundColor(Color("Secondary"))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("SurfaceContainer"))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("Border"), lineWidth: 1)
                        )
                    }
                    .listRowInsets(EdgeInsets())
                    .background(Color("Surface"))

                }
            }
            .background(Color("Surface"))
        }
        .listStyle(InsetGroupedListStyle())
        .scrollContentBackground(.hidden)
        .background(Color("Surface"))
        .onAppear {
            fetchUserDetails()
        }
    }

    /// Signs out the current user
    private func signOutUser() async {
        do {
            try await supabase.auth.signOut()
            // Redirect to login or onboarding screen here
            print("User signed out successfully.")
        } catch {
            print("Failed to sign out: \(error)")
        }
    }
    
    /// Fetches the user ID and email from Supabase.
    private func fetchUserDetails() {
        guard let user = supabase.auth.currentUser else {
            print("No user is currently logged in.")
            return
        }

        userId = user.id.uuidString
        userEmail = user.newEmail ?? user.email ?? "No email available"
    }

    /// Dynamically returns the display text for the current appearance mode.
    private func displayAppearanceText() -> String {
        switch selectedAppearance {
        case "dark":
            return "Dark"
        case "light":
            return "Light"
        default:
            return "System"
        }
    }
}
