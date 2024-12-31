import SwiftUI

struct MultiSelectBtns: View {
    @Binding var selectedOptions: [String] // Holds the selected options
    let options: [String] // Available options

    var body: some View {
        ScrollView {
            WrappingHStack(horizontalSpacing: 10, verticalSpacing: 10) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        toggleSelection(for: option)
                    }) {
                        Text(option)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .font(Font.custom("Plus Jakarta Sans Medium", size: 12))
                            .background(
                                selectedOptions.contains(option)
                                    ? Color("Primary").opacity(0.2)
                                    : Color("SurfaceContainer")
                            )
                            .foregroundColor(
                                selectedOptions.contains(option)
                                    ? Color("Primary")
                                    : Color("OnSurface")
                            )
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        selectedOptions.contains(option)
                                            ? Color("Primary")
                                            : Color("Border"),
                                        lineWidth: 1
                                    )
                            )
                    }
                }
            }
            .padding(.top, 48)
            .padding(.bottom, 64)
        }
    }

    /// Toggles the selection for a given option
    private func toggleSelection(for option: String) {
        if let index = selectedOptions.firstIndex(of: option) {
            // Remove option if already selected
            selectedOptions.remove(at: index)
        } else {
            // Add option to selected list
            selectedOptions.append(option)
        }
    }
}

#Preview {
    MultiSelectBtns(
        selectedOptions: .constant(["🏀   Basketball"]),
        options: Activity.allCases.map { $0.rawValue }
    )
}
