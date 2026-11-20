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

export async function getAllPricesRepo() {
    const db = await pool.getConnection()
    try{
        const [preise] = await db.execute(`SELECT bezeichnung, dauer_minuten, preis, leistungs_id FROM leistungen;`)
        return preise
    }catch (error) {
        throw error
    } finally {
        db.release()
    }
}


export async function getNameByLeistungRepo(leistung) {
    const db = await pool.getConnection()
    try{
        const [leistung1] = await db.execute(`select mitarbeiter.mitarbeiter_id ,mitarbeiter.name, leistungen.bezeichnung, leistungen.leistungs_id
                                            from mitarbeiter
                                            left join mitarbeiter_leistungen
                                            on mitarbeiter.mitarbeiter_id = mitarbeiter_leistungen.mitarbeiter_id
                                            left join leistungen
                                            on leistungen.leistungs_id = mitarbeiter_leistungen.leistungs_id
                                            where leistungen.leistungs_id = ?;`, [leistung])
        return leistung1
    }catch (error) {
        throw error
    } finally {
        db.release()
    }
}