ALTER TABLE `order_status_history`
ADD `staff_id` int NULL AFTER `status`,
ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL;
ALTER TABLE `order_status_history`
ADD `old_value` int NULL AFTER `staff_id`,
ADD `new_value` tinytext COLLATE 'utf8mb4_general_ci' NULL AFTER `old_value`,
ADD `field` tinytext COLLATE 'utf8mb4_general_ci' NULL AFTER `new_value`;