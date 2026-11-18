import { getAllPricesRepo, getBookedTimes, getDauerLeistungen, getNameByLeistungRepo, getOpenTime } from "../repository/mitarbeiter.repository.js";

export async function freieTermine(datum, mitarbeider_id, leistungs_id) {

    const oeffnungszeiten = await getOpenTime(datum)
    if (oeffnungszeiten.length === 0)
        return []
    const leistungen = await getDauerLeistungen(mitarbeider_id, leistungs_id)
    if (leistungen.length === 0)
        return []
    const termine = await getBookedTimes(mitarbeider_id, datum)
    const minuten = zeit => {
        const [h, m] = zeit.split(":").map(Number);
        return h * 60 + m;
    };

    const start = minuten(oeffnungszeiten[0].von);
    const ende = minuten(oeffnungszeiten[0].bis);
    const dauer = leistungen[0].dauer_minuten;
    console.log("Start:", start)
    console.log("Ende:", ende)
    console.log("dauer:", dauer)

    const belegt = termine.map(t => ({
        start: t.beginn.getHours() * 60 + t.beginn.getMinutes(),
        ende: t.ende.getHours() * 60 + t.ende.getMinutes()
    }));

    const freieZeiten = [];

    for (let zeit = start; zeit + dauer <= ende; zeit += 15) {

        const ueberschneidung = belegt.some(t =>
            zeit < t.ende && zeit + dauer > t.start
        );

        const stunde = String(Math.floor(zeit / 60)).padStart(2, "0");
        const minute = String(zeit % 60).padStart(2, "0");

        const uhrzeit = `${stunde}:${minute}`;
        const terminStart = new Date(`${datum}T${uhrzeit}:00`);

        const fruehestens = new Date(Date.now() + 2 * 60 * 60 * 1000);
        const spaetestens = new Date();
        spaetestens.setMonth(spaetestens.getMonth() + 3);

        if (!ueberschneidung &&
            terminStart >= fruehestens &&
            terminStart <= spaetestens) {
            freieZeiten.push(uhrzeit);
        }
    }
    return freieZeiten;
}


export async function getAllPricesService() {
    const price = await getAllPricesRepo()
    return price
}


export async function getNameByLeistungService(leistung) {
    const leistungById = await getNameByLeistungRepo(leistung)
    return leistungById
    
}