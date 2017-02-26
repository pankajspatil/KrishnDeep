CREATE TABLE `krishnadeep`.`weekly_counts` (
  `weekly_counts_id` INT NOT NULL AUTO_INCREMENT,
  `patient_count` INT NOT NULL DEFAULT 0,
  `patient_amount` DOUBLE NOT NULL DEFAULT 0,
  `patient_count_claim` INT NOT NULL DEFAULT 0,
  `patient_amount_claim` DOUBLE NOT NULL DEFAULT 0,
  `patient_count_non_claim` INT NOT NULL DEFAULT 0,
  `patient_amount_non_claim` DOUBLE NOT NULL DEFAULT 0,
  `is_active` CHAR(1) NOT NULL DEFAULT '1',
  `created_by` INT NOT NULL,
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`weekly_counts_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

ALTER TABLE `krishnadeep`.`weekly_counts` 
ADD COLUMN `week_year_no` INT NOT NULL AFTER `patient_amount_non_claim`;

ALTER TABLE `krishnadeep`.`weekly_counts` 
ADD COLUMN `week_start_date` VARCHAR(15) NOT NULL DEFAULT '' AFTER `week_year_no`;

