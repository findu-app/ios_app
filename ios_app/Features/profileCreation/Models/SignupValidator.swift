//
//  SignupValidator.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import Foundation

struct SignupValidator {
    /// Validates the current step based on the section name and substep index.
    /// - Parameters:
    ///   - section: The current section name (e.g., "About Me").
    ///   - substepIndex: The index of the current substep within the section.
    ///   - data: The user input data.
    /// - Returns: `true` if the step is valid, otherwise `false`.
    func validate(section: String, substepIndex: Int, data: CreationFlowData)
        -> Bool
    {
        switch section {
        case "About Me":
            switch substepIndex {
            case 0:  // NameGenderInputView
                return !data.studentName.isEmpty && !data.studentGender.isEmpty
            case 1:  // WelcomeUserView
                return true  // No validation required for WelcomeUserView
            case 2:  // ContactInputView
                return data.studentPhone.count == 10
                    && !data.studentContactMethod.isEmpty
            case 3:  // AddressInputView
                return !data.studentAddress.isEmpty
            case 4:  // HSInputView
                return !data.studentHSName.isEmpty
                    && !data.studentHSAddress.isEmpty
            case 5:  // HSGradYearInputView
                return !data.studentHSGradYear.isEmpty
            case 6:  // HouseholdInputView
                return !data.studentHHIncome.isEmpty
                    && !data.studentAidNeed.isEmpty
            default:
                return true
            }
        case "Achievements":
            switch substepIndex {
            case 0:  // AchieveUserView
                return true  // No validation required
            case 1:  // StatsInputView
                return validateStatsInput(data: data)
            case 2:  // ClassRankInputView
                return !data.studentClassRank.isEmpty
                    && !data.studentAPIB.isEmpty
            case 3:  // ActivitiesInputView
                return data.studentActivities.count >= 3
            case 4:  // HobbiesInputView
                return data.studentHobbies.count >= 3
            case 5:  // VolunteerInputView
                return !data.studentVolunteerHours.isEmpty
            default:
                return true
            }
        case "Looking For":
            switch substepIndex {
            case 0:  // LookingUserView
                return true  // No validation required
            case 1:  // MajorInputView
                return data.studentMajors.count >= 3
            case 2:  // HomeSettingInputView
                return !data.studentPreferredDistance.isEmpty
                    && !data.studentPreferredSetting.isEmpty
            case 3:  // SizeRigorInputView
                return !data.studentPreferredSize.isEmpty
                    && !data.studentRigor.isEmpty
            case 4:  // CampusInputView
                return data.studentCampusCulture.count >= 3
            case 5:  // ProgramsInputView
                return !data.studentSpecialPrograms.isEmpty
                    && !data.studentGreekLife.isEmpty
                    && !data.studentResearch.isEmpty
            case 6:  // FinalUserView
                return true  // No validation required
            default:
                return true
            }
        default:
            return true
        }
    }
    
    /// Validates the StatsInputView fields for GPA, ACT, and SAT.
    /// - Parameter data: The user input data.
    /// - Returns: `true` if the stats input is valid, otherwise `false`.
    private func validateStatsInput(data: CreationFlowData) -> Bool {
        let isACTValid =
            data.isACTNA
            || (!data.studentACT.isEmpty && Int(data.studentACT) != nil)
        let isSATValid =
            data.isSATNA
            || (!data.studentSAT.isEmpty && Int(data.studentSAT) != nil)
        return !data.studentGPA.isEmpty && Double(data.studentGPA) != nil
            && isACTValid && isSATValid
    }
}
