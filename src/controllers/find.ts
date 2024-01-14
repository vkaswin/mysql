import { sequelize } from "../database/config";
import { asyncHandler } from "../utils";

const findAll = asyncHandler(async (req, res) => {
  let data = await sequelize.query(`SELECT * FROM customers`);
  res.status(200).send({ data, message: "Success" });
});

const FindController = { findAll };

export default FindController;
