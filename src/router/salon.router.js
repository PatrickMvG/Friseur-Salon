import express from "express"
import { getMembers } from "../controller/salon.controller.js"


export const router = new express.Router()

router.get("/member", getMembers)