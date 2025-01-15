import SwiftUI

struct AboutAppView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Back Button + Title
            HStack {
                Button(action: {
                    // Handle back navigation (use NavigationLink if necessary)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Text("Settings")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 18))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.bottom, 16)

            // Section Title
            Text("About the app")
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                .foregroundColor(.black)
                .padding(.bottom, 8)

            // Content Box
            Text("""
            Hey, we are the developers of FindU! We are both college students and are passionate about creating innovative solutions that help people connect and find new friends on campus.

            Our goal is to make socializing easier and more enjoyable for everyone.
            """)
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                )

            Spacer()
        }
        .padding()
        .background(Color("Background")) // Replace with your theme color
        .navigationBarHidden(true)       // Hide default navigation bar
    }
}

#Preview {
    AboutAppView()
}
