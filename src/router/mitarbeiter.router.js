import express from "express"
import { getAll, getAllPricesController, getNameByLeistungController} from "../controller/mitarbeiter.controller.js"

export const router = new express.Router()

router.get("/freie-termine", getAll)

router.get("/alle-preise", getAllPricesController)

router.get("/leistungById", getNameByLeistungController)