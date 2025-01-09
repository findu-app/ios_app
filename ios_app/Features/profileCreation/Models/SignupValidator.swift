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
    func validate(section: String, substepIndex: Int, data: StudentProfileData)
        -> Bool
    {
        switch section {
        case "About Me":
            switch substepIndex {
            case 0:  // NameGenderInputView
                return !data.name.isEmpty && !data.gender.isEmpty
            case 1:  // WelcomeUserView
                return true  // No validation required for WelcomeUserView
            case 2: // Ethnicity
                return !data.ethnicity.isEmpty
            case 3:  // ContactInputView
                return data.phone.count == 10
                    && !data.preferredContactMethod.isEmpty
            case 4:  // AddressInputView
                return !data.address.isEmpty
            case 5:  // HSInputView
                return !data.highSchoolName.isEmpty
                    && !data.highSchoolAddress.isEmpty
            case 6:  // HSGradYearInputView
                return !data.graduationYear.isEmpty
            case 7:  // HouseholdInputView
                return !data.householdIncome.isEmpty
                    && !data.financialAidNeed.isEmpty
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
                return !data.classRank.isEmpty
                    && !data.numAPClass.isEmpty
            case 3:  // ActivitiesInputView
                return data.activities.count >= 3
            case 4:  // HobbiesInputView
                return data.hobbies.count >= 3
            case 5:  // VolunteerInputView
                return !data.volunteerHours.isEmpty
            default:
                return true
            }
        case "Looking For":
            switch substepIndex {
            case 0:  // LookingUserView
                return true  // No validation required
            case 1:  // MajorInputView
                return data.majors.count >= 3
            case 2:  // HomeSettingInputView
                return !data.distanceFromHome.isEmpty
                    && !data.preferredSetting.isEmpty
            case 3:  // SizeRigorInputView
                return !data.preferredSize.isEmpty
                    && !data.rigor.isEmpty
            case 4:  // CampusInputView
                return data.campusCulturePreferences.count >= 3
            case 5:  // ProgramsInputView
                return !data.specialPrograms.isEmpty
                    && !data.greekLifeInterest.isEmpty
                    && !data.researchInterest.isEmpty
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
    private func validateStatsInput(data: StudentProfileData) -> Bool {
        let isACTValid =
            data.isACTNA
            || (!data.actScore.isEmpty && Int(data.actScore) != nil)
        let isSATValid =
            data.isSATNA
            || (!data.satScore.isEmpty && Int(data.satScore) != nil)
        return !data.gpa.isEmpty && Double(data.gpa) != nil
            && isACTValid && isSATValid
    }
}
