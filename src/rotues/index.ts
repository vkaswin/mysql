import { Router } from "express";
import FindRoutes from "./find";

const router = Router();

router.use("/api/find", FindRoutes);

export default router;
