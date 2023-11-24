USE `isucon`;
CREATE INDEX `idx_user_id_present_all_id` ON `user_present_all_received_history` (`user_id`, `present_all_id`);
