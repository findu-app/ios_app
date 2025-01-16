//
//  UpdateSATScoreSheet.swift
//  ios_app
//
//  Created by Kenny Morales on 1/15/25.
//


import Supabase
import SwiftUI

struct UpdateSATScoreSheet: View {
    let currentSATScore: Int
    var onSave: (Int) -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var satScore: String
    @State private var isUpdating: Bool = false
    @State private var errorMessage: String? = nil

    init(currentSATScore: Int, onSave: @escaping (Int) -> Void) {
        self.currentSATScore = currentSATScore
        self.onSave = onSave
        self._satScore = State(initialValue: String(currentSATScore))
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
                    Text("SAT Score")
                        .font(.custom("Plus Jakarta Sans Regular", size: 14))
                        .foregroundColor(.gray)

                    TextField("Enter your SAT score", text: $satScore)
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
                        await updateSATScore()
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

    private func updateSATScore() async {
        isUpdating = true
        errorMessage = nil

        guard let score = Int(satScore), score >= 400 && score <= 1600 else {
            errorMessage = "Please enter a valid SAT score between 400 and 1600."
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

            let updates = ["sat_score": score]
            let response =
                try await supabase
                .from("students")
                .update(updates)
                .eq("user_id", value: userId)
                .execute()

            onSave(score) // Pass updated SAT score back
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = "Failed to update SAT score. Please try again."
        }

        isUpdating = false
    }
}
