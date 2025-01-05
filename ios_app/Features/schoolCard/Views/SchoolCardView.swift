import SwiftUI

struct SchoolCardView: View {
    let school: School

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(school.name)
                .font(.headline)
            if let city = school.city, let state = school.state {
                Text("\(city), \(state)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            if let size = school.size {
                Text("Student Size: \(size)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
