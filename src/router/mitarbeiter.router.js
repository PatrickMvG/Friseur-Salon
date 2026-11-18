import express from "express"
import { getAll} from "../controller/mitarbeiter.controller.js"

export const router = new express.Router()

router.get("/freie-termine", getAll)