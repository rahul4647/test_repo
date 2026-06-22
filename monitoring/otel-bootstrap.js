# instrumentation.ts
import { NodeTracerProvider } from '@opentelemetry/node';
import { ConsoleSpanExporter, SimpleSpanProcessor } from '@opentelemetry/tracing';
import { registerInstrumentations } from '@opentelemetry/instrumentation';

const provider = new NodeTracerProvider();
const exporter = new ConsoleSpanExporter();
const spanProcessor = new SimpleSpanProcessor(exporter);

provider.addSpanProcessor(spanProcessor);
registerInstrumentations({
  instrumentations: [
    '@opentelemetry/instrumentation-http',
    '@opentelemetry/instrumentation-express'
  ]
});