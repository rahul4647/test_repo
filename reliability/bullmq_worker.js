const { Queue, Worker } = require('bullmq');
const IORedis = require('ioredis');

const connection = new IORedis(process.env.REDIS_URL || 'redis://127.0.0.1:6379');
const jobQueue = new Queue('heavy-tasks', { connection });

const worker = new Worker('heavy-tasks', async (job) => {
  console.log(`[Worker] Processing job ${job.id} | name=${job.name}`);
  if (job.name === 'send_email') {
    const { to, subject, body } = job.data;
    console.log(`Sending email to ${to}...`);
  } else if (job.name === 'generate_pdf') {
    console.log('Generating PDF...');
  }
}, { connection });

worker.on('completed', (job) => console.log(`Job ${job.id} completed.`));
worker.on('failed', (job, err) => console.error(`Job ${job.id} failed: ${err.message}`));

module.exports = { jobQueue };
