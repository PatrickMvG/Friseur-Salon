import { allTimesKowalski } from "../service/mitarbeiter.service.js";


export async function getKowalski(req, res) {
    const member = await allTimesKowalski()
    res.status(200).json(member)
}