const keys = require('./keys');
const redis = require('redis');

const redisClient =redis.createClient({
    host: keys.REDIS_HOST,
    port: keys.REDIS_PORT,
    retry_strategy: () => 1000
});

const sub = redisClient.duplicate();

const fib = (index) => index < 2 ? 1 : (fib(index - 1 ) + fib(index -2));

sub.on('message', (channel, message) =>{
    redisClient.hset('values', message, fib(parseInt(message)))
});

sub.subscribe('insert')

