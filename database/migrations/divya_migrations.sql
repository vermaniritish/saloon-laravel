ALTER TABLE `orders`
ADD `manual_address` tinyint(1) NULL DEFAULT '0' AFTER `prefix_id`;

CREATE TABLE `order_status_history` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `status` varchar(100) COLLATE 'utf8mb4_general_ci' NOT NULL,
  `status_by` int NULL,
  FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`status_by`) REFERENCES `admin_permissions` (`id`) ON DELETE SET NULL
);

ALTER TABLE `order_status_history`
CHANGE `status_by` `created_by` int NULL AFTER `status`,
ADD `created` datetime NULL,
ADD `modified` datetime NULL DEFAULT CURRENT_TIMESTAMP AFTER `created`;