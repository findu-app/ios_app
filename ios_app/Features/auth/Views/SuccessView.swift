import SwiftUI
import Supabase

struct SuccessView: View {
    @Binding var path: [String]

    func handleSignOut() {
        // Sign out with Supabase
        Task {
            do {
                try await Supabase.auth.signOut()
                path.removeAll()  // Clear the path to reset the navigation stack
                path.append("login")  // Navigate back to login screen
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }

    var body: some View {
        VStack {
            Text("Logged in successfully!")
                .font(.title)
                .fontWeight(.semibold)
                .padding()

            IconButton(iconName: "", text: "Sign Out") {
                handleSignOut()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(false)
    }
}
