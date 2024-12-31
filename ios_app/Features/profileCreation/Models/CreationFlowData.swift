//
//  CreationFlowData.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

// Holds user input data for the flow
struct CreationFlowData {
    var studentName: String = ""
    var studentGender: String = ""
    var studentPhone: String = ""
    var studentContactMethod: String = ""
    var studentAddress: String = ""
    var studentHSName: String = ""
    var studentHSAddress: String = ""
    var studentHSGradYear: String = ""
    var studentHHIncome: String = ""
    var studentAidNeed: String = ""
    var studentGPA: String = ""
    var studentACT: String = ""
    var studentSAT: String = ""
    var isACTNA: Bool = false
    var isSATNA: Bool = false
    var studentClassRank: String = ""
    var studentAPIB: String = ""
    var studentVolunteerHours: String = ""
    var studentActivities: [String] = []
    var studentHobbies: [String] = []
    var studentMajors: [String] = []
    var studentPreferredDistance: String = ""
    var studentPreferredSetting: String = ""
    var studentPreferredSize: String = ""
    var studentRigor: String = ""
    var studentCampusCulture: [String] = []
    var studentSpecialPrograms: String = ""
    var studentGreekLife: String = ""
    var studentResearch: String = ""
}

// Steps structure for navigation
struct CreationFlowSteps {
    static func steps(studentData: Binding<CreationFlowData>) -> [(
        section: String, views: [() -> AnyView]
    )] {
        [
            (
                section: "About Me",
                views: [
                    {
                        AnyView(
                            NameGenderInputView(
                                studentName: studentData.studentName,
                                studentGender: studentData.studentGender))
                    },
                    {
                        AnyView(
                            WelcomeUserView(
                                studentName: studentData.studentName
                                    .wrappedValue))
                    },
                    {
                        AnyView(
                            ContactInputView(
                                studentPhone: studentData.studentPhone,
                                studentContactMethod: studentData
                                    .studentContactMethod))
                    },
                    {
                        AnyView(
                            AddressInputView(
                                studentAddress: studentData.studentAddress))
                    },
                    {
                        AnyView(
                            HSInputView(
                                studentHSName: studentData.studentHSName,
                                studentHSAddress: studentData.studentHSAddress))
                    },
                    {
                        AnyView(
                            HSGradYearInputView(
                                studentHSGradYear: studentData.studentHSGradYear
                            ))
                    },
                    {
                        AnyView(
                            HouseholdInputView(
                                studentHHIncome: studentData.studentHHIncome,
                                studentAidNeed: studentData.studentAidNeed))
                    },
                ]
            ),
            (
                section: "Achievements",
                views: [
                    { AnyView(AchieveUserView()) },
                    {
                        AnyView(
                            StatsInputView(
                                studentGPA: studentData.studentGPA,
                                studentACT: studentData.studentACT,
                                studentSAT: studentData.studentSAT,
                                isACTNA: studentData.isACTNA,
                                isSATNA: studentData.isSATNA
                            ))
                    },
                    {
                        AnyView(
                            ClassRankInputView(
                                studentClassRank: studentData.studentClassRank,
                                studentAPIB: studentData.studentAPIB))
                    },
                    {
                        AnyView(
                            ActivitiesInputView(
                                studentActivities: studentData.studentActivities
                            ))
                    },
                    {
                        AnyView(
                            HobbiesInputView(
                                studentHobbies: studentData.studentHobbies))
                    },
                    {
                        AnyView(
                            VolunteerInputView(
                                studentVolunteerHours: studentData
                                    .studentVolunteerHours))
                    }
                ]
            ),
            (
                section: "Looking For",
                views: [
                    { AnyView(LookingUserView()) },
                    {
                        AnyView(
                            MajorInputView(
                                studentMajors: studentData.studentMajors))
                    },
                    {
                        AnyView(
                            HomeSettingInputView(
                                studentPreferredDistance: studentData
                                    .studentPreferredDistance,
                                studentPreferredSetting: studentData
                                    .studentPreferredSetting))
                    },
                    {
                        AnyView(
                            SizeRigorInputView(
                                studentPreferredSize: studentData
                                    .studentPreferredSize,
                                studentRigor: studentData.studentRigor))
                    },
                    {
                        AnyView(
                            CampusInputView(studentCampusCulture: studentData.studentCampusCulture)
                        )
                    },
                    {
                        AnyView(
                            ProgramsInputView(studentSpecialPrograms: studentData.studentSpecialPrograms, studentGreekLife: studentData.studentGreekLife, studentResearch: studentData.studentResearch)
                        )
                    },
                    {
                        AnyView(
                            FinalUserView()
                        )
                    }
                ]
            ),
        ]
    }
}

extension CreationFlowData {
    func toStudentInfo() -> StudentInfo {
        return StudentInfo(
            name: self.studentName.trimmingCharacters(in: .whitespacesAndNewlines),
            phone: self.studentPhone.trimmingCharacters(in: .whitespacesAndNewlines),
            preferredContactMethod: ContactMethod(rawValue: self.studentContactMethod.trimmingCharacters(in: .whitespacesAndNewlines))!,
            address: self.studentAddress.trimmingCharacters(in: .whitespacesAndNewlines),
            highSchoolName: self.studentHSName.trimmingCharacters(in: .whitespacesAndNewlines),
            highSchoolAddress: self.studentHSAddress.trimmingCharacters(in: .whitespacesAndNewlines),
            graduationYear: GraduationYear(rawValue: Int(self.studentHSGradYear.trimmingCharacters(in: .whitespacesAndNewlines))!)!,
            gender: Gender(rawValue: self.studentGender.trimmingCharacters(in: .whitespacesAndNewlines))!,
            householdIncome: IncomeRange(rawValue: self.studentHHIncome.trimmingCharacters(in: .whitespacesAndNewlines))!,
            financialAidNeed: self.studentAidNeed == "true",
            gpa: Double(self.studentGPA)!,
            actScore: Int(self.studentACT),
            satScore: Int(self.studentSAT),
            classRank: ClassRank(rawValue: self.studentClassRank.trimmingCharacters(in: .whitespacesAndNewlines))!,
            numAPClass: Int(self.studentAPIB)!,
            activities: self.studentActivities.compactMap { Activity(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines)) },
            hobbies: self.studentHobbies.compactMap { Hobby(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines)) },
            volunteerHours: VolunteerHours(rawValue: self.studentVolunteerHours.trimmingCharacters(in: .whitespacesAndNewlines))!,
            majors: self.studentMajors.compactMap { Major(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines)) },
            preferredSize: PreferredSize(rawValue: self.studentPreferredSize.trimmingCharacters(in: .whitespacesAndNewlines))!,
            distanceFromHome: PreferredDistance(rawValue: self.studentPreferredDistance.trimmingCharacters(in: .whitespacesAndNewlines))!,
            preferredSetting: self.studentPreferredSetting.split(separator: ",").compactMap { PreferredSetting(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines)) },
            rigor: Rigor(rawValue: self.studentRigor.trimmingCharacters(in: .whitespacesAndNewlines))!,
            specialPrograms: Bool(self.studentSpecialPrograms) ?? false,
            campusCulturePreferences: self.studentCampusCulture.compactMap { CampusCulture(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines)) },
            greekLifeInterest: Bool(self.studentGreekLife) ?? false,
            researchInterest: Bool(self.studentResearch) ?? false
        )
    }
}
