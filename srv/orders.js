
import cds from "@sap/cds";
const { Orders } = cds.entities("com.training");

export default (srv) => {
    //******READ */

    srv.on("READ", "Orders", async (req) => {
        return await cds.run(req.query);
    });


    srv.after("READ", "Orders", (data) => {
        const orders = Array.isArray(data) ? data : [data];
        orders.forEach((order) => {
            order.Reviewed = true;
        });
    });

    //******CREATE */
    srv.on("CREATE", "Orders", async (req) => {
        try {
            await cds.transaction(req).run(
                INSERT.into(Orders).entries({
                    ClientEmail: req.data.ClientEmail,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    CreateOn: req.data.CreateOn,
                    Reviewed: req.data.Reviewed,
                    Approved: req.data.Approved,
                })
            );
            return req.data;
        } catch (err) {
            console.log(err);
            req.error(409, "Record NOT Inserted: " + err.message);
        }
    });

    srv.before("CREATE", "Orders", (req) => {
        req.data.CreateOn = new Date().toISOString().slice(0, 10);
        return req;

    });

    ///*****UPDATE */

    srv.on("UPDATE", "Orders", async (req) => {
        try {
            const affected = await UPDATE(Orders, req.data.ClientEmail).set({
                FirstName: req.data.FirstName,
                LastName: req.data.LastName,
            });
            if (affected === 0) {
                return req.reject(404, "Order not found");
            }

            return req.data;
        } catch (err) {
            console.log(err);
            req.error(409, "Record NOT Update " + err.message);
        }
    });

    //**** DELETE*/
    srv.on("DELETE", "Orders", async (req) => {
        try {
            const deleted = await DELETE.from(Orders).where({
                ClientEmail: req.data.ClientEmail
            });
            if (deleted !== 1) {
                return req.reject(409, "Order not found");
            }
        } catch (err) {
            console.log(err);
            req.error(409, "Record NOT delete " + err.message);
        }
    });

    // ***FUNTION*/
    srv.on("getClientTaxRate", async (req) => {
        // NO serve side effect

        const { clientemail } = req.data;
        const result = await SELECT.from(Orders)
            .columns("Country_code")
            .where({ ClientEmail: clientemail });

        if (result.length === 0) {
            return req.reject(404, "Client not found");
        }

        console.log(result[0].Country_code);
        switch (result[0].Country_code) {
            case 'ES':
                return 21.5;
            case 'UK':
                return 24.6;
            default: break;
        }

    });
    //***** ACTION */
    srv.on("cancelOrder", async (req) => {
        const { clientemail } = req.data;

        const order = await SELECT.one.from(Orders)
            .columns("FirstName", "LastName", "Approved")
            .where({ ClientEmail: clientemail });

        if (!order) {
            return req.reject(404, "Order not found");
        }

        const fullName = `${order.FirstName} ${order.LastName}`;
        const returnorder = { status: "", message: "" };

        if (!order.Approved) {
            await UPDATE(Orders)
                .set({ Status: "C" })
                .where({ ClientEmail: clientemail });

            returnorder.status = "Succeeded";
            returnorder.message = `The order placed by ${fullName} was canceled`;
        } else {
            returnorder.status = "Failed";
            returnorder.message = `The order placed by ${fullName} was NOT canceled because it was already approved`;
        }

        return returnorder;
    });
};