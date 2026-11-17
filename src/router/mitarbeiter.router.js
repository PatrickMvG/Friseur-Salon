import express from "express"
import { getKowalski } from "../controller/mitarbeiter.controller.js"

export const router = new express.Router()

router.get("/termin/Kowalski", getKowalski)