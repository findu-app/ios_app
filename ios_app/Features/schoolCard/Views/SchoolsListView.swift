struct SchoolsListView: View {
    @State private var schools: [School] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        ForEach(schools, id: \.id) { school in
                            SchoolCardView(school: school)
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                        }
                    }
                }
            }
            .onAppear {
                fetchSchools()
            }
            .navigationTitle("Colleges")
        }
    }

    private func fetchSchools() {
        isLoading = true
        errorMessage = nil
        CollegeAPI.shared.fetchSchools(query: "Harvard University") { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let schools):
                    self.schools = schools
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
