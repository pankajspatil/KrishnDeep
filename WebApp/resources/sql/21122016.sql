INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('1', 'Advance Tax', 'other_current_asset', 'Other Current Asset', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('2', 'Employee Advance', 'other_current_asset', 'Other Current Asset', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('3', 'Prepaid Expenses', 'other_current_asset', 'Other Current Asset', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('4', 'Furniture and Equipment', 'fixed_asset', 'Fixed Asset', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('5', 'Employee Reimbursements', 'other_current_liability', 'Other Current Liability', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('6', 'Tax Payable', 'other_current_liability', 'Other Current Liability', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('7', 'Advertising And Marketing', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('8', 'Automobile Expense', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('9', 'Bad Debt', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('10', 'Bank Fees and Charges', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('11', 'Consultant Expense', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('12', 'Credit Card Charges', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('13', 'Depreciation Expense', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('14', 'IT and Internet Expenses', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('15', 'Janitorial Expense', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('16', 'Lodging', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('17', 'Meals and Entertainment', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('18', 'Office Supplies', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('19', 'Other Expenses', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('20', 'Postage', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('21', 'Printing and Stationery', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('22', 'Rent Expense', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('23', 'Repairs and Maintenance', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('24', 'Salaries and Employee Wages', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('25', 'Telephone Expense', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('26', 'Travel Expense', 'expense', 'Expense', '0');
INSERT INTO `krishnadeep`.`expense_accounts` (`account_id`, `account_name`, `account_type`, `account_type_formatted`, `disable_tax`) VALUES ('27', 'Cost of Goods Sold', 'cost_of_goods_sold', 'Cost Of Goods Sold', '0');


UPDATE `krishnadeep`.`user_menu_master` SET `menu_description`='Search' WHERE `menu_id`='3';
UPDATE `krishnadeep`.`user_menu_master` SET `menu_description`='Expense' WHERE `menu_id`='4';


CREATE TABLE `expenses` (
  `expenses_id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_desc` varchar(45) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `expense_qty` int(11) DEFAULT NULL,
  `expense_amount` double DEFAULT NULL,
  `expense_invoice_no` varchar(45) DEFAULT NULL,
  `expense_vat` float DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `expenses_item_id` int(11) DEFAULT NULL,
  `expenses_created_date` datetime DEFAULT NULL,
  `expenses_created_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`expenses_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

