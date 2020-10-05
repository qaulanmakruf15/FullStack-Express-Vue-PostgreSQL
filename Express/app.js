require('dotenv').config()
const express = require('express');
const bodyParser = require("body-parser")
const morgan = require("morgan")
const cors = require('cors')
const routerNavigation = require('./src/main')
const port = 3000;
const app = express();
const fs = require('fs')
const path = require('path')

app.use(cors()) 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(morgan("dev"))

let retries = 10;
(async () => {
    while (retries) {
        try {
        const dborm = await dborm.sequelizeTest();
        const dbcon = await dbcon.dbConnect();
        console.log(dbcon);
        console.log(dborm);
        break
    } catch (err) {
        console.log(err);
        retries = 1;
        console.log(`retries left ${retries}`);
        await new Promise((res) => setTimeout(res, 7000));
    }
}
})();

app.use("/api", routerNavigation)
app.use(express.static("uploads")) 
const accessLogStream = fs.createWriteStream(path.join(__dirname, 'project.log'), { flags: 'a' })
app.use(morgan('common', { stream: accessLogStream }))
app.use(morgan('dev'))

app.listen(port, () => {
    console.log(`Service running on port ${port}`)
})