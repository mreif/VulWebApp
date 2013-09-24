# 
# 1. create mysql server
# 2. import that script
# 3. be happy

#drop schema `hack`;


CREATE DATABASE  IF NOT EXISTS `hack` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `hack`;

###
##  create user table
### 

CREATE  TABLE IF NOT EXISTS `hack`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = MyISAM DEFAULT CHARSET=latin1;

###
##  insert some datasets to user table
###

INSERT INTO `user` (`username`, `password`) VALUES
('leo', '098f6bcd4621d373cade4e832627b4f6'),
('thisuserisverysecret', '5ebe2294ecd0e0f08eab7690d2a6ee69'),
('admin', '482c811da5d5b4bc6d497ffa98491e38'),
('bigbob', 'bdc65274e31c69574d9fb761f15534f3'),
('micha', 'b6dc2f75da9ff3de76ad30b1f3bf3ea5');

###
##  create guestbookentry table
### 

CREATE  TABLE IF NOT EXISTS `hack`.`guestbookentry` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `entry` TEXT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = MyISAM DEFAULT CHARSET=latin1;

###
##  insert some guestbookentry
###

INSERT INTO `guestbookentry` (`name`, `entry`) VALUES
('gast', 'Hallo! Schoene Ideen habt ihr hier. Ich hab schon zwei davon ausprobiert und es war ein voller Erfolg!'),
('catwoman', 'Ich bin begeistert! Bitte weiter so!!!!! :)');

###
## create gift table
###

CREATE  TABLE IF NOT EXISTS `hack`.`gift` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NOT NULL ,
  `picture_path` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = MyISAM DEFAULT CHARSET=latin1;

###
##  create some gifts
###

INSERT INTO `gift` (`name`,`description`,`picture_path`) VALUES
('', '', './pictures/1_pic.jpg');

###
##
###

CREATE  TABLE IF NOT EXISTS `hack`.`giftentry` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `rating` INT(10) UNSIGNED NOT NULL ,
  `commentary` TEXT NOT NULL ,
  `gift_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `fk_gift_entry` (`gift_id` ASC)
) ENGINE = MyISAM DEFAULT CHARSET=latin1;