import { Sequelize } from "sequelize";
import dotenv from "dotenv";

dotenv.config();

export const sequelize = new Sequelize(
  process.env.DB as string,
  process.env.NODE_ENV === "development"
    ? "root"
    : (process.env.USERNAME as string),
  process.env.NODE_ENV === "development"
    ? ""
    : (process.env.PASSWORD as string),
  {
    host: "localhost",
    dialect: "mysql",
  }
);

export const connect = async () => {
  try {
    await sequelize.authenticate();
    console.log("Connection has been established successfully.");
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
};
