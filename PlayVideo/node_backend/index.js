var express = require("express")
var app  = express()
var path = require("path")

app.get("/ocean.mp4", (req, res)=>{
    res.sendFile(path.join(__dirname, "/ocean.mp4"))
})


app.listen(4000, ()=>{
    console.log("server is running")
})
