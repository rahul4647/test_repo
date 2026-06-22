import { NextInstrumentation } from '@opentelemetry/instrumentation-next';
import { NodeSDK } from '@opentelemetry/sdk-node';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';

const sdk = new NodeSDK({
  instrumentations: [
    getNodeAutoInstrumentations(),
    new NextInstrumentation(),
  ],
});

sdk.start();