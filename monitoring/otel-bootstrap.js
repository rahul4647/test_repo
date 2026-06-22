import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { NodeTracerProvider } from '@opentelemetry/node';
import { CollectorTraceExporter } from '@opentelemetry/exporter-collector-grpc';
import { SimpleSpanProcessor } from '@opentelemetry/tracing';

const provider = new NodeTracerProvider();
provider.addSpanProcessor(new SimpleSpanProcessor(new CollectorTraceExporter({ serviceName: 'nextjs-app', url: 'http://tempo:4317' })));
provider.register();

import { instrumentationHook } from 'next/dist/build/webpack/config/instrumentation';

instrumentationHook(() => {
  registerInstrumentations({
    tracerProvider: provider,
    instrumentations: []
  });
});