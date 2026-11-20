import express from "express"
import { getMembers, insertTerminController } from "../controller/salon.controller.js"


export const router = new express.Router()

router.get("/member", getMembers)

router.post("/termin", insertTerminController)