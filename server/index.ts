import express from 'express'
import fileUpload from 'express-fileupload'
import { authMiddleWare, requireAuth } from './auth'
import { EventController } from './controllers/event'
import { UsersController } from './controllers/users'
import env from 'dotenv';
import { StripeController } from './controllers/stripe'
env.config({path: './.env'});

var app = express()

app.use(express.json())
app.use(fileUpload())

app.use(authMiddleWare)

app.get('/', (req, res) => {
    console.log('User', req.uid)
    console.log('Admin', req.admin)
    res.send('Hello from the express webserver')
})


app.use('/events', requireAuth, EventController);
app.use('/users', requireAuth, UsersController);
app.use('/stripe', requireAuth, StripeController)

app.listen(3000, () => {
    console.log('Server is running')
})