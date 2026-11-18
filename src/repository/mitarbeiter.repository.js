import { pool } from "../util/db.js"


export async function getOpenTime(datum){
    const db = await pool.getConnection()
    try{
        const [oeffnungszeiten] = await db.execute (`
            select von, bis
            from oeffnungszeiten
            where wochentag = weekday(?) + 1
            `, [datum])
        return oeffnungszeiten
    }catch (error) {
        throw error
    } finally {
        db.release()
    }
}
export async function getBookedTimes(mitarbeiter_id, datum) {
    const db = await pool.getConnection()
    try{
        const [termine] = await db.execute(`
            Select beginn, ende 
            from termine
            where mitarbeiter_id = ?
            and DATE(beginn) = ?
            and status in ('gebucht', 'bestaetigt')
            `, [mitarbeiter_id, datum])

        return termine
    }catch (error) {
        throw error
    } finally {
        db.release()
    }
}
export async function getDauerLeistungen(mitarbeiter_id, leistungs_id) {
    const db = await pool.getConnection()
    try{
        const [leistungen] = await db.execute(`
            select l.dauer_minuten
            from leistungen l 
            join mitarbeiter_leistungen ml
            on l.leistungs_id = ml.leistungs_id
            where ml.mitarbeiter_id = ?
            and l.leistungs_id = ?`,
        [mitarbeiter_id, leistungs_id])
        return leistungen
    }catch (error) {
        throw error
    } finally {
        db.release()
    }
}