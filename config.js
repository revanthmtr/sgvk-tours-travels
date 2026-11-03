/* SGVK site settings.
   Fill these in to switch on WhatsApp OTP login and personal accounts (see docs/ACCOUNTS.md).
   Both values are safe to publish: the database only lets each person see their own data. */
window.SGVK_CONFIG = {
  supabaseUrl: "",       // e.g. "https://abcdxyz.supabase.co"
  supabaseAnonKey: "",   // Project Settings → API → "anon public" key
  demoLogin: false       // keep false on the real site
};
