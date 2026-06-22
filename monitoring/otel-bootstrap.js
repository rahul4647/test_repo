import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { NodeSDK } from '@opentelemetry/sdk-node';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';

const sdk = new NodeSDK({
  instrumentations: [getNodeAutoInstrumentations()]
});

sdk.start();

export const instrumentationHook = () => {
  registerInstrumentations({
    instrumentations: [getNodeAutoInstrumentations()]
  });
};