// fields.ts
// This file defines the fields to be used in the API request for College Scorecard data.

// Define all the fields required for the API
export const Fields = {
    all: [
      // General Information
      "id", // Unique school ID
      "school.name", // Name of the school
      "school.city", // City where the school is located
      "school.state", // State where the school is located
      "school.ownership", // Ownership of the school
      "school.school_url", // School URL
      "school.price_calculator_url", // Price calculator URL
  
      // Location Data
      "location.lat", // Latitude of the school
      "location.lon", // Longitude of the school
  
      // Costs
      "latest.aid.median_debt.completers.overall", // Median student debt
      "latest.cost.avg_net_price.public", // Average net price for public institutions
      "latest.cost.avg_net_price.private", // Average net price for private institutions
      "latest.cost.tuition.in_state", // In-state tuition cost
      "latest.cost.tuition.out_of_state", // Out-of-state tuition cost
      "latest.cost.attendance.academic_year", // Cost of attendance for an academic year
  
      // Academics
      "latest.programs.cip_4_digit.title", // Program title
      "latest.programs.cip_4_digit.code", // Program code
      "latest.programs.cip_4_digit.earnings.1_yr.overall_median_earnings", // Median earnings 1 year after graduation
      "latest.programs.cip_4_digit.credential.level", // Credential level
      "school.carnegie_size_setting", // Carnegie classification
      "latest.student.demographics.student_faculty_ratio", // Student-to-faculty ratio
  
      // Admissions
      "latest.admissions.act_scores.midpoint.cumulative", // Average ACT score
      "latest.admissions.sat_scores.average.overall", // Average SAT score
      "latest.admissions.admission_rate.overall", // Admission rate
  
      // Campus
      "latest.student.size", // Total student size
      "school.locale", // Locale classification (urban, suburban, etc.)
      "school.religious_affiliation", // Religious affiliation
      "campus.semester", // Campus semester type
      "campus.student_population", // Campus student population
      "campus.setting", // Campus setting description
  
      // Demographics
      "latest.student.demographics.men", // Percentage of men
      "latest.student.demographics.women", // Percentage of women
      "latest.student.demographics.race_ethnicity.white", // Percentage of white students
      "latest.student.demographics.race_ethnicity.black", // Percentage of black students
      "latest.student.demographics.race_ethnicity.hispanic", // Percentage of Hispanic students
      "latest.student.demographics.race_ethnicity.asian", // Percentage of Asian students
      "latest.student.demographics.race_ethnicity.aian", // Percentage of American Indian/Alaska Native students
      "latest.student.demographics.race_ethnicity.nhpi", // Percentage of Native Hawaiian/Pacific Islander students
      "latest.student.demographics.race_ethnicity.two_or_more", // Percentage of students identifying as two or more races
      "latest.student.demographics.race_ethnicity.non_resident_alien", // Percentage of non-resident aliens
      "latest.student.demographics.race_ethnicity.unknown", // Percentage of students with unknown race/ethnicity
      "latest.student.demographics.race_ethnicity.white_non_hispanic", // White non-Hispanic
      "latest.student.demographics.race_ethnicity.black_non_hispanic", // Black non-Hispanic
      "latest.student.demographics.race_ethnicity.asian_pacific_islander", // Asian Pacific Islander
  
      // Outcomes
      "latest.completion.completion_rate_4yr_150nt", // 4-year graduation rate
      "latest.student.retention_rate.four_year.full_time_pooled", // Retention rate for 4-year programs
      "latest.student.retention_rate.lt_four_year.full_time_pooled", // Retention rate for less-than-4-year programs
  
      // Employment Data
      "latest.earnings.1_yr_after_completion.not_working_not_enrolled.overall_count", // Number of students not working and not enrolled 1 year after graduation
      "latest.earnings.1_yr_after_completion.working_not_enrolled.overall_count", // Number of students working and not enrolled 1 year after graduation
      "latest.earnings.6_yrs_after_entry.gt_threshold", // Percent of students earning above a certain threshold 6 years after entry
    ],
  };
  
  // Convert the fields into a comma-separated string for API usage
  export const fieldsString = Fields.all.join(",");
  