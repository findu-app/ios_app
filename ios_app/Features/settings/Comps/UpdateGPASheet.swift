//
//  UpdateGPASheet.swift
//  ios_app
//
//  Created by Kenny Morales on 1/15/25.
//


import Supabase
import SwiftUI

struct UpdateGPASheet: View {
    let currentGPA: Double
    var onSave: (Double) -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var gpa: String
    @State private var isUpdating: Bool = false
    @State private var errorMessage: String? = nil

    init(currentGPA: Double, onSave: @escaping (Double) -> Void) {
        self.currentGPA = currentGPA
        self.onSave = onSave
        self._gpa = State(initialValue: String(format: "%.2f", currentGPA))
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
                    Text("GPA")
                        .font(.custom("Plus Jakarta Sans Regular", size: 14))
                        .foregroundColor(.gray)

                    TextField("Enter your GPA", text: $gpa)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Spacer()

                Button(action: {
                    Task {
                        await updateGPA()
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

    private func updateGPA() async {
        isUpdating = true
        errorMessage = nil

        guard let gpaValue = Double(gpa), gpaValue >= 0.0 && gpaValue <= 5.0 else {
            errorMessage = "Please enter a valid GPA between 0.0 and 5.0."
            isUpdating = false
            return
        }

        do {
            guard let userId = supabase.auth.currentUser?.id else {
                throw NSError(
                    domain: "", code: 401,
                    userInfo: [
                        NSLocalizedDescriptionKey: "User not authenticated"
                    ]
                )
            }

            let updates = ["gpa": gpaValue]
            let response =
                try await supabase
                .from("students")
                .update(updates)
                .eq("user_id", value: userId)
                .execute()

            onSave(gpaValue) // Pass updated GPA back
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = "Failed to update GPA. Please try again."
        }

        isUpdating = false
    }
}
