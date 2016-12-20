ALTER TABLE `krishnadeep`.`user_master` 
ADD COLUMN `user_salutation` VARCHAR(10) NULL AFTER `created_on`,
ADD COLUMN `user_address_id` INT NULL AFTER `user_salutation`;


-- Address table creation

CREATE TABLE `krishnadeep`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address_street` VARCHAR(45) NULL,
  `address_city` VARCHAR(30) NULL,
  `address_state` VARCHAR(30) NULL,
  `address_zip` VARCHAR(10) NULL,
  `address_country` VARCHAR(20) NULL,
  `address_fax` VARCHAR(20) NULL,
  `address_type` INT NULL,
  PRIMARY KEY (`address_id`));

  
  CREATE TABLE `krishnadeep`.`address_type` (
  `address_type_id` INT NOT NULL,
  `address_type_name` VARCHAR(45) NULL,
  PRIMARY KEY (`address_type_id`));

  
  INSERT INTO `krishnadeep`.`role_master` (`role_id`, `role_description`, `created_by`, `created_date`, `is_active`) VALUES ('3', 'Vendor', '1', '2016-12-20 22:40:11', '1');
