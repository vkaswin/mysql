import { Router } from "express";
import FindController from "../controllers/find";

const router = Router();

router.get("/all", FindController.findAll);

export default router;
