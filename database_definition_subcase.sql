set @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
set @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
set @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

create schema if not exists `INSTARTI_SNIPPET` default character set latin1 collate latin1_swedish_ci ;
use `INSTARTI_SNIPPET` ;

-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`USUARIO`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`USUARIOS` 
(
	`NICKNAME` 	varchar(20) 	not null ,
	`PASSWORD` 	varchar(20) 	not null ,
	
	primary key (`NICKNAME`) ,
	unique index `NICKNAME_UNIQUE` (`NICKNAME` asc) 
)

engine = InnoDB;

-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`PROBLEMA`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`PROBLEMAS` 
(
	`PRO_ID` 			int 		not null 	auto_increment ,
	`STATEMENT` 		varchar(70) not null ,
	`USUARIO_NICKNAME` 	varchar(20) not null ,
	
	primary key (`PRO_ID`) ,
	unique index `PRO_ID_UNIQUE` (`PRO_ID` asc) ,
	unique index `STATEMENT_UNIQUE` (`STATEMENT` asc) ,
  
	index `fk_PROBLEMA_USUARIO_idx` (`USUARIO_NICKNAME` asc) ,
	
	constraint `fk_PROBLEMA_USUARIO`
		foreign key (`USUARIO_NICKNAME`)
		references `INSTARTI_SNIPPET`.`USUARIO` (`NICKNAME`)
		on delete no action
		on update no action
)

engine = InnoDB;

-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`SOLUCION`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`SOLUCIONS` 
(
	`SOL_ID` 				int 		not null 	auto_increment ,
	`USUARIO_NICKNAME` 	varchar(20) not null ,
	`PROBLEMA_PRO_ID` 	int 		not null ,
	
	primary key (`SOL_ID`) ,
	unique index `SOL_ID_UNIQUE` (`SOL_ID` asc) ,
	
	index `fk_SOLUCION_USUARIO1_idx` (`USUARIO_NICKNAME` asc) ,
	index `fk_SOLUCION_PROBLEMA1_idx` (`PROBLEMA_PRO_ID` asc) ,
	
	constraint `fk_SOLUCION_USUARIO1`
		foreign key (`USUARIO_NICKNAME` )
		references `INSTARTI_SNIPPET`.`USUARIO` (`NICKNAME` )
		on delete no action
		on update no action,
	
	constraint `fk_SOLUCION_PROBLEMA1`
		foreign key (`PROBLEMA_PRO_ID` )
		references `INSTARTI_SNIPPET`.`PROBLEMA` (`PRO_ID` )
		on delete no action
		on update no action
)

engine = InnoDB;

-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`COMENTARIO`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`COMENTARIOS` 
(
	`COM_ID` 			int 			not null 	auto_increment ,
	`CONTENT` 			varchar(255) 	not null ,
	`SOLUCION_SOL_ID` 	int not null ,
	`USUARIO_NICKNAME` 	varchar(20) 	not null ,
  
	primary key (`COM_ID`) ,
	unique index `COM_ID_UNIQUE` (`COM_ID` asc) ,
	
	index `fk_COMENTARIO_SOLUCION1_idx` (`SOLUCION_SOL_ID` asc) ,
	index `fk_COMENTARIO_USUARIO1_idx` (`USUARIO_NICKNAME` asc) ,
	
	constraint `fk_COMENTARIO_SOLUCION1`
		foreign key (`SOLUCION_SOL_ID`)
		references `INSTARTI_SNIPPET`.`SOLUCION` (`SOL_ID`)
		on delete no action
		on update no action,

	constraint `fk_COMENTARIO_USUARIO1`
		foreign key (`USUARIO_NICKNAME` )
		references `INSTARTI_SNIPPET`.`USUARIO` (`NICKNAME` )
		on delete no action
		on update no action
)

engine = InnoDB;

-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`TECNOLOGIA`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`TECNOLOGIAS` 
(
	`TEC_ID` 		int 		not null 	auto_increment ,
	`NAME` 			varchar(25) not null ,
	`WEBPAGE` 		varchar(30) not null ,
	`REFERENCE` 	varchar(50) not null ,
  
	primary key (`TEC_ID`) ,
	unique index `NAME_UNIQUE` (`NAME` asc) 
)

engine = InnoDB;


-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`CODIGO`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`CODIGOS` 
(
	`COD_ID` 			int 		not null auto_increment ,
	`MODNAME` 			varchar(20) null ,
	`EXTENSION` 		varchar(5) 	null ,
	`SOURCE` 			text(5000) 	not null ,
	`SOLUCION_SOL_ID` 	int 		not null ,
  
	primary key (`COD_ID`) ,
	unique index `COD_ID_UNIQUE` (`COD_ID` asc) ,
	index `fk_CODIGO_SOLUCION1_idx` (`SOLUCION_SOL_ID` asc) ,
	
	constraint `fk_CODIGO_SOLUCION1`
		foreign key (`SOLUCION_SOL_ID`)
		references `INSTARTI_SNIPPET`.`SOLUCION` (`SOL_ID`)
		on delete no action
		on update no action
)

engine = InnoDB;

-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`CODIGOTECNOLOGIA`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`CODIGOTECNOLOGIAS` 
(
	`FROMLINE` 			int(3) 		null ,
	`TOLINE` 			int(3) 		null ,
	`TECNOLOGIA_TEC_ID` int 		not null ,
	`CODIGO_COD_ID` 	int 		not null ,
  
	primary key (`TECNOLOGIA_TEC_ID`, `CODIGO_COD_ID`) ,
	index `fk_CODIGOTECNOLOGIA_CODIGO1_idx` (`CODIGO_COD_ID` asc) ,
  
	constraint `fk_CODIGOTECNOLOGIA_TECNOLOGIA1`
		foreign key (`TECNOLOGIA_TEC_ID` )
		references `INSTARTI_SNIPPET`.`TECNOLOGIA` (`TEC_ID` )
		on delete no action
		on update no action,
  
	constraint `fk_CODIGOTECNOLOGIA_CODIGO1`
		foreign key (`CODIGO_COD_ID` )
		references `INSTARTI_SNIPPET`.`CODIGO` (`COD_ID` )
		on delete no action
		on update no action
)

engine = InnoDB;

-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`ASOCIACIONTECNOLOGIA`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`ASOCIACIONTECNOLOGIAS` 
(
	`TECNOLOGIA_TEC_ID` 		int 		not null,
	`TECNOLOGIA_TEC_ID1` 		int 	not null,
  
	primary key (`TECNOLOGIA_TEC_ID`, `TECNOLOGIA_TEC_ID1`) ,
	index `fk_ASOCIACION_TECNOLOGIA2_idx` (`TECNOLOGIA_TEC_ID1` asc) ,
  
	constraint `fk_ASOCIACION_TECNOLOGIA1`
		foreign key (`TECNOLOGIA_TEC_ID`)
		references `INSTARTI_SNIPPET`.`TECNOLOGIA` (`TEC_ID`)
		on delete no action
		on update no action,

	constraint `fk_ASOCIACION_TECNOLOGIA2`
		foreign key (`TECNOLOGIA_TEC_ID1`)
		references `INSTARTI_SNIPPET`.`TECNOLOGIA` (`TEC_ID`)
		on delete no action
		on update no action
)

engine = InnoDB;


-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`REFERENCIA`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`REFERENCIAS` 
(
	`FROMLINE` 			int(3) 		not null ,
	`TOLINE` 			int(3) 		not null ,
	`CODIGO_COD_ID` 	int 		not null ,
	`CODIGO_COD_ID1` 	int 		not null ,
  
	primary key (`CODIGO_COD_ID`, `CODIGO_COD_ID1`) ,
	index `fk_REFERENCIA_CODIGO2_idx` (`CODIGO_COD_ID1` asc),
  
	constraint `fk_REFERENCIA_CODIGO1`
		foreign key (`CODIGO_COD_ID` )
		references `INSTARTI_SNIPPET`.`CODIGO` (`COD_ID`)
		on delete no action
		on update no action,
	
	constraint `fk_REFERENCIA_CODIGO2`
		foreign key (`CODIGO_COD_ID1` )
		references `INSTARTI_SNIPPET`.`CODIGO` (`COD_ID` )
		on delete no action
		on update no action
)

engine = InnoDB;


-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`TAG`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`TAGS` 
(
	`TAG_ID` 	int 		not null 	auto_increment ,
	`LABEL` 	varchar(15) not null ,
  
	primary key (`TAG_ID`) ,
	unique index `TAG_ID_UNIQUE` (`TAG_ID` asc) 
)

engine = InnoDB;


-- -----------------------------------------------------
-- Table `INSTARTI_SNIPPET`.`CODIGOTAG`
-- -----------------------------------------------------
create  table if not exists `INSTARTI_SNIPPET`.`CODIGOTAGS` 
(
	`TAG_TAG_ID` 		int not null ,
	`CODIGO_COD_ID` 	int not null ,
  
	primary key (`TAG_TAG_ID`, `CODIGO_COD_ID`) ,
	index `fk_CODIGOTAG_CODIGO1_idx` (`CODIGO_COD_ID` asc) ,
  
	constraint `fk_CODIGOTAG_TAG1`
		foreign key (`TAG_TAG_ID`)
			references `INSTARTI_SNIPPET`.`TAG` (`TAG_ID`)
		on delete no action
		on update no action,
	
	constraint `fk_CODIGOTAG_CODIGO1`
		foreign key (`CODIGO_COD_ID`)
		references `INSTARTI_SNIPPET`.`CODIGO` (`COD_ID`)
		on delete no action
		on update no action
)

engine = InnoDB;


set SQL_MODE = @OLD_SQL_MODE;
set FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
set UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

alter table `INSTARTI_SNIPPET`.`PROBLEMAS` drop foreign key `FK_PROBLEMA_USUARIO`;

alter table `INSTARTI_SNIPPET`.`PROBLEMAS`
	add constraint `fk_PROBLEMA_USUARIO`
	foreign key(`USUARIO_NICKNAME`)
	references `INSTARTI_SNIPPET`.`USUARIO`(`NICKNAME`)
	on delete cascade
	on update cascade;