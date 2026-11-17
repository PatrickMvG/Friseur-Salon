import { allMembers } from "../service/salon.service.js";

export async function getMembers(req, res) {
    const member = await allMembers()
    res.status(200).json(member)
}