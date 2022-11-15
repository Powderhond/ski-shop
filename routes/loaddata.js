// const express = require("express");
// const router = express.Router();
// const sql = require("mysql2");
// const fs = require("fs");

import express from "express";
import sql from "mysql2";
import moment from "moment";
import fs from "fs";
import * as sv from "../server.js";

export const router = express.Router();

router.get("/", function (req, res, next) {
    //(async function () {
    try {
        console.log(req.app.get("dbConfig"));
        let pool = sql.createConnection(req.app.get("dbConfig"));

        // pool.connect((err) => {
        //     if (err) throw err;
        //     console.log("Connected!");
        // });

        res.setHeader("Content-Type", "text/html");
        res.write(`<title>${req.app.get("storeName")} | Load Database</title>`);
        res.write("<h1>Connecting to database...</h1><div>");

        let data = fs.readFileSync("./data/data.sql", {
            encoding: "utf8",
        });
        let commands = data.split(";");
        for (let i = 0; i < commands.length; i++) {
            let command = commands[i];
            if (command.trim() == "" || command.trim().startsWith("--")) {
                continue;
            }
            let result = pool.query(command, (error, results, field) => {
                if (error) {
                    throw error;
                }
                return results;
            });
            if (result) res.write(`<p>${i}. <code>${result.sql}</code></p>`);
        }
        pool.end();

        res.write("<h2>Database loading complete!</h2></div>");
    } catch (err) {
        console.warn(`Error in loaddata.js: ${err}`);
        res.write(err);
    } finally {
        res.end();
    }
    //})();
});

export default router;
// module.exports = router;
