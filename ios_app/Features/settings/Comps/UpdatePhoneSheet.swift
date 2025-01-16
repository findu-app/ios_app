//
//  UpdatePhoneSheet.swift
//  ios_app
//
//  Created by Kenny Morales on 1/15/25.
//


import Supabase
import SwiftUI

struct UpdatePhoneSheet: View {
    let currentPhone: String
    var onSave: (String) -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var phone: String
    @State private var isUpdating: Bool = false
    @State private var errorMessage: String? = nil

    init(currentPhone: String, onSave: @escaping (String) -> Void) {
        self.currentPhone = currentPhone
        self.onSave = onSave
        self._phone = State(initialValue: currentPhone)
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
                }
                .padding(.top, 36)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Phone")
                        .font(.custom("Plus Jakarta Sans Regular", size: 14))
                        .foregroundColor(.gray)

                    PhoneNumberTextField(
                        userInput: $phone,
                        placeholder: "Enter your phone number"
                    )
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Spacer()

                Button(action: {
                    Task {
                        await updatePhone()
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

    private func updatePhone() async {
        isUpdating = true
        errorMessage = nil

        do {
            guard let userId = supabase.auth.currentUser?.id else {
                throw NSError(
                    domain: "", code: 401,
                    userInfo: [
                        NSLocalizedDescriptionKey: "User not authenticated"
                    ]
                )
            }

            let updates = ["phone": phone]
            let response =
                try await supabase
                .from("students")
                .update(updates)
                .eq("user_id", value: userId)
                .execute()

            onSave(phone) // Pass updated phone back
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = "Failed to update phone. Please try again."
        }

        isUpdating = false
    }
}
