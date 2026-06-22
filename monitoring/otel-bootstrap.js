import { NextApiRequest, NextApiResponse } from 'next';
import { instrumentationHook } from '@opentelemetry/instrumentation-next';

export const instrumentation = instrumentationHook({
  enabled: true,
  logger: console,
  serviceName: 'nextjs-app',
});

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  res.status(200).json({ name: 'OTel Bootstrap' });
}