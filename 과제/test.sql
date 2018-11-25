-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `new_schema` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `new_schema` ;

-- -----------------------------------------------------
-- Table `new_schema`.`character`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`character` (
  `Level` INT(10) UNSIGNED NOT NULL,
  `HP` INT(10) UNSIGNED NOT NULL,
  `Status` SET('위력', '방어력', '강인함', '막기', '크리티컬', '크리티컬데미지', '회피', '이동속도', '공격속도', '재장전속도', '대시공격력', '고정데미지', '상태이상확률') NOT NULL,
  `Skills` SET('분노', '신속', '인내', '신비', '탐욕') NOT NULL,
  `Clothes` VARCHAR(45) NOT NULL,
  `Weapons` VARCHAR(45) NOT NULL,
  `Accessories` VARCHAR(45) NOT NULL,
  `Food` VARCHAR(45) NULL DEFAULT NULL,
  `Stage` INT(10) UNSIGNED ZEROFILL NOT NULL,
  `NPC(using)` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Level`, `Clothes`),
  UNIQUE INDEX `이용중인 NPC_UNIQUE` (`NPC(using)` ASC) VISIBLE,
  UNIQUE INDEX `Level_UNIQUE` (`Level` ASC) VISIBLE,
  UNIQUE INDEX `Status_UNIQUE` (`Status` ASC) VISIBLE,
  UNIQUE INDEX `HP_UNIQUE` (`HP` ASC) VISIBLE,
  UNIQUE INDEX `Skills_UNIQUE` (`Skills` ASC) VISIBLE,
  UNIQUE INDEX `Stage_UNIQUE` (`Stage` ASC) VISIBLE,
  UNIQUE INDEX `Clothes_UNIQUE` (`Clothes` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `new_schema`.`accessory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`accessory` (
  `Name` VARCHAR(45) NOT NULL,
  `Grade` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `Grade_UNIQUE` (`Grade` ASC) VISIBLE,
  UNIQUE INDEX `Type_UNIQUE` (`Type` ASC) VISIBLE,
  CONSTRAINT `Accessories`
    FOREIGN KEY (`Name`)
    REFERENCES `new_schema`.`character` (`Accessories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `new_schema`.`clothe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`clothe` (
  `Name` VARCHAR(45) NOT NULL,
  `Effect` VARCHAR(45) NOT NULL,
  `Appearance` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `Appearance_UNIQUE` (`Appearance` ASC) VISIBLE,
  UNIQUE INDEX `Effect_UNIQUE` (`Effect` ASC) VISIBLE,
  CONSTRAINT `Clothes`
    FOREIGN KEY (`Name`)
    REFERENCES `new_schema`.`character` (`Clothes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `new_schema`.`dungeon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`dungeon` (
  `Stage` INT(10) UNSIGNED ZEROFILL NOT NULL,
  `Boss` VARCHAR(45) NOT NULL,
  `Region` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Stage`),
  UNIQUE INDEX `Stage_UNIQUE` (`Stage` ASC) VISIBLE,
  UNIQUE INDEX `Boss_UNIQUE` (`Boss` ASC) VISIBLE,
  UNIQUE INDEX `Region_UNIQUE` (`Region` ASC) VISIBLE,
  CONSTRAINT `Stage`
    FOREIGN KEY (`Stage`)
    REFERENCES `new_schema`.`character` (`Stage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `new_schema`.`food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`food` (
  `Name` VARCHAR(45) NOT NULL,
  `Effect` VARCHAR(45) NOT NULL,
  `Satiety` INT(10) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `Effect_UNIQUE` (`Effect` ASC) VISIBLE,
  UNIQUE INDEX `Satiety_UNIQUE` (`Satiety` ASC) VISIBLE,
  CONSTRAINT `Food`
    FOREIGN KEY (`Name`)
    REFERENCES `new_schema`.`character` (`Food`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `new_schema`.`npc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`npc` (
  `Name` VARCHAR(45) NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `Local_UNIQUE` (`Local` ASC) VISIBLE,
  UNIQUE INDEX `Role_UNIQUE` (`Role` ASC) VISIBLE,
  PRIMARY KEY (`Name`),
  CONSTRAINT `Name`
    FOREIGN KEY (`Name`)
    REFERENCES `new_schema`.`character` (`NPC(using)`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `new_schema`.`weapon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`weapon` (
  `Name` VARCHAR(45) NOT NULL,
  `Grade` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `Weaponcol_UNIQUE` (`Type` ASC) VISIBLE,
  UNIQUE INDEX `Grade_UNIQUE` (`Grade` ASC) VISIBLE,
  CONSTRAINT `Weapons`
    FOREIGN KEY (`Name`)
    REFERENCES `new_schema`.`character` (`Weapons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
