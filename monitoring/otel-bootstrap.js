import { NextFetchEvent, NextRequest, NextResponse } from 'next/server';
import { trace } from '@opentelemetry/api';

export function instrumentationHook() {
  trace.getTracer('nextjs-app').startSpan('instrumentation').end();
}

export default function middleware(req: NextRequest, ev: NextFetchEvent) {
  instrumentationHook();
  return NextResponse.next();
}