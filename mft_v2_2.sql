-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mft_v1.0
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mft_v1.0
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mft_v1.0` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `mft_v1.0` ;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`barrel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`barrel` (
  `barrel_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`barrel_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cone` (
  `cone_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `barrel_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cone_id`, `barrel_id`),
  INDEX `fk_Cone_Barrel1_idx` (`barrel_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cone_Barrel1`
    FOREIGN KEY (`barrel_id`)
    REFERENCES `mft_v1.0`.`barrel` (`barrel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`disk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`disk` (
  `disk_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `cone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`disk_id`, `cone_id`),
  INDEX `fk_disk_cone1_idx` (`cone_id` ASC) VISIBLE,
  CONSTRAINT `fk_disk_cone1`
    FOREIGN KEY (`cone_id`)
    REFERENCES `mft_v1.0`.`cone` (`cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`disk_face`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`disk_face` (
  `disk_face_id` VARCHAR(45) NOT NULL,
  `disk_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`disk_face_id`, `disk_id`),
  INDEX `fk_Disk_Face_Disk1_idx` (`disk_id` ASC) VISIBLE,
  CONSTRAINT `fk_Disk_Face_Disk1`
    FOREIGN KEY (`disk_id`)
    REFERENCES `mft_v1.0`.`disk` (`disk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`zone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`zone` (
  `zone_id` VARCHAR(45) NOT NULL,
  `n_ladder` INT NULL,
  `disk_face_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`zone_id`, `disk_face_id`),
  INDEX `fk_Disk_Zone_Disk_Face1_idx` (`disk_face_id` ASC) VISIBLE,
  CONSTRAINT `fk_Disk_Zone_Disk_Face1`
    FOREIGN KEY (`disk_face_id`)
    REFERENCES `mft_v1.0`.`disk_face` (`disk_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ladder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ladder` (
  `ladder_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `trav_link` VARCHAR(250) NULL,
  `cernbox_link` VARCHAR(250) NULL,
  `mech_grade` INT NULL,
  `qa_grade` INT NULL,
  `pos_zone` INT NULL,
  `zone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ladder_id`, `zone_id`),
  INDEX `fk_Ladder_Disk_Zone1_idx` (`zone_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ladder_Disk_Zone1`
    FOREIGN KEY (`zone_id`)
    REFERENCES `mft_v1.0`.`zone` (`zone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`chip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`chip` (
  `chip_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `db_link` VARCHAR(250) NULL,
  `grade` INT NULL,
  `pos_on_ladder` INT NULL,
  `ladder_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`chip_id`, `ladder_id`),
  INDEX `fk_Chip_Ladder_idx` (`ladder_id` ASC) VISIBLE,
  CONSTRAINT `fk_Chip_Ladder`
    FOREIGN KEY (`ladder_id`)
    REFERENCES `mft_v1.0`.`ladder` (`ladder_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`fpc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`fpc` (
  `fpc_id` VARCHAR(45) NOT NULL,
  `trav_link` VARCHAR(250) NULL,
  `nchips` INT NULL,
  `ladder_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fpc_id`, `ladder_id`),
  INDEX `fk_FPC_Ladder1_idx` (`ladder_id` ASC) VISIBLE,
  CONSTRAINT `fk_FPC_Ladder1`
    FOREIGN KEY (`ladder_id`)
    REFERENCES `mft_v1.0`.`ladder` (`ladder_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`heat_exchanger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`heat_exchanger` (
  `heat_exchanger_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `disk_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`heat_exchanger_id`, `disk_id`),
  INDEX `fk_Heat_Exchanger_Disk1_idx` (`disk_id` ASC) VISIBLE,
  CONSTRAINT `fk_Heat_Exchanger_Disk1`
    FOREIGN KEY (`disk_id`)
    REFERENCES `mft_v1.0`.`disk` (`disk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cold_plate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cold_plate` (
  `cold_plate_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `heat_exchanger_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cold_plate_id`, `heat_exchanger_id`),
  INDEX `fk_Cold_Plate_Heat_Exchanger1_idx` (`heat_exchanger_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cold_Plate_Heat_Exchanger1`
    FOREIGN KEY (`heat_exchanger_id`)
    REFERENCES `mft_v1.0`.`heat_exchanger` (`heat_exchanger_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`pcb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`pcb` (
  `pcb_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `disk_face_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pcb_id`, `disk_face_id`),
  INDEX `fk_PCB_Disk_Face1_idx` (`disk_face_id` ASC) VISIBLE,
  CONSTRAINT `fk_PCB_Disk_Face1`
    FOREIGN KEY (`disk_face_id`)
    REFERENCES `mft_v1.0`.`disk_face` (`disk_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`psu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`psu` (
  `psu_id` VARCHAR(45) NOT NULL,
  `cone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`psu_id`, `cone_id`),
  INDEX `fk_PSU_Cone1_idx` (`cone_id` ASC) VISIBLE,
  CONSTRAINT `fk_PSU_Cone1`
    FOREIGN KEY (`cone_id`)
    REFERENCES `mft_v1.0`.`cone` (`cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`psu_face`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`psu_face` (
  `psu_face_id` VARCHAR(45) NOT NULL,
  `psu_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`psu_face_id`, `psu_id`),
  INDEX `fk_PSU_FACE_PSU1_idx` (`psu_id` ASC) VISIBLE,
  CONSTRAINT `fk_PSU_FACE_PSU1`
    FOREIGN KEY (`psu_id`)
    REFERENCES `mft_v1.0`.`psu` (`psu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`psu_mezzanine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`psu_mezzanine` (
  `psu_mezzanine_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `psu_face_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`psu_mezzanine_id`, `psu_face_id`),
  INDEX `fk_PSU_MEZZANINE_PSU_FACE1_idx` (`psu_face_id` ASC) VISIBLE,
  CONSTRAINT `fk_PSU_MEZZANINE_PSU_FACE1`
    FOREIGN KEY (`psu_face_id`)
    REFERENCES `mft_v1.0`.`psu_face` (`psu_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`psu_main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`psu_main` (
  `psu_main_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `psu_face_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`psu_main_id`, `psu_face_id`),
  INDEX `fk_PSU_MAIN_PSU_FACE1_idx` (`psu_face_id` ASC) VISIBLE,
  CONSTRAINT `fk_PSU_MAIN_PSU_FACE1`
    FOREIGN KEY (`psu_face_id`)
    REFERENCES `mft_v1.0`.`psu_face` (`psu_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`dc_dc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`dc_dc` (
  `dc_dc_id` VARCHAR(45) NOT NULL,
  `int_id` VARCHAR(45) NULL,
  `out_voltage` VARCHAR(45) NULL,
  `psu_main_id` VARCHAR(45) NOT NULL,
  `psu_mezzanine_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dc_dc_id`, `psu_main_id`, `psu_mezzanine_id`),
  INDEX `fk_DC_DC_PSU_MEZZANINE1_idx` (`psu_mezzanine_id` ASC) VISIBLE,
  INDEX `fk_DC_DC_PSU_MAIN1_idx` (`psu_main_id` ASC) VISIBLE,
  CONSTRAINT `fk_DC_DC_PSU_MEZZANINE1`
    FOREIGN KEY (`psu_mezzanine_id`)
    REFERENCES `mft_v1.0`.`psu_mezzanine` (`psu_mezzanine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DC_DC_PSU_MAIN1`
    FOREIGN KEY (`psu_main_id`)
    REFERENCES `mft_v1.0`.`psu_main` (`psu_main_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`gbt-sca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`gbt-sca` (
  `gbt_sca_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `psu_mezzanine_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gbt_sca_id`, `psu_mezzanine_id`),
  INDEX `fk_GBT_SCA_PSU_MEZZANINE1_idx` (`psu_mezzanine_id` ASC) VISIBLE,
  CONSTRAINT `fk_GBT_SCA_PSU_MEZZANINE1`
    FOREIGN KEY (`psu_mezzanine_id`)
    REFERENCES `mft_v1.0`.`psu_mezzanine` (`psu_mezzanine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`psu_he`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`psu_he` (
  `psu_he_id` VARCHAR(45) NOT NULL,
  `psu_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`psu_he_id`, `psu_id`),
  INDEX `fk_PSU_HE_PSU1_idx` (`psu_id` ASC) VISIBLE,
  CONSTRAINT `fk_PSU_HE_PSU1`
    FOREIGN KEY (`psu_id`)
    REFERENCES `mft_v1.0`.`psu` (`psu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`mother_board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`mother_board` (
  `mother_board_id` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `cone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mother_board_id`, `cone_id`),
  INDEX `fk_Mother_Board_Cone1_idx` (`cone_id` ASC) VISIBLE,
  CONSTRAINT `fk_Mother_Board_Cone1`
    FOREIGN KEY (`cone_id`)
    REFERENCES `mft_v1.0`.`cone` (`cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`pp2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`pp2` (
  `pp2_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `barrel_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pp2_id`, `barrel_id`),
  INDEX `fk_PP2_Barrel1_idx` (`barrel_id` ASC) VISIBLE,
  CONSTRAINT `fk_PP2_Barrel1`
    FOREIGN KEY (`barrel_id`)
    REFERENCES `mft_v1.0`.`barrel` (`barrel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`vent_duct_cone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`vent_duct_cone` (
  `vent_duct_cone_id` VARCHAR(45) NOT NULL,
  `side` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `cone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vent_duct_cone_id`, `cone_id`),
  INDEX `fk_Ventilation_Cone_Cone1_idx` (`cone_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ventilation_Cone_Cone1`
    FOREIGN KEY (`cone_id`)
    REFERENCES `mft_v1.0`.`cone` (`cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`vent_duct_barrel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`vent_duct_barrel` (
  `vent_duct_barrel_id` VARCHAR(45) NOT NULL,
  `side` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `barrel_id` VARCHAR(45) NOT NULL,
  `vent_duct_cone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vent_duct_barrel_id`, `barrel_id`, `vent_duct_cone_id`),
  INDEX `fk_Ventilation_Barrel_Barrel1_idx` (`barrel_id` ASC) VISIBLE,
  INDEX `fk_Vent_Duct_Barrel_vent_duct_cone1_idx` (`vent_duct_cone_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ventilation_Barrel_Barrel1`
    FOREIGN KEY (`barrel_id`)
    REFERENCES `mft_v1.0`.`barrel` (`barrel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vent_Duct_Barrel_vent_duct_cone1`
    FOREIGN KEY (`vent_duct_cone_id`)
    REFERENCES `mft_v1.0`.`vent_duct_cone` (`vent_duct_cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`vent_pipe_mnf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`vent_pipe_mnf` (
  `vent_pipe_mnf_id` VARCHAR(45) NOT NULL,
  `en_cv_name` VARCHAR(45) NULL,
  `side` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `vent_duct_barrel_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vent_pipe_mnf_id`, `vent_duct_barrel_id`),
  INDEX `fk_vent_pipe_mnf_vent_duct_barrel1_idx` (`vent_duct_barrel_id` ASC) VISIBLE,
  CONSTRAINT `fk_vent_pipe_mnf_vent_duct_barrel1`
    FOREIGN KEY (`vent_duct_barrel_id`)
    REFERENCES `mft_v1.0`.`vent_duct_barrel` (`vent_duct_barrel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ventilation_plant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ventilation_plant` (
  `ventilation_plant_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`ventilation_plant_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`vent_pipe_cavern`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`vent_pipe_cavern` (
  `vent_pipe_cavern_id` VARCHAR(45) NOT NULL,
  `en_cv_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `vent_pipe_mnf_id` VARCHAR(45) NOT NULL,
  `vent_plant_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vent_pipe_cavern_id`, `vent_pipe_mnf_id`, `vent_plant_id`),
  INDEX `fk_Vent_Pipe_Cavern_Vent_Pipe_MNF1_idx` (`vent_pipe_mnf_id` ASC) VISIBLE,
  INDEX `fk_Vent_Pipe_Cavern_Ventilation_Plant1_idx` (`vent_plant_id` ASC) VISIBLE,
  CONSTRAINT `fk_Vent_Pipe_Cavern_Vent_Pipe_MNF1`
    FOREIGN KEY (`vent_pipe_mnf_id`)
    REFERENCES `mft_v1.0`.`vent_pipe_mnf` (`vent_pipe_mnf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vent_Pipe_Cavern_Ventilation_Plant1`
    FOREIGN KEY (`vent_plant_id`)
    REFERENCES `mft_v1.0`.`ventilation_plant` (`ventilation_plant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`patch_panel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`patch_panel` (
  `patch_panel_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `barrel_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`patch_panel_id`, `barrel_id`),
  INDEX `fk_Patch_Panel_Barrel1_idx` (`barrel_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patch_Panel_Barrel1`
    FOREIGN KEY (`barrel_id`)
    REFERENCES `mft_v1.0`.`barrel` (`barrel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`filter_board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`filter_board` (
  `filter_board_id` VARCHAR(45) NOT NULL,
  `type` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `patch_panel_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`filter_board_id`, `patch_panel_id`),
  INDEX `fk_Filter_Board_Patch_Panel1_idx` (`patch_panel_id` ASC) VISIBLE,
  CONSTRAINT `fk_Filter_Board_Patch_Panel1`
    FOREIGN KEY (`patch_panel_id`)
    REFERENCES `mft_v1.0`.`patch_panel` (`patch_panel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cool_pipe_cone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cool_pipe_cone` (
  `cool_pipe_cone_id` VARCHAR(45) NOT NULL,
  `type` INT NULL,
  `en_cv_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `he_psu_id` VARCHAR(45) NOT NULL,
  `heat_exchanger_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cool_pipe_cone_id`, `he_psu_id`, `heat_exchanger_id`),
  INDEX `fk_Cool_Pipe_Cone_PSU_HE1_idx` (`he_psu_id` ASC) VISIBLE,
  INDEX `fk_cool_pipe_cone_heat_exchanger1_idx` (`heat_exchanger_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cool_Pipe_Cone_PSU_HE1`
    FOREIGN KEY (`he_psu_id`)
    REFERENCES `mft_v1.0`.`psu_he` (`psu_he_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cool_pipe_cone_heat_exchanger1`
    FOREIGN KEY (`heat_exchanger_id`)
    REFERENCES `mft_v1.0`.`heat_exchanger` (`heat_exchanger_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cool_pipe_barrel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cool_pipe_barrel` (
  `cool_pipe_barrel_id` VARCHAR(45) NOT NULL,
  `type` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `cool_pipe_cone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cool_pipe_barrel_id`, `cool_pipe_cone_id`),
  INDEX `fk_Cool_Pipe_Barrel_Cool_Pipe_Cone1_idx` (`cool_pipe_cone_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cool_Pipe_Barrel_Cool_Pipe_Cone1`
    FOREIGN KEY (`cool_pipe_cone_id`)
    REFERENCES `mft_v1.0`.`cool_pipe_cone` (`cool_pipe_cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cool_pipe_mnf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cool_pipe_mnf` (
  `cool_pipe_mnf_id` VARCHAR(45) NOT NULL,
  `type` INT NULL,
  `en_cv_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `cool_pipe_barrel_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cool_pipe_mnf_id`, `cool_pipe_barrel_id`),
  INDEX `fk_cool_pipe_mnf_cool_pipe_barrel1_idx` (`cool_pipe_barrel_id` ASC) VISIBLE,
  CONSTRAINT `fk_cool_pipe_mnf_cool_pipe_barrel1`
    FOREIGN KEY (`cool_pipe_barrel_id`)
    REFERENCES `mft_v1.0`.`cool_pipe_barrel` (`cool_pipe_barrel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cooling_plant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cooling_plant` (
  `idcooling_plant` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`idcooling_plant`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cool_pipe_cavern`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cool_pipe_cavern` (
  `cool_pipe_cavern_id` VARCHAR(45) NOT NULL,
  `type` INT NULL,
  `en_cv_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `cool_pipe_mnf_id` VARCHAR(45) NOT NULL,
  `cooling_plant_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cool_pipe_cavern_id`, `cool_pipe_mnf_id`, `cooling_plant_id`),
  INDEX `fk_cool_pipe_cavern_cool_pipe_mnf1_idx` (`cool_pipe_mnf_id` ASC) VISIBLE,
  INDEX `fk_cool_pipe_cavern_cooling_plant1_idx` (`cooling_plant_id` ASC) VISIBLE,
  CONSTRAINT `fk_cool_pipe_cavern_cool_pipe_mnf1`
    FOREIGN KEY (`cool_pipe_mnf_id`)
    REFERENCES `mft_v1.0`.`cool_pipe_mnf` (`cool_pipe_mnf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cool_pipe_cavern_cooling_plant1`
    FOREIGN KEY (`cooling_plant_id`)
    REFERENCES `mft_v1.0`.`cooling_plant` (`idcooling_plant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ro_cable_cone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ro_cable_cone` (
  `ro_cable_cone_id` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `samtec_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `mb_id` VARCHAR(45) NOT NULL,
  `psu_face_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ro_cable_cone_id`, `mb_id`, `psu_face_id`),
  INDEX `fk_ro_cable_cone_mother_board1_idx` (`mb_id` ASC) VISIBLE,
  INDEX `fk_ro_cable_cone_psu_face1_idx` (`psu_face_id` ASC) VISIBLE,
  CONSTRAINT `fk_ro_cable_cone_mother_board1`
    FOREIGN KEY (`mb_id`)
    REFERENCES `mft_v1.0`.`mother_board` (`mother_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ro_cable_cone_psu_face1`
    FOREIGN KEY (`psu_face_id`)
    REFERENCES `mft_v1.0`.`psu_face` (`psu_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`dispatching_board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`dispatching_board` (
  `dispatching_board_id` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`dispatching_board_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ro_cable_abs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ro_cable_abs` (
  `ro_cable_abs_id` VARCHAR(45) NOT NULL,
  `samtec_name` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `ro_cable_cone_id` VARCHAR(45) NOT NULL,
  `dispatching_board_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ro_cable_abs_id`, `ro_cable_cone_id`, `dispatching_board_id`),
  INDEX `fk_ro_cable_abs_ro_cable_cone1_idx` (`ro_cable_cone_id` ASC) VISIBLE,
  INDEX `fk_ro_cable_abs_dispatch_board1_idx` (`dispatching_board_id` ASC) VISIBLE,
  CONSTRAINT `fk_ro_cable_abs_ro_cable_cone1`
    FOREIGN KEY (`ro_cable_cone_id`)
    REFERENCES `mft_v1.0`.`ro_cable_cone` (`ro_cable_cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ro_cable_abs_dispatch_board1`
    FOREIGN KEY (`dispatching_board_id`)
    REFERENCES `mft_v1.0`.`dispatching_board` (`dispatching_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ru_rack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ru_rack` (
  `ru_rack_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`ru_rack_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ru_crate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ru_crate` (
  `ru_crate_id` VARCHAR(45) NOT NULL,
  `rack_pos` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `ru_rack_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ru_crate_id`, `ru_rack_id`),
  INDEX `fk_ru_crate_ru_rack1_idx` (`ru_rack_id` ASC) VISIBLE,
  CONSTRAINT `fk_ru_crate_ru_rack1`
    FOREIGN KEY (`ru_rack_id`)
    REFERENCES `mft_v1.0`.`ru_rack` (`ru_rack_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`readout_unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`readout_unit` (
  `readout_unit_id` VARCHAR(45) NOT NULL,
  `crate_pos` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `ru_crate_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`readout_unit_id`, `ru_crate_id`),
  INDEX `fk_readout_unit_ru_crate1_idx` (`ru_crate_id` ASC) VISIBLE,
  CONSTRAINT `fk_readout_unit_ru_crate1`
    FOREIGN KEY (`ru_crate_id`)
    REFERENCES `mft_v1.0`.`ru_crate` (`ru_crate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`transition_board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`transition_board` (
  `transition_board_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `ru_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transition_board_id`, `ru_id`),
  INDEX `fk_tu_mezzanine_readout_unit1_idx` (`ru_id` ASC) VISIBLE,
  CONSTRAINT `fk_tu_mezzanine_readout_unit1`
    FOREIGN KEY (`ru_id`)
    REFERENCES `mft_v1.0`.`readout_unit` (`readout_unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ro_hydra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ro_hydra` (
  `ro_hydra_id` VARCHAR(45) NOT NULL,
  `samtec_name` VARCHAR(45) NULL,
  `twist` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `dboard_id` VARCHAR(45) NOT NULL,
  `transition_board_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ro_hydra_id`, `dboard_id`, `transition_board_id`),
  INDEX `fk_ro_hydra_dispatch_board1_idx` (`dboard_id` ASC) VISIBLE,
  INDEX `fk_ro_hydra_tu_mezzanine1_idx` (`transition_board_id` ASC) VISIBLE,
  CONSTRAINT `fk_ro_hydra_dispatch_board1`
    FOREIGN KEY (`dboard_id`)
    REFERENCES `mft_v1.0`.`dispatching_board` (`dispatching_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ro_hydra_tu_mezzanine1`
    FOREIGN KEY (`transition_board_id`)
    REFERENCES `mft_v1.0`.`transition_board` (`transition_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`psu_interface`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`psu_interface` (
  `psu_interface_id` VARCHAR(45) NOT NULL,
  `crate_pos` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `ru_crate_id` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`psu_interface_id`, `ru_crate_id`),
  INDEX `fk_psu_interface_ru_crate1_idx` (`ru_crate_id` ASC) VISIBLE,
  CONSTRAINT `fk_psu_interface_ru_crate1`
    FOREIGN KEY (`ru_crate_id`)
    REFERENCES `mft_v1.0`.`ru_crate` (`ru_crate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`data_link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`data_link` (
  `data_link_id` VARCHAR(45) NOT NULL,
  `type` INT NULL,
  `polarity` INT NULL,
  `sca_id` INT NULL,
  `pcb_in_connect` VARCHAR(45) NULL,
  `pcb_in_pin` INT NULL,
  `pcb_out_connect` VARCHAR(45) NULL,
  `pcb_out_pin` INT NULL,
  `has_mb` INT NOT NULL,
  `has_mb01` INT NOT NULL,
  `mb01_in_connect` VARCHAR(45) NULL,
  `mb01_in_pin` INT NULL,
  `mb01_out_connect` VARCHAR(45) NULL,
  `mb01_out_pin` INT NULL,
  `mb2_in_connect` VARCHAR(45) NULL,
  `mb2_in_pin` INT NULL,
  `mb2_out_connect` VARCHAR(45) NULL,
  `mb2_out_pin` INT NULL,
  `ccone_in_connect` VARCHAR(45) NULL,
  `ccone_in_pin` INT NULL,
  `ccone_out_connect` VARCHAR(45) NULL,
  `ccone_out_pin` INT NULL,
  `cabs_in_connect` VARCHAR(45) NULL,
  `cabs_in_pin` INT NULL,
  `cabs_out_connect` VARCHAR(45) NULL,
  `cabs_out_pin` INT NULL,
  `disp_in_connect` VARCHAR(45) NULL,
  `disp_in_pin` INT NULL,
  `disp_out_connect` VARCHAR(45) NULL,
  `hydra_in_connect` VARCHAR(45) NULL,
  `hydra_in_pin` INT NULL,
  `hydra_out_connect` VARCHAR(45) NULL,
  `hydra_out_pin` INT NULL,
  `tb_in_connect` VARCHAR(45) NULL,
  `tb_in_pin` INT NULL,
  `psui_connect` VARCHAR(45) NULL,
  `psui_pin` INT NULL,
  `ladder_id` VARCHAR(45) NOT NULL,
  `zone_id` VARCHAR(45) NOT NULL,
  `disk_face_id` VARCHAR(45) NOT NULL,
  `mb_id` VARCHAR(45) NOT NULL,
  `ro_cable_cone_id` VARCHAR(45) NOT NULL,
  `ro_cable_abs_id` VARCHAR(45) NOT NULL,
  `dispatching_board_id` VARCHAR(45) NOT NULL,
  `ro_hydra_id` VARCHAR(45) NOT NULL,
  `transition_board_id` VARCHAR(45) NOT NULL,
  `psu_face_id` VARCHAR(45) NOT NULL,
  `psu_interface_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`data_link_id`, `ladder_id`, `zone_id`, `disk_face_id`, `mb_id`, `ro_cable_cone_id`, `ro_cable_abs_id`, `dispatching_board_id`, `ro_hydra_id`, `transition_board_id`, `psu_face_id`, `psu_interface_id`),
  INDEX `fk_data_link_ladder1_idx` (`ladder_id` ASC) VISIBLE,
  INDEX `fk_data_link_zone1_idx` (`zone_id` ASC) VISIBLE,
  INDEX `fk_data_link_disk_face1_idx` (`disk_face_id` ASC) VISIBLE,
  INDEX `fk_data_link_mother_board1_idx` (`mb_id` ASC) VISIBLE,
  INDEX `fk_data_link_ro_cable_cone1_idx` (`ro_cable_cone_id` ASC) VISIBLE,
  INDEX `fk_data_link_ro_cable_abs1_idx` (`ro_cable_abs_id` ASC) VISIBLE,
  INDEX `fk_data_link_dispatch_board1_idx` (`dispatching_board_id` ASC) VISIBLE,
  INDEX `fk_data_link_ro_hydra1_idx` (`ro_hydra_id` ASC) VISIBLE,
  INDEX `fk_data_link_tu_mezzanine1_idx` (`transition_board_id` ASC) VISIBLE,
  INDEX `fk_data_link_psu_face1_idx` (`psu_face_id` ASC) VISIBLE,
  INDEX `fk_data_link_psu_interface1_idx` (`psu_interface_id` ASC) VISIBLE,
  CONSTRAINT `fk_data_link_ladder1`
    FOREIGN KEY (`ladder_id`)
    REFERENCES `mft_v1.0`.`ladder` (`ladder_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_zone1`
    FOREIGN KEY (`zone_id`)
    REFERENCES `mft_v1.0`.`zone` (`zone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_disk_face1`
    FOREIGN KEY (`disk_face_id`)
    REFERENCES `mft_v1.0`.`disk_face` (`disk_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_mother_board1`
    FOREIGN KEY (`mb_id`)
    REFERENCES `mft_v1.0`.`mother_board` (`mother_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_ro_cable_cone1`
    FOREIGN KEY (`ro_cable_cone_id`)
    REFERENCES `mft_v1.0`.`ro_cable_cone` (`ro_cable_cone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_ro_cable_abs1`
    FOREIGN KEY (`ro_cable_abs_id`)
    REFERENCES `mft_v1.0`.`ro_cable_abs` (`ro_cable_abs_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_dispatch_board1`
    FOREIGN KEY (`dispatching_board_id`)
    REFERENCES `mft_v1.0`.`dispatching_board` (`dispatching_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_ro_hydra1`
    FOREIGN KEY (`ro_hydra_id`)
    REFERENCES `mft_v1.0`.`ro_hydra` (`ro_hydra_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_tu_mezzanine1`
    FOREIGN KEY (`transition_board_id`)
    REFERENCES `mft_v1.0`.`transition_board` (`transition_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_psu_face1`
    FOREIGN KEY (`psu_face_id`)
    REFERENCES `mft_v1.0`.`psu_face` (`psu_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_link_psu_interface1`
    FOREIGN KEY (`psu_interface_id`)
    REFERENCES `mft_v1.0`.`psu_interface` (`psu_interface_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cool_pipe_ru`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cool_pipe_ru` (
  `cool_pipe_ru_id` VARCHAR(45) NOT NULL,
  `type` INT NULL,
  `en_cv_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `cooling_plant_id` VARCHAR(45) NOT NULL,
  `ru_rack_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cool_pipe_ru_id`, `cooling_plant_id`, `ru_rack_id`),
  INDEX `fk_cool_pipe_cavern_cooling_plant1_idx` (`cooling_plant_id` ASC) VISIBLE,
  INDEX `fk_cool_pipe_ru_ru_rack1_idx` (`ru_rack_id` ASC) VISIBLE,
  CONSTRAINT `fk_cool_pipe_cavern_cooling_plant10`
    FOREIGN KEY (`cooling_plant_id`)
    REFERENCES `mft_v1.0`.`cooling_plant` (`idcooling_plant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cool_pipe_ru_ru_rack1`
    FOREIGN KEY (`ru_rack_id`)
    REFERENCES `mft_v1.0`.`ru_rack` (`ru_rack_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`pit_term_plate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`pit_term_plate` (
  `pit_term_plate_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pit_term_plate_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`abs_mtp_lc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`abs_mtp_lc` (
  `abs_mtp_lc_id` VARCHAR(45) NOT NULL,
  `term_plate_pos` INT NULL,
  `term_plate_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`abs_mtp_lc_id`, `term_plate_id`),
  INDEX `fk_patch_cord_abs_term_plate1_idx` (`term_plate_id` ASC) VISIBLE,
  CONSTRAINT `fk_patch_cord_abs_term_plate1`
    FOREIGN KEY (`term_plate_id`)
    REFERENCES `mft_v1.0`.`pit_term_plate` (`pit_term_plate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`flp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`flp` (
  `flp_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`flp_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cr1_mtp_mtp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cr1_mtp_mtp` (
  `cr1_mtp_mtp_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cr1_mtp_mtp_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cr1_term_plate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cr1_term_plate` (
  `cr1_term_plate_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cr1_term_plate_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cr1_mtp_lc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cr1_mtp_lc` (
  `cr1_mtp_lc_id` VARCHAR(45) NOT NULL,
  `cru_out` INT NULL,
  `cr1_term_plate_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cr1_mtp_lc_id`, `cr1_term_plate_id`),
  INDEX `fk_cr1_mtp_lc_cr1_term_plate1_idx` (`cr1_term_plate_id` ASC) VISIBLE,
  CONSTRAINT `fk_cr1_mtp_lc_cr1_term_plate1`
    FOREIGN KEY (`cr1_term_plate_id`)
    REFERENCES `mft_v1.0`.`cr1_term_plate` (`cr1_term_plate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`cru`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`cru` (
  `cru_id` VARCHAR(45) NOT NULL,
  `ref_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `flp_pos` INT NULL,
  `flp_id` VARCHAR(45) NOT NULL,
  `cr1_mtp_mtp_id` VARCHAR(45) NOT NULL,
  `cr1_mtp_lc_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cru_id`, `flp_id`, `cr1_mtp_mtp_id`, `cr1_mtp_lc_id`),
  INDEX `fk_cru_flp1_idx` (`flp_id` ASC) VISIBLE,
  INDEX `fk_cru_cr1_mtp_mtp1_idx` (`cr1_mtp_mtp_id` ASC) VISIBLE,
  INDEX `fk_cru_cr1_mtp_lc1_idx` (`cr1_mtp_lc_id` ASC) VISIBLE,
  CONSTRAINT `fk_cru_flp1`
    FOREIGN KEY (`flp_id`)
    REFERENCES `mft_v1.0`.`flp` (`flp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cru_cr1_mtp_mtp1`
    FOREIGN KEY (`cr1_mtp_mtp_id`)
    REFERENCES `mft_v1.0`.`cr1_mtp_mtp` (`cr1_mtp_mtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cru_cr1_mtp_lc1`
    FOREIGN KEY (`cr1_mtp_lc_id`)
    REFERENCES `mft_v1.0`.`cr1_mtp_lc` (`cr1_mtp_lc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ltu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ltu` (
  `ltu_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`ltu_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`optical_splitter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`optical_splitter` (
  `optical_splitter_id` VARCHAR(45) NOT NULL,
  `crate_pos` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `ru_crate_id` VARCHAR(45) NOT NULL,
  `ltu_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`optical_splitter_id`, `ru_crate_id`, `ltu_id`),
  INDEX `fk_optical_splitter_ru_crate1_idx` (`ru_crate_id` ASC) VISIBLE,
  INDEX `fk_optical_splitter_ltu1_idx` (`ltu_id` ASC) VISIBLE,
  CONSTRAINT `fk_optical_splitter_ru_crate1`
    FOREIGN KEY (`ru_crate_id`)
    REFERENCES `mft_v1.0`.`ru_crate` (`ru_crate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_optical_splitter_ltu1`
    FOREIGN KEY (`ltu_id`)
    REFERENCES `mft_v1.0`.`ltu` (`ltu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`pon_splitter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`pon_splitter` (
  `pon_splitter_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`pon_splitter_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`trunk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`trunk` (
  `trunk_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`trunk_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`mtp_trunk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`mtp_trunk` (
  `mtp_trunk_id` VARCHAR(45) NOT NULL,
  `pit_plate_pos` INT NULL,
  `cr1_plate_pos` INT NULL,
  `pit_term_plate_id` VARCHAR(45) NOT NULL,
  `trunk_id` VARCHAR(45) NOT NULL,
  `cr1_term_plate_id` VARCHAR(45) NOT NULL,
  `cr1_mtp_mtp_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mtp_trunk_id`, `pit_term_plate_id`, `trunk_id`, `cr1_term_plate_id`, `cr1_mtp_mtp_id`),
  INDEX `fk_trunk_pit_term_plate1_idx` (`pit_term_plate_id` ASC) VISIBLE,
  INDEX `fk_mtp_trunk_trunk1_idx` (`trunk_id` ASC) VISIBLE,
  INDEX `fk_mtp_trunk_cr1_term_plate1_idx` (`cr1_term_plate_id` ASC) VISIBLE,
  INDEX `fk_mtp_trunk_cr1_mtp_mtp1_idx` (`cr1_mtp_mtp_id` ASC) VISIBLE,
  CONSTRAINT `fk_trunk_pit_term_plate1`
    FOREIGN KEY (`pit_term_plate_id`)
    REFERENCES `mft_v1.0`.`pit_term_plate` (`pit_term_plate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mtp_trunk_trunk1`
    FOREIGN KEY (`trunk_id`)
    REFERENCES `mft_v1.0`.`trunk` (`trunk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mtp_trunk_cr1_term_plate1`
    FOREIGN KEY (`cr1_term_plate_id`)
    REFERENCES `mft_v1.0`.`cr1_term_plate` (`cr1_term_plate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mtp_trunk_cr1_mtp_mtp1`
    FOREIGN KEY (`cr1_mtp_mtp_id`)
    REFERENCES `mft_v1.0`.`cr1_mtp_mtp` (`cr1_mtp_mtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`data_fiber`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`data_fiber` (
  `data_fiber_id` VARCHAR(45) NOT NULL,
  `vt_type` INT NULL,
  `data_type` INT NULL,
  `in_out` INT NULL,
  `fiber_id` INT NULL,
  `color` INT NULL,
  `pc_abs_pos` INT NULL,
  `tp_pos` INT NULL,
  `pc_cr1_pos` INT NULL,
  `cru_link` INT NULL,
  `ltu_link` INT NULL,
  `readout_unit_id` VARCHAR(45) NOT NULL,
  `abs_mtp_lc_id` VARCHAR(45) NOT NULL,
  `cru_id` VARCHAR(45) NOT NULL,
  `optical_splitter_id` VARCHAR(45) NOT NULL,
  `pon_splitter_id` VARCHAR(45) NOT NULL,
  `mtp_trunk_id` VARCHAR(45) NOT NULL,
  `cr1_mtp_mtp_id` VARCHAR(45) NOT NULL,
  `cr1_mtp_lc_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`data_fiber_id`, `readout_unit_id`, `abs_mtp_lc_id`, `cru_id`, `optical_splitter_id`, `pon_splitter_id`, `mtp_trunk_id`, `cr1_mtp_mtp_id`, `cr1_mtp_lc_id`),
  INDEX `fk_data_fiber_patch_cord_abs1_idx` (`abs_mtp_lc_id` ASC) VISIBLE,
  INDEX `fk_data_fiber_readout_unit1_idx` (`readout_unit_id` ASC) VISIBLE,
  INDEX `fk_data_fiber_cru1_idx` (`cru_id` ASC) VISIBLE,
  INDEX `fk_data_fiber_optical_splitter1_idx` (`optical_splitter_id` ASC) VISIBLE,
  INDEX `fk_data_fiber_pon_splitter1_idx` (`pon_splitter_id` ASC) VISIBLE,
  INDEX `fk_data_fiber_trunk1_idx` (`mtp_trunk_id` ASC) VISIBLE,
  INDEX `fk_data_fiber_cr1_mtp_mtp1_idx` (`cr1_mtp_mtp_id` ASC) VISIBLE,
  INDEX `fk_data_fiber_cr1_mtp_lc1_idx` (`cr1_mtp_lc_id` ASC) VISIBLE,
  CONSTRAINT `fk_data_fiber_patch_cord_abs1`
    FOREIGN KEY (`abs_mtp_lc_id`)
    REFERENCES `mft_v1.0`.`abs_mtp_lc` (`abs_mtp_lc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_fiber_readout_unit1`
    FOREIGN KEY (`readout_unit_id`)
    REFERENCES `mft_v1.0`.`readout_unit` (`readout_unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_fiber_cru1`
    FOREIGN KEY (`cru_id`)
    REFERENCES `mft_v1.0`.`cru` (`cru_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_fiber_optical_splitter1`
    FOREIGN KEY (`optical_splitter_id`)
    REFERENCES `mft_v1.0`.`optical_splitter` (`optical_splitter_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_fiber_pon_splitter1`
    FOREIGN KEY (`pon_splitter_id`)
    REFERENCES `mft_v1.0`.`pon_splitter` (`pon_splitter_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_fiber_trunk1`
    FOREIGN KEY (`mtp_trunk_id`)
    REFERENCES `mft_v1.0`.`mtp_trunk` (`mtp_trunk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_fiber_cr1_mtp_mtp1`
    FOREIGN KEY (`cr1_mtp_mtp_id`)
    REFERENCES `mft_v1.0`.`cr1_mtp_mtp` (`cr1_mtp_mtp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_data_fiber_cr1_mtp_lc1`
    FOREIGN KEY (`cr1_mtp_lc_id`)
    REFERENCES `mft_v1.0`.`cr1_mtp_lc` (`cr1_mtp_lc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`main_frame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`main_frame` (
  `main_frame_id` VARCHAR(45) NOT NULL,
  `ref_name` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`main_frame_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`branch_controller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`branch_controller` (
  `branch_controller_id` VARCHAR(45) NOT NULL,
  `ref_name` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `mf_slot` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `main_frame_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`branch_controller_id`, `main_frame_id`),
  INDEX `fk_branch_controller_main_frame1_idx` (`main_frame_id` ASC) VISIBLE,
  CONSTRAINT `fk_branch_controller_main_frame1`
    FOREIGN KEY (`main_frame_id`)
    REFERENCES `mft_v1.0`.`main_frame` (`main_frame_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`power_generator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`power_generator` (
  `power_generator_id` VARCHAR(45) NOT NULL,
  `ref_name` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`power_generator_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`easy_crate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`easy_crate` (
  `easy_crate_id` VARCHAR(45) NOT NULL,
  `ref_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `branch_controller_id` VARCHAR(45) NOT NULL,
  `power_generator_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`easy_crate_id`, `branch_controller_id`, `power_generator_id`),
  INDEX `fk_easy_branch_controller1_idx` (`branch_controller_id` ASC) VISIBLE,
  INDEX `fk_easy_power_gen1_idx` (`power_generator_id` ASC) VISIBLE,
  CONSTRAINT `fk_easy_branch_controller1`
    FOREIGN KEY (`branch_controller_id`)
    REFERENCES `mft_v1.0`.`branch_controller` (`branch_controller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_easy_power_gen1`
    FOREIGN KEY (`power_generator_id`)
    REFERENCES `mft_v1.0`.`power_generator` (`power_generator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`power_module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`power_module` (
  `power_module_id` VARCHAR(45) NOT NULL,
  `ref_name` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `easy_slot` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `easy_crate_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`power_module_id`, `easy_crate_id`),
  INDEX `fk_power_module_easy_crate1_idx` (`easy_crate_id` ASC) VISIBLE,
  CONSTRAINT `fk_power_module_easy_crate1`
    FOREIGN KEY (`easy_crate_id`)
    REFERENCES `mft_v1.0`.`easy_crate` (`easy_crate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`control_cable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`control_cable` (
  `control_cable_id` VARCHAR(45) NOT NULL,
  `en_el_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `branch_controller_id` VARCHAR(45) NOT NULL,
  `power_generator_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`control_cable_id`, `branch_controller_id`, `power_generator_id`),
  INDEX `fk_control_line_branch_controller1_idx` (`branch_controller_id` ASC) VISIBLE,
  INDEX `fk_control_cable_power_generator1_idx` (`power_generator_id` ASC) VISIBLE,
  CONSTRAINT `fk_control_line_branch_controller1`
    FOREIGN KEY (`branch_controller_id`)
    REFERENCES `mft_v1.0`.`branch_controller` (`branch_controller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_cable_power_generator1`
    FOREIGN KEY (`power_generator_id`)
    REFERENCES `mft_v1.0`.`power_generator` (`power_generator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`service_power_cable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`service_power_cable` (
  `service_power_cable_id` VARCHAR(45) NOT NULL,
  `en_el_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(45) NULL,
  `branch_controller_id` VARCHAR(45) NOT NULL,
  `power_generator_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`service_power_cable_id`, `branch_controller_id`, `power_generator_id`),
  INDEX `fk_service_power_link_branch_controller1_idx` (`branch_controller_id` ASC) VISIBLE,
  INDEX `fk_service_power_cable_power_generator1_idx` (`power_generator_id` ASC) VISIBLE,
  CONSTRAINT `fk_service_power_link_branch_controller1`
    FOREIGN KEY (`branch_controller_id`)
    REFERENCES `mft_v1.0`.`branch_controller` (`branch_controller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_power_cable_power_generator1`
    FOREIGN KEY (`power_generator_id`)
    REFERENCES `mft_v1.0`.`power_generator` (`power_generator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ps_cable_ru`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ps_cable_ru` (
  `ps_cable_ru_id` VARCHAR(45) NOT NULL,
  `en_el_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `power_module_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ps_cable_ru_id`, `power_module_id`),
  INDEX `fk_ps_cable_ru_power_module1_idx` (`power_module_id` ASC) VISIBLE,
  CONSTRAINT `fk_ps_cable_ru_power_module1`
    FOREIGN KEY (`power_module_id`)
    REFERENCES `mft_v1.0`.`power_module` (`power_module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ps_cable_ga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ps_cable_ga` (
  `ps_cable_ga_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `readout_unit_id` VARCHAR(45) NOT NULL,
  `ps_cable_ru_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ps_cable_ga_id`, `readout_unit_id`, `ps_cable_ru_id`),
  INDEX `fk_ps_cable_ga_readout_unit1_idx` (`readout_unit_id` ASC) VISIBLE,
  INDEX `fk_ps_cable_ga_ps_cable_ru1_idx` (`ps_cable_ru_id` ASC) VISIBLE,
  CONSTRAINT `fk_ps_cable_ga_readout_unit1`
    FOREIGN KEY (`readout_unit_id`)
    REFERENCES `mft_v1.0`.`readout_unit` (`readout_unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ps_cable_ga_ps_cable_ru1`
    FOREIGN KEY (`ps_cable_ru_id`)
    REFERENCES `mft_v1.0`.`ps_cable_ru` (`ps_cable_ru_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`pp0_socket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`pp0_socket` (
  `pp0_socket_id` VARCHAR(45) NOT NULL,
  `side` VARCHAR(1) NULL,
  `doc_link` VARCHAR(250) NULL,
  PRIMARY KEY (`pp0_socket_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ps_cable_cav`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ps_cable_cav` (
  `ps_cable_cav_id` VARCHAR(45) NOT NULL,
  `en_el_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `pp0_socket_id` VARCHAR(45) NOT NULL,
  `power_module_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ps_cable_cav_id`, `pp0_socket_id`, `power_module_id`),
  INDEX `fk_ps_cable_cav_pp11_idx` (`pp0_socket_id` ASC) VISIBLE,
  INDEX `fk_ps_cable_cav_power_module1_idx` (`power_module_id` ASC) VISIBLE,
  CONSTRAINT `fk_ps_cable_cav_pp11`
    FOREIGN KEY (`pp0_socket_id`)
    REFERENCES `mft_v1.0`.`pp0_socket` (`pp0_socket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ps_cable_cav_power_module1`
    FOREIGN KEY (`power_module_id`)
    REFERENCES `mft_v1.0`.`power_module` (`power_module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ps_cable_mnf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ps_cable_mnf` (
  `ps_cable_mnf_id` VARCHAR(45) NOT NULL,
  `en_el_name` VARCHAR(45) NULL,
  `doc_link` VARCHAR(250) NULL,
  `pp0_socket_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ps_cable_mnf_id`, `pp0_socket_id`),
  INDEX `fk_ps_cable_mnf_pp11_idx` (`pp0_socket_id` ASC) VISIBLE,
  CONSTRAINT `fk_ps_cable_mnf_pp11`
    FOREIGN KEY (`pp0_socket_id`)
    REFERENCES `mft_v1.0`.`pp0_socket` (`pp0_socket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`pp2_socket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`pp2_socket` (
  `pp2_socket_id` VARCHAR(45) NOT NULL,
  `side` VARCHAR(1) NULL,
  `doc_link` VARCHAR(250) NULL,
  `ps_cable_mnf_ps_cable_mnf_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pp2_socket_id`, `ps_cable_mnf_ps_cable_mnf_id`),
  INDEX `fk_pp2_socket_ps_cable_mnf1_idx` (`ps_cable_mnf_ps_cable_mnf_id` ASC) VISIBLE,
  CONSTRAINT `fk_pp2_socket_ps_cable_mnf1`
    FOREIGN KEY (`ps_cable_mnf_ps_cable_mnf_id`)
    REFERENCES `mft_v1.0`.`ps_cable_mnf` (`ps_cable_mnf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ps_cable_barr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ps_cable_barr` (
  `ps_cable_barr_id` VARCHAR(45) NOT NULL,
  `filter_board_pos` INT NULL,
  `doc_link` VARCHAR(250) NULL,
  `filter_board_id` VARCHAR(45) NOT NULL,
  `pp2_socket_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ps_cable_barr_id`, `filter_board_id`, `pp2_socket_id`),
  INDEX `fk_ps_cable_barr_filter_board1_idx` (`filter_board_id` ASC) VISIBLE,
  INDEX `fk_ps_cable_barr_pp2_socket1_idx` (`pp2_socket_id` ASC) VISIBLE,
  CONSTRAINT `fk_ps_cable_barr_filter_board1`
    FOREIGN KEY (`filter_board_id`)
    REFERENCES `mft_v1.0`.`filter_board` (`filter_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ps_cable_barr_pp2_socket1`
    FOREIGN KEY (`pp2_socket_id`)
    REFERENCES `mft_v1.0`.`pp2_socket` (`pp2_socket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ps_cable_psu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ps_cable_psu` (
  `ps_cable_psu_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `filter_board_id` VARCHAR(45) NOT NULL,
  `psu_face_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ps_cable_psu_id`, `filter_board_id`, `psu_face_id`),
  INDEX `fk_ps_cable_psu_filter_board1_idx` (`filter_board_id` ASC) VISIBLE,
  INDEX `fk_ps_cable_psu_psu_face1_idx` (`psu_face_id` ASC) VISIBLE,
  CONSTRAINT `fk_ps_cable_psu_filter_board1`
    FOREIGN KEY (`filter_board_id`)
    REFERENCES `mft_v1.0`.`filter_board` (`filter_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ps_cable_psu_psu_face1`
    FOREIGN KEY (`psu_face_id`)
    REFERENCES `mft_v1.0`.`psu_face` (`psu_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`ps_cable_disk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`ps_cable_disk` (
  `ps_cable_disk_id` VARCHAR(45) NOT NULL,
  `doc_link` VARCHAR(250) NULL,
  `psu_face_id` VARCHAR(45) NOT NULL,
  `disk_face_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ps_cable_disk_id`, `psu_face_id`, `disk_face_id`),
  INDEX `fk_ps_cable_disk_psu_face1_idx` (`psu_face_id` ASC) VISIBLE,
  INDEX `fk_ps_cable_disk_disk_face1_idx` (`disk_face_id` ASC) VISIBLE,
  CONSTRAINT `fk_ps_cable_disk_psu_face1`
    FOREIGN KEY (`psu_face_id`)
    REFERENCES `mft_v1.0`.`psu_face` (`psu_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ps_cable_disk_disk_face1`
    FOREIGN KEY (`disk_face_id`)
    REFERENCES `mft_v1.0`.`disk_face` (`disk_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`power_link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`power_link` (
  `power_link_id` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `module_ch` INT NULL,
  `ps_ccav_cond` VARCHAR(45) NULL,
  `ps_pp0_pin` INT NULL,
  `ps_cmnf_cond` VARCHAR(45) NULL,
  `ps_pp2_pin` INT NULL,
  `ps_fbin_pin` VARCHAR(45) NULL,
  `ps_fbout_pin` VARCHAR(45) NULL,
  `ps_cpsu_pin` VARCHAR(45) NULL,
  `ps_cru_cond` VARCHAR(45) NULL,
  `ps_cgu_cond` VARCHAR(45) NULL,
  `power_module_id` VARCHAR(45) NOT NULL,
  `ps_cable_cav_id` VARCHAR(45) NOT NULL,
  `pp0_socket_id` VARCHAR(45) NOT NULL,
  `ps_cable_mnf_id` VARCHAR(45) NOT NULL,
  `ps_cable_barrel_id` VARCHAR(45) NOT NULL,
  `filter_board_id` VARCHAR(45) NOT NULL,
  `ps_cable_psu_id` VARCHAR(45) NOT NULL,
  `psu_face_id` VARCHAR(45) NOT NULL,
  `ps_cable_ru_id` VARCHAR(45) NOT NULL,
  `ps_cable_ga_id` VARCHAR(45) NOT NULL,
  `readout_unit_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`power_link_id`, `power_module_id`, `ps_cable_cav_id`, `pp0_socket_id`, `ps_cable_mnf_id`, `ps_cable_barrel_id`, `filter_board_id`, `ps_cable_psu_id`, `psu_face_id`, `ps_cable_ru_id`, `ps_cable_ga_id`, `readout_unit_id`),
  INDEX `fk_power_link_power_module1_idx` (`power_module_id` ASC) VISIBLE,
  INDEX `fk_power_link_ps_cable_cav1_idx` (`ps_cable_cav_id` ASC) VISIBLE,
  INDEX `fk_power_link_pp11_idx` (`pp0_socket_id` ASC) VISIBLE,
  INDEX `fk_power_link_ps_cable_mnf1_idx` (`ps_cable_mnf_id` ASC) VISIBLE,
  INDEX `fk_power_link_ps_cable_barr1_idx` (`ps_cable_barrel_id` ASC) VISIBLE,
  INDEX `fk_power_link_filter_board1_idx` (`filter_board_id` ASC) VISIBLE,
  INDEX `fk_power_link_ps_cable_psu1_idx` (`ps_cable_psu_id` ASC) VISIBLE,
  INDEX `fk_power_link_psu_face1_idx` (`psu_face_id` ASC) VISIBLE,
  INDEX `fk_power_link_ps_cable_ru1_idx` (`ps_cable_ru_id` ASC) VISIBLE,
  INDEX `fk_power_link_ps_cable_ga1_idx` (`ps_cable_ga_id` ASC) VISIBLE,
  INDEX `fk_power_link_readout_unit1_idx` (`readout_unit_id` ASC) VISIBLE,
  CONSTRAINT `fk_power_link_power_module1`
    FOREIGN KEY (`power_module_id`)
    REFERENCES `mft_v1.0`.`power_module` (`power_module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_ps_cable_cav1`
    FOREIGN KEY (`ps_cable_cav_id`)
    REFERENCES `mft_v1.0`.`ps_cable_cav` (`ps_cable_cav_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_pp11`
    FOREIGN KEY (`pp0_socket_id`)
    REFERENCES `mft_v1.0`.`pp0_socket` (`pp0_socket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_ps_cable_mnf1`
    FOREIGN KEY (`ps_cable_mnf_id`)
    REFERENCES `mft_v1.0`.`ps_cable_mnf` (`ps_cable_mnf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_ps_cable_barr1`
    FOREIGN KEY (`ps_cable_barrel_id`)
    REFERENCES `mft_v1.0`.`ps_cable_barr` (`ps_cable_barr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_filter_board1`
    FOREIGN KEY (`filter_board_id`)
    REFERENCES `mft_v1.0`.`filter_board` (`filter_board_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_ps_cable_psu1`
    FOREIGN KEY (`ps_cable_psu_id`)
    REFERENCES `mft_v1.0`.`ps_cable_psu` (`ps_cable_psu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_psu_face1`
    FOREIGN KEY (`psu_face_id`)
    REFERENCES `mft_v1.0`.`psu_face` (`psu_face_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_ps_cable_ru1`
    FOREIGN KEY (`ps_cable_ru_id`)
    REFERENCES `mft_v1.0`.`ps_cable_ru` (`ps_cable_ru_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_ps_cable_ga1`
    FOREIGN KEY (`ps_cable_ga_id`)
    REFERENCES `mft_v1.0`.`ps_cable_ga` (`ps_cable_ga_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_power_link_readout_unit1`
    FOREIGN KEY (`readout_unit_id`)
    REFERENCES `mft_v1.0`.`readout_unit` (`readout_unit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mft_v1.0`.`psu_link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mft_v1.0`.`psu_link` (
  `psu_link_id` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `ps_psuin_pin` INT NULL,
  `ps_psuout_pin` INT NULL,
  `ps_diskin_pin` INT NULL,
  `dc_dc_id` VARCHAR(45) NOT NULL,
  `ps_cable_psu_id` VARCHAR(45) NOT NULL,
  `ps_cable_disk_id` VARCHAR(45) NOT NULL,
  `zone_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`psu_link_id`, `dc_dc_id`, `ps_cable_psu_id`, `ps_cable_disk_id`, `zone_id`),
  INDEX `fk_psu_link_ps_cable_psu1_idx` (`ps_cable_psu_id` ASC) VISIBLE,
  INDEX `fk_psu_link_dc_dc1_idx` (`dc_dc_id` ASC) VISIBLE,
  INDEX `fk_psu_link_zone1_idx` (`zone_id` ASC) VISIBLE,
  INDEX `fk_psu_link_ps_cable_disk1_idx` (`ps_cable_disk_id` ASC) VISIBLE,
  CONSTRAINT `fk_psu_link_ps_cable_psu1`
    FOREIGN KEY (`ps_cable_psu_id`)
    REFERENCES `mft_v1.0`.`ps_cable_psu` (`ps_cable_psu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_psu_link_dc_dc1`
    FOREIGN KEY (`dc_dc_id`)
    REFERENCES `mft_v1.0`.`dc_dc` (`dc_dc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_psu_link_zone1`
    FOREIGN KEY (`zone_id`)
    REFERENCES `mft_v1.0`.`zone` (`zone_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_psu_link_ps_cable_disk1`
    FOREIGN KEY (`ps_cable_disk_id`)
    REFERENCES `mft_v1.0`.`ps_cable_disk` (`ps_cable_disk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
