//
//  GlobalStudentDataState.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

class GlobalStudentDataState: ObservableObject {
    @Published var studentInfo: StudentInfo? {
        didSet {
            saveToUserDefaults()
        }
    }

    private let userDefaultsKey = "StudentInfo"

    init() {
        loadFromUserDefaults()
    }

    func saveStudentInfo(from studentInfo: StudentInfo) {
        self.studentInfo = studentInfo
    }

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

    private func loadFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return }

        do {
            studentInfo = try JSONDecoder().decode(StudentInfo.self, from: data)
        } catch {
            print("Error loading student info: \(error)")
        }
    }
    
    /// Resets the global state by clearing the studentInfo and removing it from UserDefaults.
    func reset() {
        studentInfo = nil
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        print("Global student state has been reset.")
    }
}

