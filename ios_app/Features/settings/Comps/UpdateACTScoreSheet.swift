//
//  UpdateACTScoreSheet.swift
//  ios_app
//
//  Created by Kenny Morales on 1/15/25.
//


import Supabase
import SwiftUI

struct UpdateACTScoreSheet: View {
    let currentACTScore: Int
    var onSave: (Int) -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var actScore: String
    @State private var isUpdating: Bool = false
    @State private var errorMessage: String? = nil

    init(currentACTScore: Int, onSave: @escaping (Int) -> Void) {
        self.currentACTScore = currentACTScore
        self.onSave = onSave
        self._actScore = State(initialValue: String(currentACTScore))
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
                    Text("ACT Score")
                        .font(.custom("Plus Jakarta Sans Regular", size: 14))
                        .foregroundColor(.gray)

                    TextField("Enter your ACT score", text: $actScore)
                        .keyboardType(.numberPad)
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
                        await updateACTScore()
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

    private func updateACTScore() async {
        isUpdating = true
        errorMessage = nil

        guard let score = Int(actScore), score >= 0 && score <= 36 else {
            errorMessage = "Please enter a valid ACT score between 0 and 36."
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

            let updates = ["act_score": score]
            let response =
                try await supabase
                .from("students")
                .update(updates)
                .eq("user_id", value: userId)
                .execute()

            onSave(score) // Pass updated ACT score back
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = "Failed to update ACT score. Please try again."
        }

        isUpdating = false
    }
}
