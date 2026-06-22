import { initInstrumentation } from '@opentelemetry/instrumentation'
import { NodeTracerProvider } from '@opentelemetry/sdk-trace-node'
import { SimpleSpanProcessor } from '@opentelemetry/sdk-trace-base'
import { OTLPTraceExporter } from '@opentelemetry/exporter-otlp-http'
import { registerInstrumentations } from '@opentelemetry/instrumentation'

const provider = new NodeTracerProvider({
  // config for the tracer
})
const exporter = new OTLPTraceExporter({
  url: 'http://tempo:4317',
})
provider.addSpanProcessor(new SimpleSpanProcessor(exporter))
provider.register()

// For Next.js 13+, use instrumentation.ts with instrumentationHook
// For other versions, use the following
import { instrument } from '@opentelemetry/instrumentation'
instrument({
  instrumentations: [
    // Add instrumentations for MongoDB, etc.
  ],
})