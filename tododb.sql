-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tododb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tododb` ;

-- -----------------------------------------------------
-- Schema tododb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tododb` DEFAULT CHARACTER SET utf8 ;
USE `tododb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `username` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `enabled` TINYINT(4) NULL DEFAULT NULL,
  `role` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`username`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `todo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `todo` ;

CREATE TABLE IF NOT EXISTS `todo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `task` VARCHAR(55) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `completed` TINYINT(4) NULL DEFAULT NULL,
  `user_id` INT(11) NOT NULL,
  `due_date` VARCHAR(50) NULL DEFAULT NULL,
  `complete_date` VARCHAR(50) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_todo_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_todo_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE = '';
DROP USER IF EXISTS todos@localhost;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'todos'@'localhost' IDENTIFIED BY 'todos';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'todos'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `tododb`;
INSERT INTO `user` (`id`, `email`, `username`, `password`, `enabled`, `role`) VALUES (1, 'shaun@winchester.co.uk', 'shaun', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 1, NULL);
INSERT INTO `user` (`id`, `email`, `username`, `password`, `enabled`, `role`) VALUES (2, 'liz@winchester.co.uk', 'liz', '$2a$10$q5lOwLLyWMHyQc5muboyiO.UAtfnq1i63GiEjRTwb/qqmA1VmAAZS', 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `todo`
-- -----------------------------------------------------
START TRANSACTION;
USE `tododb`;
INSERT INTO `todo` (`id`, `task`, `description`, `completed`, `user_id`, `due_date`, `complete_date`, `created_at`, `updated_at`) VALUES (1, 'Go round Mum\'s', NULL, 1, 1, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `todo` (`id`, `task`, `description`, `completed`, `user_id`, `due_date`, `complete_date`, `created_at`, `updated_at`) VALUES (2, 'Get Liz back', NULL, 0, 1, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `todo` (`id`, `task`, `description`, `completed`, `user_id`, `due_date`, `complete_date`, `created_at`, `updated_at`) VALUES (3, 'Sort life out', NULL, 0, 1, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `todo` (`id`, `task`, `description`, `completed`, `user_id`, `due_date`, `complete_date`, `created_at`, `updated_at`) VALUES (4, 'Break up with Shaun', NULL, 0, 2, NULL, NULL, DEFAULT, DEFAULT);

COMMIT;

