ALTER TABLE `krishnadeep`.`weekly_counts` 
ADD COLUMN `patient_cheque_amount_claim` DOUBLE NULL DEFAULT 0.0 AFTER `patient_amount_claim`,
ADD COLUMN `patient_cheque_amount_non_claim` DOUBLE NULL DEFAULT 0.0 AFTER `patient_amount_non_claim`;
