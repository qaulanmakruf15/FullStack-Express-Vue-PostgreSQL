require('dotenv').config()
const express = require('express');
const bodyParser = require("body-parser")
const morgan = require("morgan")
const cors = require('cors')
const routerNavigation = require('./src/main')
const port = 3000;
const app = express();

app.use(cors()) 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(morgan("dev"))

app.use("/", routerNavigation)
app.use(express.static("uploads")) 

app.listen(port, () => {
    console.log(`Service running on port ${port}`)
})