# WhatsApp login and personal accounts

Customers log in with their WhatsApp number and a 6-digit code. Their account keeps:

- **My trips**: bus tickets booked while logged in (upcoming and completed)
- **Enquiries**: cab and TTD enquiries with live status
- **Travellers**: saved family and friends, filled into checkout with one tap
- **Profile**: name, email, gender, date of birth, verified WhatsApp number

Until the steps below are done, the site works exactly as before (no Login button).

## What you need

| Service | Why | Cost |
|---|---|---|
| [Supabase](https://supabase.com) | Login, sessions and the private database | Free tier is enough to start |
| [Twilio Verify](https://www.twilio.com/verify) | Sends the OTP on WhatsApp | Pay per code sent |

## 1. Create the Supabase project

1. Sign up at supabase.com → **New project** (region: Mumbai `ap-south-1`).
2. **SQL Editor → New query**: paste all of [`supabase-setup.sql`](supabase-setup.sql) and click **Run**.

## 2. Set up WhatsApp codes in Twilio

1. Sign up at twilio.com and upgrade the account (trial accounts only reach verified numbers).
2. **Verify → Services → Create**: name it `SGVK`, code length **6**.
3. In the service, open **WhatsApp** and connect a WhatsApp sender (your business number, registered with Meta through Twilio's WhatsApp self sign-up).
4. Note the **Account SID**, **Auth Token** and the Verify **Service SID** (`VA…`).

## 3. Connect Twilio to Supabase

1. Supabase → **Authentication → Sign In / Providers → Phone** → enable.
2. SMS provider: **Twilio Verify**. Paste Account SID, Auth Token and Verify Service SID. Save.
3. **Authentication → Rate limits**: keep OTP sends at a sensible limit (for example 30 per hour).

## 4. Turn it on in the site

1. Supabase → **Project Settings → API**: copy the **Project URL** and the **anon public** key.
2. Put them in [`config.js`](../config.js):

   ```js
   window.SGVK_CONFIG = {
     supabaseUrl: "https://YOUR-PROJECT.supabase.co",
     supabaseAnonKey: "YOUR-ANON-KEY",
     demoLogin: false
   };
   ```

3. Commit and push. Vercel redeploys and the **Login** button appears.

The anon key is meant to be public; the security comes from the row level security rules in the SQL, which only let each customer read and change their own rows.

## Your team: reading enquiries

Supabase → **Table Editor → enquiries**. Change `status` to `called`, `verified`, `confirmed` or `closed`; the customer sees it on their Enquiries tab.

## Testing

Supabase → **Authentication → Sign In / Providers → Phone → Test OTP**: add your number with a fixed code (for example `919876543210=123456`) to log in without sending a message.
