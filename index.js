import express from "express"
import cookieParser from "cookie-parser"
import cors from "cors"
process.loadEnvFile(".env")
import { router as salonRouter } from "./src/router/salon.router.js"
import { router as mitarbeiterRouter } from "./src/router/mitarbeiter.router.js"


const PORT = process.env.PORT || 8080

const app = express()


app.use(cors({
    origin: "http://127.0.0.1:5500",
    credentials: true
}))
app.use(express.json())
app.use(cookieParser())

app.use("/api/v1", salonRouter)
app.use("/api/v1", mitarbeiterRouter)


app.listen(PORT, () => {
    console.log(`Server ist gestartet! PORT = ${PORT}`);
})