import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { NodeTracerProvider } from '@opentelemetry/sdk-trace-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-grpc';
import { Resource } from '@opentelemetry/resources';
import { SemanticResourceAttributes } from '@opentelemetry/semantic-conventions';
import { HttpInstrumentation } from '@opentelemetry/instrumentation-http';

const provider = new NodeTracerProvider({
  resource: new Resource({
    [SemanticResourceAttributes.SERVICE_NAME]: 'nextjs-app',
  }),
});

const traceExporter = new OTLPTraceExporter({
  url: 'http://tempo:4317',
});

provider.addSpanProcessor(new SimpleSpanProcessor(traceExporter));
provider.register();

registerInstrumentations({
  instrumentations: [
    new HttpInstrumentation(),
  ],
});