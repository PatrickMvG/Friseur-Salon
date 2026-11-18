import {freieTermine } from "../service/mitarbeiter.service.js";


export async function getAll(req, res) {
    try{
        const datum = req.query.datum
        const mid = req.query.mid
        const lid = req.query.lid 
        
        const termine  = await freieTermine(datum,mid,lid)
        res.json(termine)
    }catch (error){
        console.log(error)
        res.status(500).json({error: "Da hat was nicht geklappt."})
    }
}