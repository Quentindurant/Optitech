-- -----------------------------------------------------
-- Schema optitech
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optitech` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `optitech`;

-- -----------------------------------------------------
-- Table `Regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Regions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('admin', 'technician') NOT NULL,
  `phone` VARCHAR(20) NULL,
  `address` TEXT NULL,
  `is_active` BOOLEAN DEFAULT true,
  `region_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Users_Regions_idx` (`region_id` ASC),
  CONSTRAINT `fk_Users_Regions`
    FOREIGN KEY (`region_id`)
    REFERENCES `Regions` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Partners` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `phone` VARCHAR(20) NULL,
  `address` TEXT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `phone` VARCHAR(20) NULL,
  `address` TEXT NOT NULL,
  `region_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Clients_Regions_idx` (`region_id` ASC),
  CONSTRAINT `fk_Clients_Regions`
    FOREIGN KEY (`region_id`)
    REFERENCES `Regions` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Interventions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Interventions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `status` ENUM('pending', 'in_progress', 'completed', 'cancelled') NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NULL,
  `rating` INT NULL CHECK (rating BETWEEN 1 AND 5),
  `comment` TEXT NULL,
  `partner_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_Interventions_Partners_idx` (`partner_id` ASC),
  INDEX `fk_Interventions_Clients_idx` (`client_id` ASC),
  INDEX `fk_Interventions_Users_idx` (`user_id` ASC),
  CONSTRAINT `fk_Interventions_Partners`
    FOREIGN KEY (`partner_id`)
    REFERENCES `Partners` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Interventions_Clients`
    FOREIGN KEY (`client_id`)
    REFERENCES `Clients` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Interventions_Users`
    FOREIGN KEY (`user_id`)
    REFERENCES `Users` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `InterventionLogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InterventionLogs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NOT NULL,
  `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `location` VARCHAR(255) NULL,
  `intervention_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_InterventionLogs_Interventions_idx` (`intervention_id` ASC),
  CONSTRAINT `fk_InterventionLogs_Interventions`
    FOREIGN KEY (`intervention_id`)
    REFERENCES `Interventions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `TechnicianAvailability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TechnicianAvailability` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `reason` TEXT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_TechnicianAvailability_Users_idx` (`user_id` ASC),
  CONSTRAINT `fk_TechnicianAvailability_Users`
    FOREIGN KEY (`user_id`)
    REFERENCES `Users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Skills` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `USERS_SKILLS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `USERS_SKILLS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `skill_id` INT NOT NULL,
  `level` INT NOT NULL CHECK (level BETWEEN 1 AND 5),
  PRIMARY KEY (`id`),
  INDEX `fk_USERS_SKILLS_Users_idx` (`user_id` ASC),
  INDEX `fk_USERS_SKILLS_Skills_idx` (`skill_id` ASC),
  CONSTRAINT `fk_USERS_SKILLS_Users`
    FOREIGN KEY (`user_id`)
    REFERENCES `Users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USERS_SKILLS_Skills`
    FOREIGN KEY (`skill_id`)
    REFERENCES `Skills` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  UNIQUE (`user_id`, `skill_id`))
ENGINE = InnoDB;
