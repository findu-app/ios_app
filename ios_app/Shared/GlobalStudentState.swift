//
//  GlobalStudentState.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

class GlobalStudentState: ObservableObject {
    @Published var studentInfo: StudentInfo? {
        didSet {
            saveToUserDefaults()
        }
    }

    private let userDefaultsKey = "StudentInfo"

    init() {
        loadFromUserDefaults()
    }

    /// Saves the transformed StudentInfo object to UserDefaults
    func saveStudentInfo(from studentInfo: StudentInfo) {
        self.studentInfo = studentInfo
    }

    /// Encodes and saves `StudentInfo` to UserDefaults
    private func saveToUserDefaults() {
        guard let studentInfo = studentInfo else {
            UserDefaults.standard.removeObject(forKey: userDefaultsKey)
            return
        }

        do {
            let data = try JSONEncoder().encode(studentInfo)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Error saving student info: \(error)")
        }
    }

    /// Loads `StudentInfo` from UserDefaults
    private func loadFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return }

        do {
            studentInfo = try JSONDecoder().decode(StudentInfo.self, from: data)
        } catch {
            print("Error loading student info: \(error)")
        }
    }
}
