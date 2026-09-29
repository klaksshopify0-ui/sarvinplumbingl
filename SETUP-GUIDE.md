# Sarvin Plumbing Works – Website Setup Guide

This folder is your complete website. It has 4 files plus an `images` and a `videos` folder:

| File | What it is |
|---|---|
| `index.html` | The whole website: home page, the 7 pages, animations and the Admin panel |
| `images/` | The photos used in the design. Keep this folder next to `index.html` |
| `videos/` | The silent background videos on the home page. Keep this folder next to `index.html` too |
| `config.js` | Where you paste your 2 storage details (step 4) |
| `supabase-setup.sql` | A one-time script that creates storage for your photos, videos and reviews (step 2) |
| `SETUP-GUIDE.md` | This guide |

The website works as soon as you put it online. Steps 1–5 connect the **Admin** panel so you can upload work photos, videos and reviews from your phone. You only do them once, and they take about 15 minutes.

---

## Part A – Connect storage for Admin uploads (free)

We use **Supabase**, a free online database with file storage.

**Step 1 – Create a project**
1. Go to **supabase.com** and sign up (Google login works).
2. Click **New project**. Name it `sarvin-plumbing`, choose a strong database password, pick the region closest to India (Mumbai if listed), and create it. Wait about 2 minutes while it sets up.

**Step 2 – Create the storage**
1. Open `supabase-setup.sql` in any text editor (Notepad is fine).
2. Replace **owner@example.com** with the email you'll use to log in to Admin. It appears **5 times**; change all of them.
3. In Supabase, open **SQL Editor**, paste the whole file and press **Run**. You should see "Success".

**Step 3 – Create your Admin login**
1. In Supabase, open **Authentication → Users → Add user → Create new user**.
2. Enter the **same email** as in step 2 and a password. Tick **Auto confirm user** if it's shown.
3. Go to **Authentication → Sign In / Providers** (or **Settings**) and turn **off** "Allow new users to sign up". This way nobody else can create an account.

**Step 4 – Paste your 2 details into `config.js`**
1. In Supabase, open **Project Settings → API** (it may be called **Data API** or **API Keys**).
2. Copy the **Project URL** and the **anon public** key.
3. Open `config.js` and paste them between the quotes:
   ```js
   window.SITE_CONFIG = {
     supabaseUrl: "https://abcdxyz.supabase.co",
     supabaseAnonKey: "eyJhbGciOi...long key..."
   };
   ```
   Only use the **anon public** key. **Never** paste the `service_role` key here.

---

## Part B – Put the website online

**Option 1 – Netlify (easiest, no coding)**
1. Go to **app.netlify.com/drop** and log in.
2. Drag the whole **sarvin-website** folder onto the page.
3. You get a live link like `something.netlify.app` straight away. In **Site settings** you can change it to `sarvin-plumbing.netlify.app`.

**Option 2 – Vercel**
1. Create a free **GitHub** account, make a new repository and upload the 4 files.
2. Go to **vercel.com → Add New → Project**, pick that repository and click **Deploy**.
3. You get a link like `sarvin-plumbing.vercel.app`.

**Your own domain (like sarvinplumbing.in):** buy it from GoDaddy, Hostinger or similar, then add it in Netlify or Vercel under **Domains**. They show you the DNS records to copy.

---

## Part C – Using Admin

1. Open your website on your phone. Tap **☰** (top right) and then **Admin** at the bottom.
2. Log in with the email and password from step 3.
3. **Photos** tab: tap to add photos from your gallery. They're resized automatically.
   **Videos** tab: add clips up to 50 MB each.
   **Reviews** tab: copy real reviews from your Google profile (name, stars, text).
4. Everything goes live **immediately**, with no publish button. You can type captions, move items up and delete items (tap the bin twice).

---

## Good to know

- **Photos and videos appear in two places:** on the home page sections and on their own pages (Photos, Videos, Reviews).
- **Free Supabase limits:** 1 GB of file storage, which is hundreds of photos plus a good number of short videos. Free projects can be paused if nobody uses them for a while. If uploads stop working, log in to supabase.com and restore the project.
- **Changing text** (hours, services, phone number): the wording is inside `index.html`. Edit it, then upload the folder again (drag it onto Netlify again, or update the files on GitHub for Vercel).
- **Working hours** on the site are Mon–Fri 8 AM–6 PM, Sat 9 AM–4 PM, Sunday emergencies only. Change them if Sarvin's hours are different.
