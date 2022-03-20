import express from 'express'
import { authMiddleWare, requireAuth } from './auth'
import { EventController } from './controllers/event'
import { UsersController } from './controllers/users'

var app = express()

app.use(express.json())

app.use(authMiddleWare)

app.get('/', (req, res) => {
    console.log('User', req.uid)
    console.log('Admin', req.admin)
    res.send('Hello from the express webserver')
})


app.use('/events', requireAuth, EventController);
app.use('/users', requireAuth, UsersController);

app.listen(3000, () => {
    console.log('Server is running')
})