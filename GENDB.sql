-- MySQL Script generated by MySQL Workbench
-- Thu Jul 21 02:56:34 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema appdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema appdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `appdb` DEFAULT CHARACTER SET utf8 ;
USE `appdb` ;

-- -----------------------------------------------------
-- Table `appdb`.`accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appdb`.`accounts` ;

CREATE TABLE IF NOT EXISTS `appdb`.`accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `contact_number` VARCHAR(20) NOT NULL,
  `role` ENUM('Regular', 'Admin') NOT NULL DEFAULT 'Regular',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appdb`.`book_entries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appdb`.`book_entries` ;

CREATE TABLE IF NOT EXISTS `appdb`.`book_entries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(500) NOT NULL,
  `authors` VARCHAR(500) NOT NULL,
  `cover` BLOB NULL,
  `isbn` VARCHAR(13) NOT NULL,
  `page_count` INT NOT NULL,
  `publisher` VARCHAR(100) NOT NULL,
  `published_date` DATE NOT NULL,
  `genre` ENUM('Fiction', 'Non-Fiction') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appdb`.`book_copies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appdb`.`book_copies` ;

CREATE TABLE IF NOT EXISTS `appdb`.`book_copies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `book_entry_id` INT NOT NULL,
  `serial_id` VARCHAR(20) NOT NULL,
  `status` ENUM('Checked Out', 'Pending Check Out', 'Available') NOT NULL DEFAULT 'Available',
  `purchase_price` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `book_entry_id_idx` (`book_entry_id` ASC) VISIBLE,
  UNIQUE INDEX `serial_id_UNIQUE` (`serial_id` ASC) VISIBLE,
  CONSTRAINT `book_entry_id_bc`
    FOREIGN KEY (`book_entry_id`)
    REFERENCES `appdb`.`book_entries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appdb`.`online_checkout_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appdb`.`online_checkout_requests` ;

CREATE TABLE IF NOT EXISTS `appdb`.`online_checkout_requests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `requester_id` INT NOT NULL,
  `requested_book_id` INT NOT NULL,
  `status` ENUM('Pending', 'Approved', 'Rejected', 'Canceled') NOT NULL DEFAULT 'Pending',
  `request_date` DATE NOT NULL,
  `status_update_date` DATE NULL,
  `requested_copy_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `requester_id_idx` (`requester_id` ASC) VISIBLE,
  INDEX `requested_book_id_idx` (`requested_book_id` ASC) INVISIBLE,
  INDEX `requested_copy_id_idx` (`requested_copy_id` ASC) VISIBLE,
  CONSTRAINT `requester_id_ocr`
    FOREIGN KEY (`requester_id`)
    REFERENCES `appdb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `requested_book_id_ocr`
    FOREIGN KEY (`requested_book_id`)
    REFERENCES `appdb`.`book_entries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `requested_copy_id_ocr`
    FOREIGN KEY (`requested_copy_id`)
    REFERENCES `appdb`.`book_copies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appdb`.`checkout_records`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `appdb`.`checkout_records` ;

CREATE TABLE IF NOT EXISTS `appdb`.`checkout_records` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `book_entry_id` INT NOT NULL,
  `book_copy_id` INT NOT NULL,
  `borrower_id` INT NOT NULL,
  `online_checkout_request_id` INT NOT NULL,
  `checkout_date` DATE NOT NULL,
  `expected_return_date` DATE NOT NULL,
  `actual_return_date` DATE NULL,
  `status` ENUM('Checked Out', 'Checked In') NOT NULL DEFAULT 'Checked Out',
  PRIMARY KEY (`id`),
  INDEX `book_entry_id_idx` (`book_entry_id` ASC) VISIBLE,
  INDEX `book_copy_id_idx` (`book_copy_id` ASC) VISIBLE,
  INDEX `borrower_id_idx` (`borrower_id` ASC) VISIBLE,
  INDEX `online_checkout_request_id_idx` (`online_checkout_request_id` ASC) VISIBLE,
  CONSTRAINT `book_entry_id_cr`
    FOREIGN KEY (`book_entry_id`)
    REFERENCES `appdb`.`book_entries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `book_copy_id_cr`
    FOREIGN KEY (`book_copy_id`)
    REFERENCES `appdb`.`book_copies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `borrower_id_cr`
    FOREIGN KEY (`borrower_id`)
    REFERENCES `appdb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `online_checkout_request_id_cr`
    FOREIGN KEY (`online_checkout_request_id`)
    REFERENCES `appdb`.`online_checkout_requests` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;