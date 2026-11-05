create table if not exists earnings (
 id bigint generated always as identity primary key,
 ticker text not null, name text not null, fiscal_quarter text not null,
 release_date date not null, revenue numeric, revenue_yoy numeric,
 eps numeric, net_income numeric, currency text,
 consensus_status text check (consensus_status in ('beat','miss','inline','unconfirmed')),
 one_liner text, quarterly_growth jsonb not null default '[]'::jsonb,
 analysis jsonb not null default '[]'::jsonb,
 sources jsonb not null default '[]'::jsonb,
 verified_at timestamptz not null default now(),
 unique(ticker,fiscal_quarter)
);
create table if not exists upcoming (
 id bigint generated always as identity primary key,
 ticker text not null, name text not null, date date not null,
 confirmed boolean not null default false, focus text,
 source_url text, unique(ticker,date)
);
create table if not exists editorial (
 id bigint generated always as identity primary key,
 created_at timestamptz not null default now(),
 insights jsonb not null default '[]'::jsonb,
 learning jsonb
);
-- Server functions use the service role; do not expose that key to the browser.
alter table earnings enable row level security;
alter table upcoming enable row level security;
alter table editorial enable row level security;
