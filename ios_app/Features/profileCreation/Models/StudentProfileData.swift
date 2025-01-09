//
//  CreationFlowData.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

// Holds user input data for the flow
struct StudentProfileData {
    // MARK: - About You
    var name: String = ""
    var phone: String = ""
    var preferredContactMethod: String = ""
    var address: String = ""
    var highSchoolName: String = ""
    var highSchoolAddress: String = ""
    var graduationYear: String = ""
    var gender: String = ""
    var ethnicity: String = ""
    var householdIncome: String = ""
    var financialAidNeed: String = ""

    // MARK: - Achievements
    var gpa: String = ""
    var actScore: String = ""
    var satScore: String = ""
    var isACTNA: Bool = false
    var isSATNA: Bool = false
    var classRank: String = ""
    var numAPClass: String = ""
    var activities: [String] = []
    var hobbies: [String] = []
    var volunteerHours: String = ""

    // MARK: - Looking For
    var majors: [String] = []
    var preferredSize: String = ""
    var distanceFromHome: String = ""
    var preferredSetting: String = ""
    var rigor: String = ""
    var specialPrograms: String = ""
    var campusCulturePreferences: [String] = []
    var greekLifeInterest: String = ""
    var researchInterest: String = ""
}

// Steps structure for navigation
struct CreationFlowSteps {
    static func steps(studentData: Binding<StudentProfileData>) -> [(
        section: String, views: [() -> AnyView]
    )] {
        [
            (
                section: "About Me",
                views: [
                    {
                        AnyView(
                            NameGenderEntryView(
                                name: studentData.name,
                                gender: studentData.gender))
                    },
                    {
                        AnyView(
                            AboutMeIntroView(
                                name: studentData.name
                                    .wrappedValue))
                    },
                    {
                        AnyView(
                            EthnicityEntryView(
                                ethnicity: studentData.ethnicity
                        ))
                    },
                    {
                        AnyView(
                            ContactDetailsEntryView(
                                phone: studentData.phone,
                                preferredContactMethod: studentData
                                    .preferredContactMethod))
                    },
                    {
                        AnyView(
                            AddressEntryView(
                                address: studentData.address))
                    },
                    {
                        AnyView(
                            HighSchoolDetailsEntryView(
                                highSchoolName: studentData.highSchoolName,
                                highSchoolAddress: studentData.highSchoolAddress
                            )
                        )
                    },
                    {
                        AnyView(
                            GraduationYearEntryView(
                                graduationYear: studentData.graduationYear
                            ))
                    },
                    {
                        AnyView(
                            HouseholdDetailsEntryView(
                                householdIncome: studentData.householdIncome,
                                financialAidNeed: studentData.financialAidNeed))
                    },
                ]
            ),
            (
                section: "Achievements",
                views: [
                    { AnyView(AchievementsIntroView()) },
                    {
                        AnyView(
                            StatsEntryView(
                                gpa: studentData.gpa,
                                actScore: studentData.actScore,
                                satScore: studentData.satScore,
                                isACTNA: studentData.isACTNA,
                                isSATNA: studentData.isSATNA
                            ))
                    },
                    {
                        AnyView(
                            ClassRankAndAPIBEntryView(
                                classRank: studentData.classRank,
                                numAPClass: studentData.numAPClass))
                    },
                    {
                        AnyView(
                            ActivitiesSelectionView(
                                activities: studentData.activities
                            ))
                    },
                    {
                        AnyView(
                            HobbiesSelectionView(
                                hobbies: studentData.hobbies))
                    },
                    {
                        AnyView(
                            VolunteerEntryView(
                                volunteerHours: studentData
                                    .volunteerHours))
                    },
                ]
            ),
            (
                section: "Looking For",
                views: [
                    { AnyView(LookingForIntroView()) },
                    {
                        AnyView(
                            MajorSelectionView(
                                majors: studentData.majors))
                    },
                    {
                        AnyView(
                            HomePreferencesEntryView(
                                distanceFromHome: studentData
                                    .distanceFromHome,
                                preferredSetting: studentData
                                    .preferredSetting))
                    },
                    {
                        AnyView(
                            SizeRigorEntryView(
                                preferredSize: studentData
                                    .preferredSize,
                                rigor: studentData.rigor))
                    },
                    {
                        AnyView(
                            CampusCultureSelectionView(
                                campusCulturePreferences: studentData
                                    .campusCulturePreferences)
                        )
                    },
                    {
                        AnyView(
                            ProgramsEntryView(
                                specialPrograms: studentData
                                    .specialPrograms,
                                greekLifeInterest: studentData
                                    .greekLifeInterest,
                                researchInterest: studentData.researchInterest)
                        )
                    },
                    {
                        AnyView(
                            FinalStepCompletionView()
                        )
                    },
                ]
            ),
        ]
    }
}

extension StudentProfileData {
    func toStudentInfo() -> StudentInfo {
        return StudentInfo(
            name: self.name.trimmingCharacters(in: .whitespacesAndNewlines),
            phone: self.phone.trimmingCharacters(in: .whitespacesAndNewlines),
            preferredContactMethod: self.preferredContactMethod.trimmingCharacters(in: .whitespacesAndNewlines),
            address: self.address.trimmingCharacters(in: .whitespacesAndNewlines),
            highSchoolName: self.highSchoolName.trimmingCharacters(in: .whitespacesAndNewlines),
            highSchoolAddress: self.highSchoolAddress.trimmingCharacters(in: .whitespacesAndNewlines),
            graduationYear: Int(self.graduationYear.trimmingCharacters(in: .whitespacesAndNewlines))!,
            gender: self.gender.trimmingCharacters(in: .whitespacesAndNewlines),
            householdIncome: self.householdIncome.trimmingCharacters(in: .whitespacesAndNewlines),
            financialAidNeed: self.financialAidNeed == "true",
            gpa: Double(self.gpa)!,
            actScore: isACTNA ? nil : Int(self.actScore.trimmingCharacters(in: .whitespacesAndNewlines)),
            satScore: isSATNA ? nil : Int(self.satScore.trimmingCharacters(in: .whitespacesAndNewlines)),
            classRank: self.classRank.trimmingCharacters(in: .whitespacesAndNewlines),
            numAPClass: Int(self.numAPClass)!,
            activities: self.activities.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
            hobbies: self.hobbies.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
            volunteerHours: self.volunteerHours.trimmingCharacters(in: .whitespacesAndNewlines),
            majors: self.majors.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
            preferredSize: self.preferredSize.trimmingCharacters(in: .whitespacesAndNewlines),
            distanceFromHome: self.distanceFromHome.trimmingCharacters(in: .whitespacesAndNewlines),
            preferredSetting: self.preferredSetting.trimmingCharacters(in: .whitespacesAndNewlines),
            rigor: self.rigor.trimmingCharacters(in: .whitespacesAndNewlines),
            campusCulturePreferences: self.campusCulturePreferences.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) },
            specialPrograms: Bool(self.specialPrograms) ?? false,
            greekLifeInterest: Bool(self.greekLifeInterest) ?? false,
            researchInterest: Bool(self.researchInterest) ?? false,
            ethnicity: self.ethnicity.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }
}



