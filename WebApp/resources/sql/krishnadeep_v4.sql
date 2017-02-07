ALTER TABLE `krishnadeep`.`item_category` 
ADD COLUMN `item_category_description` VARCHAR(2000) NULL AFTER `item_category_name`;

ALTER TABLE `krishnadeep`.`expense_item_master` 
ADD COLUMN `expense_item_description` VARCHAR(2000) NULL AFTER `expense_item_name`;