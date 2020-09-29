var express = require("express")
var app = express()
var path = require("path")

app.get("/categories", (req, res)=>{
    var categs = [
    {
        name: "Trending",
        images: ["endgame.jpg"]
    },    
    {
        name: "Action",
        images: ["extraction.jpg", "lostbullet.jpg","missionimpossible.jpg","ipman.png","007.jpg"]
    },
    {
        name : "Drama",
        images: ["enola.jpg", "irreplaceableyou.jpeg","22july.jpeg", "allied.png"]
    },
    {
        name: "Horror",
        images: ["halloween.jpg", "fantasyiland.jpg","split.jpg","birdbox.png"]
    }
    ]
    res.json(categs)
})

app.get("/images/:id", (req , res)=>{
    res.sendFile(path.join(__dirname , `/images/${req.params.id}`))
})


app.listen(1000, ()=>console.log("server is running on port 1000"))