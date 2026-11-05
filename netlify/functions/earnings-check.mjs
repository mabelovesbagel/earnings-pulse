// Scheduled discovery only. Do not publish unverified earnings numbers.
// Implement official IR / SEC source adapters in scripts/source-adapters.mjs before enabling ingestion.
export const config={schedule:'0 0 * * 1'}; // Monday 08:00 Asia/Taipei = Monday 00:00 UTC
export default async()=>{const endpoint=process.env.INGEST_WEBHOOK_URL,secret=process.env.INGEST_WEBHOOK_SECRET;if(!endpoint||!secret){console.log('Discovery skipped: ingestion webhook not configured');return}const r=await fetch(endpoint,{method:'POST',headers:{'Authorization':`Bearer ${secret}`,'Content-Type':'application/json'},body:JSON.stringify({job:'discover_official_earnings',lookback_days:7})});if(!r.ok)throw Error('Ingestion webhook failed: '+r.status)};
