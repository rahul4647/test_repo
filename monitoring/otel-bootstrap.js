import { registerOTel } from '@opentelemetry/auto-instrumentations-node';

export default function instrumentationHook() {
  registerOTel({
    serviceName: 'nextjs-app',
    traceExporter: {
      url: 'http://tempo:4317',
    },
    logExporter: {
      url: 'http://loki:3100/loki/api/v1/push',
    },
  });
}