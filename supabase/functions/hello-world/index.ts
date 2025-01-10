// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
deno install --allow-read https://deno.land/x/dotenv/mod.ts

// Import the Deno `serve` function
// Import the required modules
import { serve } from "https://deno.land/std@0.159.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js";

// Setup Supabase client
const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
const supabaseKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const supabase = createClient(supabaseUrl, supabaseKey);

serve(async (req) => {
  try {
    // Fetch data from an external API
    const response = await fetch("https://api.example.com/data"); // Replace with your external API URL
    if (!response.ok) {
      throw new Error(`External API error: ${response.statusText}`);
    }

    const externalData = await response.json();

    // Insert the data into Supabase
    const { data, error } = await supabase.from("your_table").insert([
      {
        external_id: externalData.id, // Map fields accordingly
        name: externalData.name,
        description: externalData.description,
      },
    ]);

    if (error) {
      throw new Error(`Supabase insert error: ${error.message}`);
    }

    // Return a success response
    return new Response(JSON.stringify({ success: true, data }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (err) {
    // Handle errors
    return new Response(
      JSON.stringify({ error: err.message }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});



/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/hello-world' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
