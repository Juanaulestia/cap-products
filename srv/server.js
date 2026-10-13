import cds from "@sap/cds";
import cors from "cors";
import adapterproxy from "@sap/cds-odata-v2-adapter-proxy";

cds.on("bootstrap", (app) => {
    app.use(adapterproxy());
    app.use(cors());
    app.get("/alive", (_, res) => {
        res.status(200).send("Server is Alive");
    });
});


export default cds.server;