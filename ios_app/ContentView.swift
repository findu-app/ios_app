//
//  ContentView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//

//
//  AppView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/28/24.
//


import SwiftUI

struct ContentView: View {
  @State var isAuthenticated = false
    
@EnvironmentObject var globalStudentState: GlobalStudentDataState


  var body: some View {
    Group {
      if isAuthenticated {
          if globalStudentState.studentInfo == nil {
              StudentProfileCreationFlow()
          } else {
//              HomeView()
          }
      } else {
        WelcomeView()
      }
    }
    .task {
        for await state in supabase.auth.authStateChanges {
            if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                isAuthenticated = state.session != nil
                
                if let userId = state.session?.user.id.uuidString, isAuthenticated {
                    do {
                        if let studentProfile = try await fetchStudentProfile(userId: userId) {
                            globalStudentState.studentInfo = studentProfile
                        }
                    } catch {
                        print("Failed to fetch student profile: \(error)")
                    }
                }
            }
        }
    }
  }
}

private func fetchStudentProfile(userId: String) async throws -> StudentInfo? {
    let client = supabase
    let table = client.from("students")
    
    let response = try await table
        .select()
        .eq("user_id", value: userId)
        .single()
        .execute()
    
    guard let jsonData = response.data as? Data else {
        print("Unexpected response data type:", response.data ?? "nil")
        return nil
    }
    
    do {
        let decoder = JSONDecoder()
        let studentInfo = try decoder.decode(StudentInfo.self, from: jsonData)
        return studentInfo
    } catch {
        print("Error decoding student info:", error)
        throw error
    }
}


#Preview {
    ContentView()
}
