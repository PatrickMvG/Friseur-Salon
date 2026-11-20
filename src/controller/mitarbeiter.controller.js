import { freieTermine, getAllPricesService, getFreieTermineService, getNameByLeistungService } from "../service/mitarbeiter.service.js";


export async function getAll(req, res) {
    try {
        const datum = req.query.datum
        const mid = req.query.mid
        const lid = req.query.lid

        const termine = await getFreieTermineService(datum, mid, lid)
        res.json(termine)
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: "Da hat was nicht geklappt." })
    }
}

export async function getAllPricesController(req, res) {
    const member = await getAllPricesService()
    res.status(200).json(member)
}

export async function getNameByLeistungController(req, res) {
    try {
        const lid = req.query.lid

        const leistungen = await getNameByLeistungService(lid)
        res.json(leistungen)
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: "Da hat was nicht geklappt." })
    }
}

