ALTER TABLE `order_status_history`
ADD `staff_id` int NULL AFTER `status`,
ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL;