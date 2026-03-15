import { ConnectionOptions, Job, JobsOptions, Queue, Worker } from "bullmq";
import { failedThe, failure, success, unit, Attempt, Unit, payloadFromTheSuccessful } from "src/lib/functors";

export class QueueFactory<A> {
    private readonly queue: Queue

    constructor(queueName: string, callback: (payload: A) => Promise<void> | void){
        const connectionAttempt = this.getRedisConnection();

        if(failedThe(connectionAttempt)) throw new Error("No Redis url found")

        this.queue = new Queue(queueName, { connection: payloadFromTheSuccessful(connectionAttempt)});
        const job = async (task: Job) => callback(task.data as A);
        new Worker(queueName, job)
    }

    private getRedisConnection(): Attempt<ConnectionOptions, Unit> {
        const redisUrl = process.env.REDIS_URL;
        if (!redisUrl) return failure(unit);

        const url = new URL(redisUrl);
        const dbString = url.pathname.slice(1);
        const db = dbString ? parseInt(dbString, 10) : 0;

        const connectionOptions = {
            host: url.hostname,
            port: parseInt(url.port || "6379", 10),
            password: url.password || undefined,
            db,
        }

        return success(connectionOptions);
    }

    async enqueue(payload: A): Promise<void> {
        await this.queue.add(this.queue.name, payload);
    }

    async enqueueBulk(payloads: A[]): Promise<void> {
        await this.queue.addBulk(payloads.map((data) => ({ name: this.queue.name, data })));
    }
}