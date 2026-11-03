-- SGVK Tours and Travels: database for WhatsApp login accounts.
-- Run once in Supabase: SQL Editor → New query → paste → Run.
-- Row level security makes every row private to the customer who owns it.

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text,
  email text,
  phone text,
  gender text check (gender in ('M','F','O')),
  dob date,
  updated_at timestamptz default now()
);

create table if not exists public.travellers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  name text not null check (char_length(name) between 2 and 60),
  age int not null check (age between 1 and 110),
  gender text not null check (gender in ('M','F','O')),
  created_at timestamptz default now()
);

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  ref text not null,
  kind text not null,
  title text,
  date date,
  line text,
  status text,
  total int,
  created_at timestamptz default now(),
  unique (user_id, ref)
);

-- Cab and TTD enquiries. Logged-in customers see their own; anyone may send one.
-- Your team reads them in the Supabase Table Editor (or with the service key).
create table if not exists public.enquiries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid default auth.uid() references auth.users (id) on delete set null,
  kind text not null check (kind in ('cab','ttd')),
  ref text,
  status text not null default 'new' check (status in ('new','called','verified','confirmed','closed')),
  payload jsonb not null,
  created_at timestamptz default now()
);

alter table public.profiles   enable row level security;
alter table public.travellers enable row level security;
alter table public.bookings   enable row level security;
alter table public.enquiries  enable row level security;

create policy "own profile" on public.profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

create policy "own travellers" on public.travellers
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own bookings read" on public.bookings
  for select using (auth.uid() = user_id);
create policy "own bookings add" on public.bookings
  for insert with check (auth.uid() = user_id);

create policy "own enquiries read" on public.enquiries
  for select using (auth.uid() = user_id);
create policy "anyone can send an enquiry" on public.enquiries
  for insert with check (user_id is null or auth.uid() = user_id);

create index if not exists travellers_user on public.travellers (user_id);
create index if not exists bookings_user on public.bookings (user_id, date);
create index if not exists enquiries_user on public.enquiries (user_id, created_at);
