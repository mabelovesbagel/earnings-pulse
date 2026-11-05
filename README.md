# Earnings Pulse — Global Earnings Intelligence

Mobile-first PWA dashboard for verified quarterly earnings. **No fabricated financial data.**

## Quick start

```bash
npm install
npm run dev
```

Local Vite preview shows a truthful empty state because Netlify Functions are not available in plain Vite dev mode. For local backend testing, install Netlify CLI and run `netlify dev` after configuring environment variables.

## Deployment

1. Create a Supabase project and run `supabase/schema.sql` in the SQL editor.
2. Create a Netlify site from this repository. Build: `npm run build`; publish: `dist`.
3. In Netlify environment variables, set `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY` (server-side only). Never set these as `VITE_*` variables or commit them.
4. The `/api/report` endpoint will return verified rows from Supabase. It displays an empty state until actual verified data is imported.
5. For automated discovery, implement a trusted ingestion service that verifies official IR / exchange filings, maps actual results to the schema, and stores cited URLs. Set `INGEST_WEBHOOK_URL` and `INGEST_WEBHOOK_SECRET` in Netlify to enable the scheduled trigger. Until configured, the scheduled function safely skips.
6. Add editorial AI analysis **only after** actual data is validated, and mark analyst consensus / management guidance / interpretation distinctly. Editorial entries must cite the exact official release and release date. A weekly job should deduplicate `(ticker,fiscal_quarter)`.
7. Netlify scheduled function uses UTC cron `0 0 * * 1` corresponding to Monday 08:00 Taiwan time (UTC+8, no DST).

## Production checklist

- [ ] Official-source ingestion connectors and robust release-date verification
- [ ] Consensus data licensing/provider, if used; otherwise mark unconfirmed
- [ ] Official earnings calendar verification and source URLs
- [ ] AI editorial job with provenance and fact-checking, not free-form numbers
- [ ] Error alerts, retries, source auditing, stale-data banner
- [ ] Authentication if private dashboard desired
- [ ] Test PWA install on iOS Safari and Android Chrome

## Architecture

Official IR/SEC sources → scheduled discovery webhook → extraction + validation → Supabase → Netlify report function → React PWA. Optional AI editorial job reads verified rows and writes cited commentary to `editorial`. The existing ChatGPT scheduled report is **not** connected to this pipeline automatically.

## Install on phone

Deploy to HTTPS URL, then on iOS use Safari → Share → Add to Home Screen; on Android use Chrome → Add to Home Screen / Install app. Offline mode provides only previously cached app shell, not guaranteed cached earnings data.
