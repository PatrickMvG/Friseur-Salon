import { getAllMembers } from "../repository/salon.repository.js";

export async function allMembers() {
    const member = await getAllMembers()
    return member
}