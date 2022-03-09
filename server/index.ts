import express from 'express'
import { EventController } from './controllers/event'

var app = express()

app.get('/', (req, res) => {
    res.send('Hello from the express webserver')
})

app.use('/event', EventController);

app.listen(3000, () => {
    console.log('Server is running')
})