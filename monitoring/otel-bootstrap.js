// instrumentation.ts
import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { NodeTracerProvider } from '@opentelemetry/node';
import { SimpleSpanProcessor } from '@opentelemetry/tracing';
import { CollectorTraceExporter } from '@opentelemetry/exporter-collector';

const provider = new NodeTracerProvider();
const exporter = new CollectorTraceExporter({
  url: 'http://tempo:4317',
});

provider.addSpanProcessor(new SimpleSpanProcessor(exporter));
provider.register();

registerInstrumentations({
  tracerProvider: provider,
});