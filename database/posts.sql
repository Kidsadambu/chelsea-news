create table if not exists posts (
  id bigint generated always as identity primary key,
  title text not null,
  slug text unique not null,
  content text not null,
  category text not null,
  thumbnail text,
  status text default 'draft',
  created_at timestamp with time zone default timezone('utc', now()),
  updated_at timestamp with time zone default timezone('utc', now())
);

alter table posts enable row level security;

create policy "Public can read published posts"
on posts
for select
using (status = 'published');

create policy "Authenticated users can manage posts"
on posts
for all
to authenticated
using (true)
with check (true);
