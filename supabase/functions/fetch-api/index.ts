// index.ts
// Import required modules
import { createClient } from "https://esm.sh/@supabase/supabase-js";
import { config } from "https://deno.land/x/dotenv/mod.ts";
import { fieldsString } from "./fields.ts";

// Load environment variables
const env = config();
const supabaseUrl = env["SUPABASE_URL"];
const supabaseKey = env["SUPABASE_SERVICE_ROLE_KEY"];
const collegeApiKey = env["COLLEGE_API_KEY"]; // Add this to your .env file

// Setup Supabase client
const supabase = createClient(supabaseUrl, supabaseKey);

// External API base URL
const baseUrl = "https://api.data.gov/ed/collegescorecard/v1/schools";

// Function to fetch data from the external API
async function fetchSchools(page = 0) {
  const url = new URL(baseUrl);
  url.searchParams.append("api_key", collegeApiKey);
  url.searchParams.append("fields", fieldsString);
  url.searchParams.append("per_page", "100"); // Fetch 100 records per request
  url.searchParams.append("page", page.toString());

  const response = await fetch(url.toString());
  if (!response.ok) {
    throw new Error(`Failed to fetch data: ${response.statusText}`);
  }

  return await response.json();
}

// Function to upsert (insert or update) data into Supabase
async function upsertSchools(schools: any[]) {
  for (const school of schools) {
    const transformedSchool = {
      // General Information
      api_id: school.id,
      name: school["school.name"],
      city: school["school.city"],
      state: school["school.state"],
      latitude: school["location.lat"],
      longitude: school["location.lon"],
      ownership: school["school.ownership"],
      school_url: school["school.school_url"],
      price_calculator_url: school["school.price_calculator_url"],


      // Costs
      average_debt: school["latest.aid.median_debt.completers.overall"],
      average_net_price_public: school["latest.cost.avg_net_price.public"],
      average_net_price_private: school["latest.cost.avg_net_price.private"],
      in_state_tuition: school["latest.cost.tuition.in_state"],
      out_state_tuition: school["latest.cost.tuition.out_of_state"],
      coa_academic_year: school["latest.cost.attendance.academic_year"],

      // Academics
      areas_of_study["latest.programs.cip_4_digit"]
      carnegie: school["school.carnegie_size_setting"],
      student_to_faculty_ratio: school["latest.student.demographics.student_faculty_ratio"],

      // Admissions
      act_score: school["latest.admissions.act_scores.midpoint.cumulative"],
      sat_score: school["latest.admissions.sat_scores.average.overall"],
      admissions_rate: school["latest.admissions.admission_rate.overall"],

      // Campus
      size: school["latest.student.size"],
      locale: school["school.locale"],
      religious_affiliation: school["school.religious_affiliation"],

      // Demographics
      white: school["latest.student.demographics.race_ethnicity.white"],
      black: school["latest.student.demographics.race_ethnicity.black"],
      hispanic: school["latest.student.demographics.race_ethnicity.hispanic"],
      asian: school["latest.student.demographics.race_ethnicity.asian"],
      aian: school["latest.student.demographics.race_ethnicity.aian"], // American Indian/Alaska Native
      nhpi: school["latest.student.demographics.race_ethnicity.nhpi"], // Native Hawaiian/Pacific Islander
      two_or_more: school["latest.student.demographics.race_ethnicity.two_or_more"],
      non_resident_alien: school["latest.student.demographics.race_ethnicity.non_resident_alien"],
      unknown: school["latest.student.demographics.race_ethnicity.unknown"],
      white_non_hispanic: school["latest.student.demographics.race_ethnicity.white_non_hispanic"],
      black_non_hispanic: school["latest.student.demographics.race_ethnicity.black_non_hispanic"],
      asian_pacific_islander: school["latest.student.demographics.race_ethnicity.asian_pacific_islander"],
      men: school["latest.student.demographics.men"],
      women: school["latest.student.demographics.women"],

      // Outcomes
      four_year_grad_rate: school["latest.completion.completion_rate_4yr_150nt"],
      four_year_retention_rate: school["latest.student.retention_rate.four_year.full_time_pooled"],
      less_than_four_year_retention_rate: school["latest.student.retention_rate.lt_four_year.full_time_pooled"],
      percent_earning_more_than_hs_grad: school["latest.earnings.6_yrs_after_entry.gt_threshold"],

      // Employment Data
      not_working_not_enrolled: school["latest.earnings.1_yr_after_completion.not_working_not_enrolled.overall_count"],
      working_not_enrolled: school["latest.earnings.1_yr_after_completion.working_not_enrolled.overall_count"],
    };

    const { error } = await supabase.from("schools").upsert(transformedSchool, {
      onConflict: "api_id", // Avoid duplicates by updating based on `api_id`
    });

    if (error) {
      console.error(`Error upserting school with API ID ${school.id}: ${error.message}`);
    }
  }
}

// Function to fetch and insert all schools
async function syncSchools() {
  let page = 0;
  let totalPages = 1;

  while (page < totalPages) {
    const apiResponse = await fetchSchools(page);
    totalPages = Math.ceil(apiResponse.metadata.total / 100); // Update total pages from metadata
    const schools = apiResponse.results;

    console.log(`Processing page ${page + 1}/${totalPages}`);
    await upsertSchools(schools);

    page++;
  }
}

// Run the script to sync schools
syncSchools().then(() => console.log("School data sync complete."));
