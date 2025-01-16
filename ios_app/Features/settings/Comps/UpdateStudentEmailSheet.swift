import Supabase
import SwiftUI

struct UpdateStudentEmailSheet: View {
    @Binding var studentEmail: String
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String
    @State private var isUpdating: Bool = false
    @State private var errorMessage: String? = nil

    init(studentEmail: Binding<String>) {
        self._studentEmail = studentEmail
        self._email = State(initialValue: studentEmail.wrappedValue)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color("Primary"))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 36)

                // Input Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Email")
                        .font(.custom("Plus Jakarta Sans Regular", size: 14))
                        .foregroundColor(.gray)

                    StringTextField(
                        userInput: $email, placeholder: "example@gmail.com")

                    Text("You can only change your email twice within 14 days.")
                        .font(.custom("Plus Jakarta Sans Regular", size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Error Message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.custom("Plus Jakarta Sans Regular", size: 12))
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                Spacer()

                // Save Button
                Button(action: {
                    Task {
                        await updateEmail()
                    }
                }) {
                    if isUpdating {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("Primary"))
                            .cornerRadius(12)
                    } else {
                        Text("Save")
                            .font(
                                .custom("Plus Jakarta Sans SemiBold", size: 16)
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color("OnPrimary"))
                            .background(Color("Primary"))
                            .cornerRadius(12)
                    }
                }
                .disabled(isUpdating)
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .background(Color("Surface"))

        }
        .background(Color("Surface"))
    }

    /// Updates the email in Supabase
    private func updateEmail() async {
        isUpdating = true
        errorMessage = nil

        do {
            let userAttributes = UserAttributes(email: email)
            try await supabase.auth.update(user: userAttributes)

            studentEmail = email
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = "Failed to update email. Please try again."
            print("Error updating email: \(error)")
        }

        isUpdating = false
    }
}
