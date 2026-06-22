import { tracing } from '@opentelemetry/sdk-trace-base';
import { NodeTracerProvider } from '@opentelemetry/sdk-trace-node';
import { ConsoleSpanExporter, SimpleSpanProcessor } from '@opentelemetry/sdk-trace-base';
import { registerInstrumentations } from '@opentelemetry/instrumentation';

const provider = new NodeTracerProvider();
const exporter = new ConsoleSpanExporter();
provider.addSpanProcessor(new SimpleSpanProcessor(exporter));
provider.register();

import { instrumentationHook } from '@opentelemetry/instrumentation-next';
instrumentationHook({
  tracerProvider: provider,
  instrumentations: [
    '@opentelemetry/instrumentation-express',
    '@opentelemetry/instrumentation-http',
    '@opentelemetry/instrumentation-mongodb',
  ],
});