INSERT INTO `krishnadeep`.`user_menu_master` (`menu_description`, `created_by`) VALUES ('Patient', '1');
INSERT INTO `krishnadeep`.`user_menu_master` (`menu_description`, `created_by`) VALUES ('Appointment', '1');

UPDATE `krishnadeep`.`user_menu_master` SET `created_date`='2016-10-29 20:36:11', `is_active`='1' WHERE `menu_id`='7';
UPDATE `krishnadeep`.`user_menu_master` SET `created_date`='2016-10-29 20:36:11', `is_active`='1' WHERE `menu_id`='8';

ALTER TABLE `krishnadeep`.`user_menu_master` 
CHANGE COLUMN `created_by` `created_by` VARCHAR(20) NOT NULL ,
CHANGE COLUMN `created_date` `created_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
CHANGE COLUMN `is_active` `is_active` CHAR(1) NOT NULL ;

INSERT INTO `krishnadeep`.`role_menu_map` (`role_id`, `menu_id`, `created_by`) VALUES ('1', '7', '1');
INSERT INTO `krishnadeep`.`role_menu_map` (`role_id`, `menu_id`, `created_by`) VALUES ('1', '8', '1');