-- Sarvin Plumbing Works: storage for work photos, videos and reviews
-- 1) Replace owner@example.com (5 places) with the email you will log in with.
-- 2) Paste this whole file into Supabase > SQL Editor and press Run.

create table if not exists public.items (
  id uuid primary key default gen_random_uuid(),
  kind text not null check (kind in ('image','video','review')),
  title text default '',
  src text,
  path text,
  name text,
  stars int check (stars between 1 and 5),
  when_text text,
  body text,
  position double precision not null default 0,
  created_at timestamptz not null default now()
);

alter table public.items enable row level security;

drop policy if exists "Anyone can read" on public.items;
drop policy if exists "Owner can add" on public.items;
drop policy if exists "Owner can edit" on public.items;
drop policy if exists "Owner can delete" on public.items;

create policy "Anyone can read" on public.items
  for select using (true);
create policy "Owner can add" on public.items
  for insert to authenticated with check (lower(auth.jwt()->>'email') = lower('owner@example.com'));
create policy "Owner can edit" on public.items
  for update to authenticated using (lower(auth.jwt()->>'email') = lower('owner@example.com'));
create policy "Owner can delete" on public.items
  for delete to authenticated using (lower(auth.jwt()->>'email') = lower('owner@example.com'));

-- Public bucket for photos and videos (50 MB per file)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('work', 'work', true, 52428800,
        array['image/jpeg','image/png','image/webp','video/mp4','video/quicktime','video/webm'])
on conflict (id) do nothing;

drop policy if exists "Anyone can view work files" on storage.objects;
drop policy if exists "Owner can upload work files" on storage.objects;
drop policy if exists "Owner can delete work files" on storage.objects;

create policy "Anyone can view work files" on storage.objects
  for select using (bucket_id = 'work');
create policy "Owner can upload work files" on storage.objects
  for insert to authenticated with check (bucket_id = 'work' and lower(auth.jwt()->>'email') = lower('owner@example.com'));
create policy "Owner can delete work files" on storage.objects
  for delete to authenticated using (bucket_id = 'work' and lower(auth.jwt()->>'email') = lower('owner@example.com'));
