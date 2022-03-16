import express from 'express'
import { authMiddleWare } from './auth'
import { EventController } from './controllers/event'

var app = express()


app.get('/', (req, res) => {
    res.send('Hello from the express webserver')
})

app.use(authMiddleWare)

app.use('/events', EventController);

app.listen(3000, () => {
    console.log('Server is running')
})