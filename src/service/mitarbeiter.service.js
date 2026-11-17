import { getTimesKowalski } from "../repository/mitarbeiter.repository.js";

export async function allTimesKowalski() {
    const member = await getTimesKowalski()
    return member
}