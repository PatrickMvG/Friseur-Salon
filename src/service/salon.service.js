import { getAllMembers, insertTermin } from "../repository/salon.repository.js";

export async function allMembers() {
    const member = await getAllMembers()
    return member
}

export async function insertTerminService(kunde){
    return await insertTermin(kunde)
}
