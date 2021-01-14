var express = require("express")
var app = express()
var path = require("path")

app.get("/test.png", (req, res)=>{
    console.log("request")
    res.sendFile(path.join(__dirname, "test.png"))
})

app.listen(4000, ()=>{
    console.log("server is running on port 4000")
})
