-- Reports inbox for Hawajiz Beirut.
-- Run this once in Supabase: SQL Editor → New query → paste → Run.
-- Before running, replace YOUR_EMAIL@example.com (2 places) with the email of your Supabase admin user.

create extension if not exists pgcrypto;

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  area text not null check (char_length(area) between 1 and 80),
  spot text check (char_length(spot) <= 120),
  direction text check (char_length(direction) <= 120),
  kind text not null check (kind in ('trailer','papers','army','isf','other')),
  note text check (char_length(note) <= 300),
  lang text check (lang in ('ar','en'))
);

alter table public.reports enable row level security;

grant insert on public.reports to anon, authenticated;
grant select, delete on public.reports to authenticated;

-- Anyone visiting the site can send a report, but nobody can read them back.
drop policy if exists "anyone can report" on public.reports;
create policy "anyone can report" on public.reports
  for insert to anon, authenticated with check (true);

-- Only your admin account can see and delete reports.
drop policy if exists "admin reads reports" on public.reports;
create policy "admin reads reports" on public.reports
  for select to authenticated using ((auth.jwt() ->> 'email') = 'YOUR_EMAIL@example.com');

drop policy if exists "admin deletes reports" on public.reports;
create policy "admin deletes reports" on public.reports
  for delete to authenticated using ((auth.jwt() ->> 'email') = 'YOUR_EMAIL@example.com');

-- Optional safety net: keep only the last 7 days of unhandled reports when you run this line.
-- delete from public.reports where created_at < now() - interval '7 days';
