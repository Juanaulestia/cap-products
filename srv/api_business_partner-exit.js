import cds from "@sap/cds";

//export default cds.service.impl(async function (srv) {
//    const { Partner } = srv.entities;
//    const bp = await cds.connect.to("API_BUSINESS_PARTNER");

//  srv.on("READ", Partner, (req) => bp.run(req.query));
//});

export default async (srv) => {
    const { Partner } = srv.entities;
    const bp = await cds.connect.to("API_BUSINESS_PARTNER");

    srv.on(["READ"], Partner, async (req) => {
        const { from, columns, where, orderBy, limit } = req.query.SELECT;
        const PartnerQuery = SELECT.from(from);

        if (columns) PartnerQuery.columns(columns);
        if (where) PartnerQuery.where(where);
        if (orderBy) PartnerQuery.orderBy(orderBy);
        if (limit) PartnerQuery.limit(limit.rows?.val, limit.offset?.val);

        try {
            const result = await bp.tx(req).run(PartnerQuery);
            const partners = Array.isArray(result) ? result : [result];


            return partners;
        } catch (err) {
            console.error("Fallo al leer del backend:", err.message);
            req.error(502, "No se pudo consultar el sistema externo");
        }
    });
};