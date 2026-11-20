import {pool} from "../util/db.js"

export async function getAllMembers() {
    const db = await pool.getConnection()
    try{
        console.log(db)
        const [rows] = await db.query("select mitarbeiter_id, Name from mitarbeiter;")
        return rows
    }catch (error){
        throw error
    }finally{
        db.release()
    }
}


export async function insertTermin(buchung) {
    const db = await pool.getConnection()
    try {
        let kundenId = buchung.kunden_id
        let finaleMitarbeiterId = Number(buchung.mitarbeiter_id)

        // 1. Falls "Egal" (0) gewählt wurde: freien Mitarbeiter suchen (ID 1 zuletzt!)
        if (finaleMitarbeiterId === 0) {
            const [verfuegbare] = await db.execute(
                `SELECT m.mitarbeiter_id
                 FROM mitarbeiter m
                 JOIN mitarbeiter_leistungen ml ON m.mitarbeiter_id = ml.mitarbeiter_id
                 WHERE ml.leistungs_id = ?
                   AND m.mitarbeiter_id NOT IN (
                       SELECT t.mitarbeiter_id
                       FROM termine t
                       WHERE t.status != 'storniert'
                         AND t.beginn < ?
                         AND t.ende > ?
                   )
                 ORDER BY (m.mitarbeiter_id = 1) ASC, m.mitarbeiter_id ASC
                 LIMIT 1`,
                [buchung.leistungs_id, buchung.ende, buchung.beginn]
            )

            if (verfuegbare.length === 0) {
                throw new Error("Leider ist zu dieser Uhrzeit kein Mitarbeiter mehr frei.")
            }

            finaleMitarbeiterId = verfuegbare[0].mitarbeiter_id
        }

        // 2. Kunden-ID holen oder neuen Kunden anlegen
        if (!kundenId) {
            const [existingKunden] = await db.execute(
                "SELECT kunden_id FROM kunden WHERE email = ?",
                [buchung.email]
            )

            if (existingKunden.length > 0) {
                kundenId = existingKunden[0].kunden_id
            } else {
                const [kundeResult] = await db.execute(
                    "INSERT INTO kunden (name, telefon, email) VALUES (?, ?, ?)",
                    [buchung.name, buchung.tel, buchung.email]
                )
                kundenId = kundeResult.insertId
            }
        }

        // 3. Termin speichern
        const [result] = await db.execute(
            `INSERT INTO termine 
            (kunden_id, mitarbeiter_id, leistungs_id, beginn, ende, preis_bei_buchung, dauer_bei_buchung, status) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                kundenId,
                finaleMitarbeiterId,
                buchung.leistungs_id,
                buchung.beginn,
                buchung.ende,
                buchung.preis_bei_buchung,
                buchung.dauer_bei_buchung,
                buchung.status || "gebucht"
            ]
        )

        return result
    } catch (error) {
        throw error
    } finally {
        db.release()
    }
}