//
//  StudentInfo.swift
//  ios_app
//
//  Created by Kenny Morales on 12/29/24.
//

import Foundation

struct StudentInfo: Codable {
    // MARK: - About You
    var name: String
    var phone: String
    var preferredContactMethod: ContactMethod
    var address: String
    var highSchoolName: String
    var highSchoolAddress: String
    var graduationYear: GraduationYear
    var gender: Gender
    var householdIncome: IncomeRange
    var financialAidNeed: Bool

    // MARK: - Achievements
    var gpa: Double
    var actScore: Int?
    var satScore: Int?
    var classRank: ClassRank
    var numAPClass: Int
    var activities: [Activity]
    var hobbies: [Hobby]
    var volunteerHours: VolunteerHours

    // MARK: - Looking For
    var majors: [Major]
    var preferredSize: PreferredSize
    var distanceFromHome: PreferredDistance
    var preferredSetting: [PreferredSetting]
    var rigor: Rigor
    var specialPrograms: Bool
    var campusCulturePreferences: [CampusCulture]
    var greekLifeInterest: Bool
    var researchInterest: Bool
}

// MARK: - Supporting Enums
enum Gender: String, CaseIterable, Codable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

enum ContactMethod: String, CaseIterable, Codable {
    case email = "Email"
    case phone = "Phone"
    case messages = "Messages"
}

enum GraduationYear: Int, CaseIterable, Codable {
    case year2023 = 2023
    case year2024 = 2024
    case year2025 = 2025
    case year2026 = 2026
    case year2027 = 2027
    case year2028 = 2028
}

enum IncomeRange: String, CaseIterable, Codable {
    case under65000 = "Under 65,000"
    case between65000And120000 = "65,000 - 120,000"
    case over120000 = "Over 120,000"
}

enum LearningStyle: String, CaseIterable, Codable {
    case handsOn = "Hands-On"
    case lectureBased = "Lecture-Based"
    case collaborative = "Collaborative"
}

enum ClassRank: String, CaseIterable, Codable {
    case top5Percent = "Top 5%"
    case notSure = "Top 10%"
    case other = "Other"
}

enum VolunteerHours: String, CaseIterable, Codable {
    case lessThan10 = "Less than 10 hours"
    case between10And50 = "10-50 hours"
    case between50And100 = "50-100 hours"
    case over100 = "Over 100 hours"
}

enum PreferredDistance: String, CaseIterable, Codable {
    case within100Miles = "Within 100 Miles"
    case within500Miles = "Within 500 Miles"
    case anyDistance = "Any Distance"
}

enum PreferredSize: String, CaseIterable, Codable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

enum PreferredSetting: String, CaseIterable, Codable {
    case urban = "Urban"
    case suburban = "Suburban"
    case rural = "Rural"
}

enum Rigor: String, CaseIterable, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

enum Activity: String, CaseIterable, Codable {
    // Sports
    case hockey = "🏑   Hockey"
    case soccer = "⚽   Soccer"
    case basketball = "🏀   Basketball"
    case football = "🏈   Football"
    case baseball = "⚾   Baseball"
    case softball = "🥎   Softball"
    case tennis = "🎾   Tennis"
    case swimming = "🏊   Swimming"
    case trackAndField = "🏃   Track & Field"
    case crossCountry = "🏃‍♀️   Cross Country"
    case volleyball = "🏐   Volleyball"
    case wrestling = "🤼   Wrestling"
    case golf = "⛳   Golf"
    case cheerleading = "📣   Cheerleading"
    case dance = "💃   Dance"
    case skiing = "🎿   Skiing"
    case snowboarding = "🏂   Snowboarding"
    case skateboarding = "🛹   Skateboarding"
    case rowing = "🚣   Rowing"
    case surfing = "🏄   Surfing"
    case rockClimbing = "🧗   Rock Climbing"
    case martialArts = "🥋   Martial Arts"
    case weightlifting = "🏋️   Weightlifting"
    case gymnastics = "🤸   Gymnastics"
    case iceHockey = "🏒   Ice Hockey"
    case lacrosse = "🥍   Lacrosse"
    case ultimateFrisbee = "🥏   Ultimate Frisbee"

    // Performing Arts
    case band = "🎺   Band"
    case orchestra = "🎻   Orchestra"
    case choir = "🎤   Choir"
    case drama = "🎭   Drama"
    case musicalTheater = "🎶   Musical Theater"
    case danceTeam = "🩰   Dance Team"
    case dramaTech = "🔧   Drama Tech Crew"
    case spokenWord = "📜   Spoken Word"
    case improvComedy = "🎙️   Improv Comedy"

    // Academic Clubs
    case debate = "🗣️   Debate"
    case studentGovernment = "🏛️   Student Government"
    case robotics = "🤖   Robotics"
    case scienceClub = "🔬   Science Club"
    case mathTeam = "➗   Math Team"
    case codingClub = "💻   Coding Club"
    case environmentalClub = "🌱   Environmental Club"
    case modelUN = "🌍   Model UN"
    case historyClub = "📚   History Club"
    case philosophyClub = "🤔   Philosophy Club"
    case businessClub = "📈   Business Club"
    case languageClub = "🌍   Language Club"
    case astronomyClub = "🌌   Astronomy Club"

    // Arts & Creativity
    case artClub = "🎨   Art Club"
    case creativeWriting = "✍️   Creative Writing"
    case photography = "📷   Photography"
    case filmmaking = "🎥   Filmmaking"
    case yearbook = "📓   Yearbook"
    case journalism = "📰   Journalism"
    case culinaryArts = "🍳   Culinary Arts"
    case knitting = "🧶   Knitting"
    case ceramics = "🏺   Ceramics"
    case woodworking = "🪚   Woodworking"

    // Hobbies & Lifestyle
    case gardening = "🌼   Gardening"
    case esports = "🎮   Esports"
    case hiking = "🥾   Hiking"
    case cycling = "🚴   Cycling"
    case fishing = "🎣   Fishing"
    case bowling = "🎳   Bowling"
    case camping = "🏕️   Camping"
    case chessClub = "♟️   Chess Club"
    case boardGames = "🎲   Board Games"
    case volunteering = "🤲   Volunteering"
    case scouting = "⛺   Scouting"
    case parkour = "🤸‍♂️   Parkour"
    case droneRacing = "🛸   Drone Racing"

    // Miscellaneous
    case firstAidClub = "🩺   First Aid Club"
    case carRepair = "🚗   Car Repair Club"
    case communityService = "🌟   Community Service"
    case podcasting = "🎙️   Podcasting"
    case triviaClub = "❓   Trivia Club"
    case magicClub = "🪄   Magic Club"
    case animalCare = "🐾   Animal Care Club"
    case cosplay = "🎭   Cosplay Club"
    case programmingContests = "🖥️   Programming Contests"
}

enum Hobby: String, CaseIterable, Codable {
    // Sports & Outdoor
    case hiking = "🥾   Hiking"
    case cycling = "🚴   Cycling"
    case fishing = "🎣   Fishing"
    case camping = "🏕️   Camping"
    case gardening = "🌼   Gardening"
    case birdWatching = "🦜   Bird Watching"
    case rockClimbing = "🧗   Rock Climbing"
    case skiing = "🎿   Skiing"
    case snowboarding = "🏂   Snowboarding"
    case skateboarding = "🛹   Skateboarding"
    case archery = "🏹   Archery"

    // Arts & Creativity
    case painting = "🎨   Painting"
    case drawing = "✏️   Drawing"
    case sculpting = "🪨   Sculpting"
    case photography = "📷   Photography"
    case filmmaking = "🎥   Filmmaking"
    case musicComposition = "🎼   Music Composition"
    case knitting = "🧶   Knitting"
    case sewing = "🧵   Sewing"
    case woodworking = "🪚   Woodworking"
    case jewelryMaking = "💎   Jewelry Making"
    case calligraphy = "✒️   Calligraphy"

    // Performing Arts
    case singing = "🎤   Singing"
    case dancing = "💃   Dancing"
    case acting = "🎭   Acting"
    case standUpComedy = "🎙️   Stand-Up Comedy"
    case playingInstruments = "🎹   Playing Instruments"
    case djing = "🎧   DJing"

    // Technology & Gaming
    case coding = "💻   Coding"
    case gaming = "🎮   Gaming"
    case threeDPrinting = "🖨️   3D Printing"
    case robotics = "🤖   Robotics"
    case droneFlying = "🛸   Drone Flying"
    case podcasting = "🎙️   Podcasting"
    case webDesign = "🌐   Web Design"
    case animation = "🎞️   Animation"

    // Literature & Writing
    case creativeWriting = "✍️   Creative Writing"
    case poetry = "📜   Poetry"
    case journaling = "📓   Journaling"
    case bookClubs = "📚   Book Clubs"
    case blogging = "🌟   Blogging"

    // Indoor & Social
    case boardGames = "🎲   Board Games"
    case chess = "♟️   Chess"
    case cooking = "🍳   Cooking"
    case baking = "🧁   Baking"
    case trivia = "❓   Trivia"
    case escapeRooms = "🗝️   Escape Rooms"
    case cardGames = "🃏   Card Games"
    case puzzles = "🧩   Puzzles"

    // Fitness & Health
    case yoga = "🧘   Yoga"
    case weightlifting = "🏋️   Weightlifting"
    case running = "🏃   Running"
    case swimming = "🏊   Swimming"
    case martialArts = "🥋   Martial Arts"
    case pilates = "🪑   Pilates"

    // Community & Volunteer
    case volunteering = "🤲   Volunteering"
    case mentoring = "🧑‍🏫   Mentoring"
    case charityEvents = "🌟   Charity Events"

    // Miscellaneous
    case cosplay = "🎭   Cosplay"
    case magic = "🪄   Magic Tricks"
    case collecting = "🗂️   Collecting (Coins, Stamps)"
    case astrology = "🔮   Astrology"
    case meditation = "🧘‍♂️   Meditation"
    case petCare = "🐾   Pet Care"
    case modelBuilding = "✈️   Model Building (Planes, Cars)"
    case languageLearning = "🌍   Language Learning"
}

enum Major: String, CaseIterable, Codable {
    case computerScience = "💻   Computer Science"
    case engineering = "🛠️   Engineering"
    case business = "📈   Business"
    case biology = "🔬   Biology"
    case chemistry = "⚗️   Chemistry"
    case physics = "🌌   Physics"
    case mathematics = "➗   Mathematics"
    case english = "📚   English"
    case history = "🏺   History"
    case psychology = "🧠   Psychology"
    case politicalScience = "🏛️   Political Science"
    case economics = "💰   Economics"
    case nursing = "💉   Nursing"
    case education = "🎓   Education"
    case art = "🎨   Art"
    case music = "🎵   Music"
    case theater = "🎭   Theater"
    case environmentalScience = "🌱   Environmental Science"
    case sociology = "🤝   Sociology"
    case anthropology = "🏕️   Anthropology"
    case journalism = "📰   Journalism"
    case marketing = "📊   Marketing"
    case architecture = "🏛️   Architecture"
    case law = "⚖️   Law"
    case medicine = "🩺   Medicine"
    case pharmacy = "💊   Pharmacy"
    case design = "🎨   Design"
    case film = "🎥   Film"
    case fashion = "👗   Fashion"
    case linguistics = "🗣️   Linguistics"
}

enum CampusCulture: String, CaseIterable, Codable {
    // Religious or Faith-Based
    case christian = "✝️   Christian"
    case jewish = "✡️   Jewish"
    case muslim = "🕌   Muslim"
    case hindu = "🕉️   Hindu"
    case buddhist = "☸️   Buddhist"

    // Inclusivity and Diversity
    case lgbtq = "🏳️‍🌈   LGBTQ"
    case inclusive = "🤝   Inclusive"
    case minorityFocused = "✊   Minority"
    case international = "🌏   Global"

    // Social and Cultural
    case party = "🎉   Party"
    case artsy = "🎨   Artsy"
    case greek = "🏛️   Greek"
    case commuter = "🚌   Commuter"
    case tightKnit = "🤗   Tight"
    case diverse = "🌍   Diverse"
    case rural = "🌾   Rural"
    case urban = "🏙️   Urban"
    case quiet = "🌲   Quiet"
    case familyFriendly = "👨‍👩‍👧‍👦   Family"
    case political = "🏛️   Political"

    // Academic and Professional
    case academic = "📚   Academic"
    case research = "🔬   Research"
    case entrepreneurial = "💡   Startup"
    case preMed = "🩺   Pre-Med"
    case preLaw = "⚖️   Pre-Law"
    case stem = "⚙️   STEM"
    case humanities = "📜   History"
    case fineArts = "🎭   Arts"
    case vocational = "🛠️   Trade"
    case innovative = "🚀   Innovate"

    // Miscellaneous
    case military = "🎖️   Military"
    case career = "💼   Career"
    case studentLed = "🗣️   Student"
    case community = "🏡   Community"
    case language = "🗣️   Language"
    case tech = "💻   Tech"
    case firstGen = "🎓   First-Gen"
    case mentalHealth = "🧠   Health"
}
