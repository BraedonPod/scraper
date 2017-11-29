-- MySQL Script generated by MySQL Workbench
-- Mon Oct  9 13:09:34 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema orion
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `orion` ;

-- -----------------------------------------------------
-- Schema orion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `orion` DEFAULT CHARACTER SET utf8 ;
USE `orion` ;

-- -----------------------------------------------------
-- Table `orion`.`movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`movies` ;

CREATE TABLE IF NOT EXISTS `orion`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `movie_length` VARCHAR(45) NULL,
  `release_date` YEAR NULL,
  `release_info` DATE,
  `img_url` VARCHAR(255) NULL,
  `metascore` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`directors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`directors` ;

CREATE TABLE IF NOT EXISTS `orion`.`directors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`movies_directors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`movies_directors` ;

CREATE TABLE IF NOT EXISTS `orion`.`movies_directors` (
  `movies_id` INT NOT NULL,
  `directors_id` INT NOT NULL,
  PRIMARY KEY (`movies_id`, `directors_id`),
  INDEX `fk_movies_directors_directors1_idx` (`directors_id` ASC),
  CONSTRAINT `fk_movies_directors_movies`
    FOREIGN KEY (`movies_id`)
    REFERENCES `orion`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movies_directors_directors1`
    FOREIGN KEY (`directors_id`)
    REFERENCES `orion`.`directors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`stars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`stars` ;

CREATE TABLE IF NOT EXISTS `orion`.`stars` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`movies_stars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`movies_stars` ;

CREATE TABLE IF NOT EXISTS `orion`.`movies_stars` (
  `movies_id` INT NOT NULL,
  `stars_id` INT NOT NULL,
  PRIMARY KEY (`movies_id`, `stars_id`),
  INDEX `fk_movies_stars_stars1_idx` (`stars_id` ASC),
  CONSTRAINT `fk_movies_stars_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `orion`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movies_stars_stars1`
    FOREIGN KEY (`stars_id`)
    REFERENCES `orion`.`stars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`genres` ;

CREATE TABLE IF NOT EXISTS `orion`.`genres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`movies_genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`movies_genres` ;

CREATE TABLE IF NOT EXISTS `orion`.`movies_genres` (
  `movies_id` INT NOT NULL,
  `genres_id` INT NOT NULL,
  PRIMARY KEY (`movies_id`, `genres_id`),
  INDEX `fk_movies_genres_genres1_idx` (`genres_id` ASC),
  CONSTRAINT `fk_movies_genre_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `orion`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movies_genres_genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `orion`.`genres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`users` ;

CREATE TABLE IF NOT EXISTS `orion`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `about` LONGTEXT NOT NULL,
  `birthday` DATE NULL,
  `location` VARCHAR(45) NULL,
  `current_sign_in_at` DATETIME NULL,
  `email` VARCHAR(255) NULL,
  `gender` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `created_at` DATE NOT NULL,
  `updated_at` DATE NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `last_sign_in_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orion`.`library_entries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orion`.`library_entries` ;

CREATE TABLE IF NOT EXISTS `orion`.`library_entries` (
  `users_id` INT NOT NULL,
  `movies_id` INT NOT NULL,
  `status` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `notes` MEDIUMTEXT NULL,
  `media_type` VARCHAR(45) NOT NULL,
  `rating` INT NULL,
  `started_at` DATETIME NULL,
  `finished_at` DATETIME NULL,
  PRIMARY KEY (`users_id`, `movies_id`),
  INDEX `fk_library_entries_movies1_idx` (`movies_id` ASC),
  UNIQUE INDEX `users_id_UNIQUE` (`users_id` ASC),
  UNIQUE INDEX `movies_id_UNIQUE` (`movies_id` ASC),
  UNIQUE INDEX `media_type_UNIQUE` (`media_type` ASC),
  CONSTRAINT `fk_library_entries_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `orion`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_entries_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `orion`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;