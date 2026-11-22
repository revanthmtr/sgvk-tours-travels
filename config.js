/* SGVK site settings.
   Fill these in to switch on WhatsApp OTP login and personal accounts (see docs/ACCOUNTS.md).
   Both values are safe to publish: the database only lets each person see their own data. */
window.SGVK_CONFIG = {
  supabaseUrl: "",       // e.g. "https://abcdxyz.supabase.co"
  supabaseAnonKey: "",   // Project Settings → API → "anon public" key
  demoLogin: false,      // keep false on the real site

  /* Contact details shown in the "About & contact" section. Leave a line empty to hide it. */
  phone: "",             // e.g. "+91 98765 43210"
  whatsapp: "",          // e.g. "+91 98765 43210"
  email: "",             // e.g. "bookings@sgvktravels.com"
  address: "",           // e.g. "12, MG Road, Bengaluru 560001"
  mapsUrl: "",           // Google Maps link to the office
  hours: ""              // e.g. "24/7" or "6 AM – 10 PM"
};
