import { pool } from "../util/db.js"


export async function getTimesKowalski() {
    const db = await pool.getConnection()
    try {
        const [rows] = await db.query(`select kundendaten.name, mitarbeiter.name ,wochentag.nameTag, zeitslot.startZeit, zeitslot.endZeit, leistungen.preis, leistungen.bezeichnung
        from wochentag
        right join zeitslot
        on wochentag.id = zeitslot.wochentag_id
        right join buchung
        on zeitslot.id = buchung.zeitSlot_id
        right join kundendaten
        on kundendaten.id = buchung.kundendaten_id
        left join mitarbeiter
        on mitarbeiter.id = buchung.mitarbeiter_id
        left join leistungen_buchung
        on buchung.id = leistungen_buchung.buchung_id
        left join leistungen
        on leistungen.id = leistungen_buchung.leistungen_id; `)
        return rows
    } catch (error) {
        throw error
    } finally {
        db.release()
    }
}