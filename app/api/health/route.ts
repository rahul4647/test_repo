// app/api/health/route.ts — Next.js 13+ App Router Route Handler
import { NextResponse } from 'next/server';

export const dynamic = 'force-dynamic';

export async function GET() {
  return NextResponse.json(
    {
      status: 'ok',
      uptime: process.uptime(),
      timestamp: Date.now(),
      version: process.env.npm_package_version || '0.0.0',
    },
    { status: 200 }
  );
}

export async function HEAD() {
  try {
    return new Response(null, { status: 200 });
  } catch (err) {
    return new Response(null, { status: 503 });
  }
}
