import { collectDefaultMetrics, register } from 'prom-client';

collectDefaultMetrics();

export default async function handler(req, res) {
  try {
    console.log('Accessing /metrics endpoint');
    const metrics = await register.metrics();
    console.log('Metrics retrieved:', metrics);
    res.setHeader('Content-Type', register.contentType);
    res.end(metrics);
  } catch (error) {
    console.error('Error in /metrics:', error);
    res.status(500).end('Internal Server Error');
  }
}
