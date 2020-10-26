var express = require("express")
var multer = require("multer")
var app = express()
const storage = multer.diskStorage({

    destination:function (req, file, cb){
        cb(null, "./")
    },


    filename: function(req, file, cb){
        cb(null, file.originalname)
    }

})
var upload = multer({
    storage:storage,
})

app.use(express.json())
app.use(express.urlencoded({extended:false}))

app.post("/", upload.single("image"), (req, res)=>{
    console.log(req.body)
    console.log(req.file)
})


app.listen(8000,  ()=>{
    console.log("server is runing at port 8000")
})
