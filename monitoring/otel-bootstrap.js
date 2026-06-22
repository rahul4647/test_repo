import { instrumentationHook } from '@opentelemetry/instrumentation-nextjs';
import { NodeTracerProvider } from '@opentelemetry/sdk-trace-node';
import { SimpleSpanProcessor } from '@opentelemetry/sdk-trace-base';
import { OTLPTraceExporter } from '@opentelemetry/exporter-otlp-http';

const provider = new NodeTracerProvider();
const exporter = new OTLPTraceExporter({ url: 'http://tempo:4317' });
provider.addSpanProcessor(new SimpleSpanProcessor(exporter));
provider.register();

export default function instrumentation() {
  return instrumentationHook({
    // Your Next.js app
  });
}