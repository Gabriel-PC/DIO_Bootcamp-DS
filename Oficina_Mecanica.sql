-- MySQL Script generated by MySQL Workbench
-- Fri Mar 31 13:25:22 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Oficina
-- -----------------------------------------------------
-- Oficina Mecânica

-- -----------------------------------------------------
-- Schema Oficina
--
-- Oficina Mecânica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Oficina` ;
USE `Oficina` ;

-- -----------------------------------------------------
-- Table `Oficina`.`Cliente_PJ_PF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Cliente_PJ_PF` (
  `idCliente_PJ_PF` INT NOT NULL AUTO_INCREMENT,
  `CNPJ_CPF` VARCHAR(14) NOT NULL,
  `Endereço` VARCHAR(45) NULL DEFAULT 'Florianópolis_SC',
  `No_Fidelidade` VARCHAR(14) NULL,
  `Tel_Contato` CHAR(12) NOT NULL,
  PRIMARY KEY (`idCliente_PJ_PF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Veículo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Veículo` (
  `idVeículo` INT NOT NULL AUTO_INCREMENT,
  `Placa` CHAR(7) NOT NULL,
  `Marca` VARCHAR(12) NOT NULL,
  `Ano` YEAR(4) NOT NULL,
  `Modelo` VARCHAR(40) NOT NULL,
  `Cliente_PJ_PF_idCliente_PJ_PF` INT NOT NULL,
  PRIMARY KEY (`idVeículo`, `Cliente_PJ_PF_idCliente_PJ_PF`),
  INDEX `fk_Veículo_Cliente_PJ_PF_idx` (`Cliente_PJ_PF_idCliente_PJ_PF` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_Cliente_PJ_PF`
    FOREIGN KEY (`Cliente_PJ_PF_idCliente_PJ_PF`)
    REFERENCES `Oficina`.`Cliente_PJ_PF` (`idCliente_PJ_PF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Equipe_Designada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Equipe_Designada` (
  `idEquipe_Designada` INT NOT NULL AUTO_INCREMENT,
  `Escala` VARCHAR(45) NOT NULL,
  `Cronograma` VARCHAR(45) NULL,
  `Hora_por_Carro` TIME NOT NULL,
  PRIMARY KEY (`idEquipe_Designada`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Ordem_de_Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Ordem_de_Serviço` (
  `idOrdem_de_Serviço` INT NOT NULL AUTO_INCREMENT,
  `Data_de_Emissão` TIMESTAMP NOT NULL DEFAULT 'CURRENT_TIMESTAMP' COMMENT 'dia/mes/ano - minuto:hora',
  `Status` ENUM('ATENDIMENTO', 'ORÇAMENTO', 'MANUTENÇÃO', 'FINALIZADO') NOT NULL DEFAULT 'ATENDIMENTO' COMMENT '\'ATENDIMENTO\', \'ORÇAMENTO\', \'MANUTENÇÃO\', \'FINALIZADO\'',
  `Previsão_entrega` TIMESTAMP NOT NULL DEFAULT 'Final_do_expediente' COMMENT 'dia/mes/ano - minuto:hora',
  `Equipe_Designada_idEquipe_Designada` INT NOT NULL,
  PRIMARY KEY (`idOrdem_de_Serviço`, `Equipe_Designada_idEquipe_Designada`),
  INDEX `fk_Ordem_de_Serviço_Equipe_Designada1_idx` (`Equipe_Designada_idEquipe_Designada` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_de_Serviço_Equipe_Designada1`
    FOREIGN KEY (`Equipe_Designada_idEquipe_Designada`)
    REFERENCES `Oficina`.`Equipe_Designada` (`idEquipe_Designada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Revisão_progamada_ou_esporádica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Revisão_progamada_ou_esporádica` (
  `Veículo_idVeículo` INT NOT NULL,
  `Veículo_Cliente_PJ_PF_idCliente_PJ_PF` INT NOT NULL,
  `Ordem_de_Serviço_idOrdem_de_Serviço` INT NOT NULL,
  `Kilometragem` VARCHAR(6) NOT NULL,
  `Descrição_por_km` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Veículo_idVeículo`, `Veículo_Cliente_PJ_PF_idCliente_PJ_PF`, `Ordem_de_Serviço_idOrdem_de_Serviço`),
  INDEX `fk_Veículo_has_Ordem_de_Serviço_Ordem_de_Serviço1_idx` (`Ordem_de_Serviço_idOrdem_de_Serviço` ASC) VISIBLE,
  INDEX `fk_Veículo_has_Ordem_de_Serviço_Veículo1_idx` (`Veículo_idVeículo` ASC, `Veículo_Cliente_PJ_PF_idCliente_PJ_PF` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_has_Ordem_de_Serviço_Veículo1`
    FOREIGN KEY (`Veículo_idVeículo` , `Veículo_Cliente_PJ_PF_idCliente_PJ_PF`)
    REFERENCES `Oficina`.`Veículo` (`idVeículo` , `Cliente_PJ_PF_idCliente_PJ_PF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veículo_has_Ordem_de_Serviço_Ordem_de_Serviço1`
    FOREIGN KEY (`Ordem_de_Serviço_idOrdem_de_Serviço`)
    REFERENCES `Oficina`.`Ordem_de_Serviço` (`idOrdem_de_Serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Conserto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Conserto` (
  `Veículo_idVeículo` INT NOT NULL,
  `Veículo_Cliente_PJ_PF_idCliente_PJ_PF` INT NOT NULL,
  `Ordem_de_Serviço_idOrdem_de_Serviço` INT NOT NULL,
  `Kilometragem` VARCHAR(6) NOT NULL,
  `Descrição_do_Cliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Veículo_idVeículo`, `Veículo_Cliente_PJ_PF_idCliente_PJ_PF`, `Ordem_de_Serviço_idOrdem_de_Serviço`),
  INDEX `fk_Veículo_has_Ordem_de_Serviço1_Ordem_de_Serviço1_idx` (`Ordem_de_Serviço_idOrdem_de_Serviço` ASC) VISIBLE,
  INDEX `fk_Veículo_has_Ordem_de_Serviço1_Veículo1_idx` (`Veículo_idVeículo` ASC, `Veículo_Cliente_PJ_PF_idCliente_PJ_PF` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_has_Ordem_de_Serviço1_Veículo1`
    FOREIGN KEY (`Veículo_idVeículo` , `Veículo_Cliente_PJ_PF_idCliente_PJ_PF`)
    REFERENCES `Oficina`.`Veículo` (`idVeículo` , `Cliente_PJ_PF_idCliente_PJ_PF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veículo_has_Ordem_de_Serviço1_Ordem_de_Serviço1`
    FOREIGN KEY (`Ordem_de_Serviço_idOrdem_de_Serviço`)
    REFERENCES `Oficina`.`Ordem_de_Serviço` (`idOrdem_de_Serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Autorização_de_Orçamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Autorização_de_Orçamento` (
  `Cliente_PJ_PF_idCliente_PJ_PF` INT NOT NULL,
  `Ordem_de_Serviço_idOrdem_de_Serviço` INT NOT NULL,
  `Equipe_Designada_idEquipe_Designada` INT NOT NULL,
  `Orçamento` VARCHAR(6) NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Descrição_do_Serviço` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cliente_PJ_PF_idCliente_PJ_PF`, `Ordem_de_Serviço_idOrdem_de_Serviço`, `Equipe_Designada_idEquipe_Designada`),
  INDEX `fk_Cliente_PJ_PF_has_Ordem_de_Serviço_Ordem_de_Serviço1_idx` (`Ordem_de_Serviço_idOrdem_de_Serviço` ASC) VISIBLE,
  INDEX `fk_Cliente_PJ_PF_has_Ordem_de_Serviço_Cliente_PJ_PF1_idx` (`Cliente_PJ_PF_idCliente_PJ_PF` ASC) VISIBLE,
  INDEX `fk_Autorização_de_Orçamento_Equipe_Designada1_idx` (`Equipe_Designada_idEquipe_Designada` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_PJ_PF_has_Ordem_de_Serviço_Cliente_PJ_PF1`
    FOREIGN KEY (`Cliente_PJ_PF_idCliente_PJ_PF`)
    REFERENCES `Oficina`.`Cliente_PJ_PF` (`idCliente_PJ_PF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_PJ_PF_has_Ordem_de_Serviço_Ordem_de_Serviço1`
    FOREIGN KEY (`Ordem_de_Serviço_idOrdem_de_Serviço`)
    REFERENCES `Oficina`.`Ordem_de_Serviço` (`idOrdem_de_Serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autorização_de_Orçamento_Equipe_Designada1`
    FOREIGN KEY (`Equipe_Designada_idEquipe_Designada`)
    REFERENCES `Oficina`.`Equipe_Designada` (`idEquipe_Designada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Autopeças_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Autopeças_Estoque` (
  `idPeças_de_Reposição` INT NOT NULL AUTO_INCREMENT,
  `Nome_Modelo` VARCHAR(45) NOT NULL,
  `Valor` VARCHAR(45) NOT NULL,
  `Tamanho_Peso` VARCHAR(45) NULL,
  PRIMARY KEY (`idPeças_de_Reposição`),
  UNIQUE INDEX `Nome_Modelo_UNIQUE` (`Nome_Modelo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Mecânico_Eletricista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Mecânico_Eletricista` (
  `idMecânico_Eletricista` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Especialidade_Função` VARCHAR(45) NOT NULL,
  `Código_de_Funcionário` VARCHAR(6) NOT NULL,
  `Mecânico_Eletricistacol` VARCHAR(45) NULL,
  PRIMARY KEY (`idMecânico_Eletricista`),
  UNIQUE INDEX `Nome_UNIQUE` (`Nome` ASC) VISIBLE,
  UNIQUE INDEX `Código_de_Funcionário_UNIQUE` (`Código_de_Funcionário` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Mão_de_Obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Mão_de_Obra` (
  `Equipe_Designada_idEquipe_Designada` INT NOT NULL,
  `Mecânico_Eletricista_idMecânico_Eletricista` INT NOT NULL,
  `Custo_por_Hora` VARCHAR(45) NOT NULL COMMENT 'Relacionado ao Carro-Serviço',
  `Hora_trabalhada` TIME NULL COMMENT 'Relacionado ao Carro-Serviço',
  PRIMARY KEY (`Equipe_Designada_idEquipe_Designada`, `Mecânico_Eletricista_idMecânico_Eletricista`),
  INDEX `fk_Equipe_Designada_has_Mecânico_Eletricista_Mecânico_Ele_idx` (`Mecânico_Eletricista_idMecânico_Eletricista` ASC) VISIBLE,
  INDEX `fk_Equipe_Designada_has_Mecânico_Eletricista_Equipe_Design_idx` (`Equipe_Designada_idEquipe_Designada` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_Designada_has_Mecânico_Eletricista_Equipe_Designada1`
    FOREIGN KEY (`Equipe_Designada_idEquipe_Designada`)
    REFERENCES `Oficina`.`Equipe_Designada` (`idEquipe_Designada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Designada_has_Mecânico_Eletricista_Mecânico_Eletr1`
    FOREIGN KEY (`Mecânico_Eletricista_idMecânico_Eletricista`)
    REFERENCES `Oficina`.`Mecânico_Eletricista` (`idMecânico_Eletricista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Garantia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Garantia` (
  `Veículo_idVeículo` INT NOT NULL,
  `Veículo_Cliente_PJ_PF_idCliente_PJ_PF` INT NOT NULL,
  `Autopeças_Estoque_idPeças_de_Reposição` INT NOT NULL,
  `Data_compra` TIMESTAMP NOT NULL,
  `Prazo_data_expirada` TIMESTAMP NULL,
  PRIMARY KEY (`Veículo_idVeículo`, `Veículo_Cliente_PJ_PF_idCliente_PJ_PF`, `Autopeças_Estoque_idPeças_de_Reposição`),
  INDEX `fk_Veículo_has_Autopeças_Estoque_Autopeças_Estoque1_idx` (`Autopeças_Estoque_idPeças_de_Reposição` ASC) VISIBLE,
  INDEX `fk_Veículo_has_Autopeças_Estoque_Veículo1_idx` (`Veículo_idVeículo` ASC, `Veículo_Cliente_PJ_PF_idCliente_PJ_PF` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_has_Autopeças_Estoque_Veículo1`
    FOREIGN KEY (`Veículo_idVeículo` , `Veículo_Cliente_PJ_PF_idCliente_PJ_PF`)
    REFERENCES `Oficina`.`Veículo` (`idVeículo` , `Cliente_PJ_PF_idCliente_PJ_PF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veículo_has_Autopeças_Estoque_Autopeças_Estoque1`
    FOREIGN KEY (`Autopeças_Estoque_idPeças_de_Reposição`)
    REFERENCES `Oficina`.`Autopeças_Estoque` (`idPeças_de_Reposição`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Motoboy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Motoboy` (
  `Autopeças_Estoque_idPeças_de_Reposição` INT NOT NULL,
  `Equipe_Designada_idEquipe_Designada` INT NOT NULL,
  `Status` ENUM('Espera', 'Transporte', 'Pagamento') NOT NULL DEFAULT 'Espera' COMMENT 'Só existe transporte após \'existir\' a peça, o tempo de encomenda de compra não será computado.',
  `Frete` VARCHAR(5) NULL,
  PRIMARY KEY (`Autopeças_Estoque_idPeças_de_Reposição`, `Equipe_Designada_idEquipe_Designada`),
  INDEX `fk_Autopeças_Estoque_has_Equipe_Designada_Equipe_Designada_idx` (`Equipe_Designada_idEquipe_Designada` ASC) VISIBLE,
  INDEX `fk_Autopeças_Estoque_has_Equipe_Designada_Autopeças_Estoq_idx` (`Autopeças_Estoque_idPeças_de_Reposição` ASC) VISIBLE,
  CONSTRAINT `fk_Autopeças_Estoque_has_Equipe_Designada_Autopeças_Estoque1`
    FOREIGN KEY (`Autopeças_Estoque_idPeças_de_Reposição`)
    REFERENCES `Oficina`.`Autopeças_Estoque` (`idPeças_de_Reposição`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autopeças_Estoque_has_Equipe_Designada_Equipe_Designada1`
    FOREIGN KEY (`Equipe_Designada_idEquipe_Designada`)
    REFERENCES `Oficina`.`Equipe_Designada` (`idEquipe_Designada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
