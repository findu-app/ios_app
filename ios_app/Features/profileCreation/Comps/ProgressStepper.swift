import SwiftUI

struct ProgressStepper: View {
    var totalSteps: Int // Total number of steps
    var currentStep: Int // Current step index (0-based)

    var body: some View {
        VStack {
            // Progress View
            ProgressView(value: progressValue())
                .progressViewStyle(LinearProgressViewStyle(tint: Color("Primary")))
                .background(Color("SurfaceContainer")) // Background bar color
                .cornerRadius(2)
                .frame(width: .infinity, height: 4)                .animation(.easeInOut(duration: 0.3), value: currentStep)
        }
        .padding(.horizontal).padding(.vertical, 16)
    }

    private func progressValue() -> Double {
        guard totalSteps > 1 else { return 0.0 }
        let progress = Double(currentStep) / Double(totalSteps - 1)
        return min(progress, 0.99)
    }
}

#Preview {
    VStack {
        ProgressStepper(totalSteps: 5, currentStep: 5)
            .padding()
    }
}
