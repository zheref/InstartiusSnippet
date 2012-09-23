SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `instarti_snippet` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `instarti_snippet` ;

-- -----------------------------------------------------
-- Table `instarti_snippet`.`USUARIO`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`USUARIO` (
  `NICKNAME` VARCHAR(20) NOT NULL ,
  `PASSWORD` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`NICKNAME`) ,
  UNIQUE INDEX `NICKNAME_UNIQUE` (`NICKNAME` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`PROBLEMA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`PROBLEMA` (
  `PRO_ID` INT NOT NULL AUTO_INCREMENT ,
  `STATEMENT` VARCHAR(70) NOT NULL ,
  `USUARIO_NICKNAME` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`PRO_ID`) ,
  UNIQUE INDEX `PRO_ID_UNIQUE` (`PRO_ID` ASC) ,
  UNIQUE INDEX `STATEMENT_UNIQUE` (`STATEMENT` ASC) ,
  INDEX `fk_PROBLEMA_USUARIO_idx` (`USUARIO_NICKNAME` ASC) ,
  CONSTRAINT `fk_PROBLEMA_USUARIO`
    FOREIGN KEY (`USUARIO_NICKNAME` )
    REFERENCES `instarti_snippet`.`USUARIO` (`NICKNAME` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`SOLUCION`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`SOLUCION` (
  `SOL_ID` INT NOT NULL AUTO_INCREMENT ,
  `USUARIO_NICKNAME` VARCHAR(20) NOT NULL ,
  `PROBLEMA_PRO_ID` INT NOT NULL ,
  PRIMARY KEY (`SOL_ID`) ,
  UNIQUE INDEX `SOL_ID_UNIQUE` (`SOL_ID` ASC) ,
  INDEX `fk_SOLUCION_USUARIO1_idx` (`USUARIO_NICKNAME` ASC) ,
  INDEX `fk_SOLUCION_PROBLEMA1_idx` (`PROBLEMA_PRO_ID` ASC) ,
  CONSTRAINT `fk_SOLUCION_USUARIO1`
    FOREIGN KEY (`USUARIO_NICKNAME` )
    REFERENCES `instarti_snippet`.`USUARIO` (`NICKNAME` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SOLUCION_PROBLEMA1`
    FOREIGN KEY (`PROBLEMA_PRO_ID` )
    REFERENCES `instarti_snippet`.`PROBLEMA` (`PRO_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`COMENTARIO`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`COMENTARIO` (
  `COM_ID` INT NOT NULL AUTO_INCREMENT ,
  `CONTENT` VARCHAR(255) NOT NULL ,
  `SOLUCION_SOL_ID` INT NOT NULL ,
  `USUARIO_NICKNAME` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`COM_ID`) ,
  UNIQUE INDEX `COM_ID_UNIQUE` (`COM_ID` ASC) ,
  INDEX `fk_COMENTARIO_SOLUCION1_idx` (`SOLUCION_SOL_ID` ASC) ,
  INDEX `fk_COMENTARIO_USUARIO1_idx` (`USUARIO_NICKNAME` ASC) ,
  CONSTRAINT `fk_COMENTARIO_SOLUCION1`
    FOREIGN KEY (`SOLUCION_SOL_ID` )
    REFERENCES `instarti_snippet`.`SOLUCION` (`SOL_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMENTARIO_USUARIO1`
    FOREIGN KEY (`USUARIO_NICKNAME` )
    REFERENCES `instarti_snippet`.`USUARIO` (`NICKNAME` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`TECNOLOGIA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`TECNOLOGIA` (
  `TEC_ID` INT NOT NULL AUTO_INCREMENT ,
  `NAME` VARCHAR(25) NOT NULL ,
  `WEBPAGE` VARCHAR(30) NOT NULL ,
  `REFERENCE` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`TEC_ID`) ,
  UNIQUE INDEX `NAME_UNIQUE` (`NAME` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`CODIGO`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`CODIGO` (
  `COD_ID` INT NOT NULL AUTO_INCREMENT ,
  `MODNAME` VARCHAR(20) NULL ,
  `EXTENSION` VARCHAR(5) NULL ,
  `SOURCE` TEXT(5000) NOT NULL ,
  `SOLUCION_SOL_ID` INT NOT NULL ,
  PRIMARY KEY (`COD_ID`) ,
  UNIQUE INDEX `COD_ID_UNIQUE` (`COD_ID` ASC) ,
  INDEX `fk_CODIGO_SOLUCION1_idx` (`SOLUCION_SOL_ID` ASC) ,
  CONSTRAINT `fk_CODIGO_SOLUCION1`
    FOREIGN KEY (`SOLUCION_SOL_ID` )
    REFERENCES `instarti_snippet`.`SOLUCION` (`SOL_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`CODIGOTECNOLOGIA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`CODIGOTECNOLOGIA` (
  `FROMLINE` INT(3) NULL ,
  `TOLINE` INT(3) NULL ,
  `TECNOLOGIA_TEC_ID` INT NOT NULL ,
  `CODIGO_COD_ID` INT NOT NULL ,
  PRIMARY KEY (`TECNOLOGIA_TEC_ID`, `CODIGO_COD_ID`) ,
  INDEX `fk_CODIGOTECNOLOGIA_CODIGO1_idx` (`CODIGO_COD_ID` ASC) ,
  CONSTRAINT `fk_CODIGOTECNOLOGIA_TECNOLOGIA1`
    FOREIGN KEY (`TECNOLOGIA_TEC_ID` )
    REFERENCES `instarti_snippet`.`TECNOLOGIA` (`TEC_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CODIGOTECNOLOGIA_CODIGO1`
    FOREIGN KEY (`CODIGO_COD_ID` )
    REFERENCES `instarti_snippet`.`CODIGO` (`COD_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`ASOCIACIONTECNOLOGIA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`ASOCIACIONTECNOLOGIA` (
  `TECNOLOGIA_TEC_ID` INT NOT NULL ,
  `TECNOLOGIA_TEC_ID1` INT NOT NULL ,
  PRIMARY KEY (`TECNOLOGIA_TEC_ID`, `TECNOLOGIA_TEC_ID1`) ,
  INDEX `fk_ASOCIACION_TECNOLOGIA2_idx` (`TECNOLOGIA_TEC_ID1` ASC) ,
  CONSTRAINT `fk_ASOCIACION_TECNOLOGIA1`
    FOREIGN KEY (`TECNOLOGIA_TEC_ID` )
    REFERENCES `instarti_snippet`.`TECNOLOGIA` (`TEC_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASOCIACION_TECNOLOGIA2`
    FOREIGN KEY (`TECNOLOGIA_TEC_ID1` )
    REFERENCES `instarti_snippet`.`TECNOLOGIA` (`TEC_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`REFERENCIA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`REFERENCIA` (
  `FROMLINE` INT(3) NOT NULL ,
  `TOLINE` INT(3) NOT NULL ,
  `CODIGO_COD_ID` INT NOT NULL ,
  `CODIGO_COD_ID1` INT NOT NULL ,
  PRIMARY KEY (`CODIGO_COD_ID`, `CODIGO_COD_ID1`) ,
  INDEX `fk_REFERENCIA_CODIGO2_idx` (`CODIGO_COD_ID1` ASC) ,
  CONSTRAINT `fk_REFERENCIA_CODIGO1`
    FOREIGN KEY (`CODIGO_COD_ID` )
    REFERENCES `instarti_snippet`.`CODIGO` (`COD_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REFERENCIA_CODIGO2`
    FOREIGN KEY (`CODIGO_COD_ID1` )
    REFERENCES `instarti_snippet`.`CODIGO` (`COD_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`TAG`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`TAG` (
  `TAG_ID` INT NOT NULL AUTO_INCREMENT ,
  `LABEL` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`TAG_ID`) ,
  UNIQUE INDEX `TAG_ID_UNIQUE` (`TAG_ID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instarti_snippet`.`CODIGOTAG`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `instarti_snippet`.`CODIGOTAG` (
  `TAG_TAG_ID` INT NOT NULL ,
  `CODIGO_COD_ID` INT NOT NULL ,
  PRIMARY KEY (`TAG_TAG_ID`, `CODIGO_COD_ID`) ,
  INDEX `fk_CODIGOTAG_CODIGO1_idx` (`CODIGO_COD_ID` ASC) ,
  CONSTRAINT `fk_CODIGOTAG_TAG1`
    FOREIGN KEY (`TAG_TAG_ID` )
    REFERENCES `instarti_snippet`.`TAG` (`TAG_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CODIGOTAG_CODIGO1`
    FOREIGN KEY (`CODIGO_COD_ID` )
    REFERENCES `instarti_snippet`.`CODIGO` (`COD_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
