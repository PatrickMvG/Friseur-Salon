import { allMembers, insertTerminService } from "../service/salon.service.js";

export async function getMembers(req, res) {
    const member = await allMembers()
    res.status(200).json(member)
}

export async function insertTerminController(req, res){
    const result = await insertTerminService(req.body)
    res.status(201).json(result)
}