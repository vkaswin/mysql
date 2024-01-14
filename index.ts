import express from "express";
import dotenv from "dotenv";
import { connect } from "./src/database/config";
import router from "./src/rotues";

dotenv.config();

const port = process.env.PORT;
const app = express();

app
  .use(express.json())
  .use(express.urlencoded({ extended: false }))
  .use(router);

connect()
  .then(() => {
    app.listen(port, () => {
      console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
    });
  })
  .catch((error) => {
    console.log(error);
  });
