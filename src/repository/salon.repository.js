import {pool} from "../util/db.js"

export async function getAllMembers() {
    const db = await pool.getConnection()
    try{

        console.log(db)
        const [rows] = await db.query("select Name from mitarbeiter;")
        return rows
    }catch (error){
        throw error
    }finally{
        db.release()
    }
    
}