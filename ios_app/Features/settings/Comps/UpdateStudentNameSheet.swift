import Supabase
import SwiftUI

struct UpdateStudentNameSheet: View {
    let currentName: String
    var onSave: (String) -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String
    @State private var isUpdating: Bool = false
    @State private var errorMessage: String? = nil

    init(currentName: String, onSave: @escaping (String) -> Void) {
        self.currentName = currentName
        self.onSave = onSave
        self._name = State(initialValue: currentName)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color("Primary"))
                    }
                }                .padding(.top, 36)


                VStack(alignment: .leading, spacing: 12) {
                    Text("Name")
                        .font(.custom("Plus Jakarta Sans Regular", size: 14))
                        .foregroundColor(.gray)

                    StringTextField(
                        userInput: $name, placeholder: "example@gmail.com")
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                Spacer()

                Button(action: {
                    Task {
                        await updateName()
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
                .background(Color("Surface"))
            }
            .padding()
            .background(Color("Surface"))
        }
    }

    private func updateName() async {
        isUpdating = true
        errorMessage = nil

        do {
            guard let userId = supabase.auth.currentUser?.id else {
                throw NSError(
                    domain: "", code: 401,
                    userInfo: [
                        NSLocalizedDescriptionKey: "User not authenticated"
                    ])
            }

            let updates = ["name": name]
            let response =
                try await supabase
                .from("students")
                .update(updates)
                .eq("user_id", value: userId)
                .execute()

            onSave(name)  // Pass updated name back
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = "Failed to update name. Please try again."
        }

        isUpdating = false
    }
}
