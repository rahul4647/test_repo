import { registerOTel } from '@vercel/otel-nextjs';

registerOTel({
  serviceName: 'nextjs-app',
  instrumentationHook: () => {
    // Additional instrumentation can be added here
  }
});