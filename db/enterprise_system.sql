-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 26, 2025 at 11:17 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `enterprise_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `hacker_logs`
--

CREATE TABLE `hacker_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `attempted_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hacker_logs`
--

INSERT INTO `hacker_logs` (`id`, `username`, `ip_address`, `attempted_at`) VALUES
(1, 'admin\' --', '192.168.43.174', '2025-02-26 17:54:43'),
(2, 'admin\' --', '192.168.43.174', '2025-02-26 17:55:44'),
(3, 'admin\' --', '192.168.43.174', '2025-02-26 17:58:15'),
(4, 'admin\' --', '192.168.43.174', '2025-02-26 18:04:13'),
(5, 'admin\' --', '192.168.43.174', '2025-02-26 18:06:08'),
(6, 'admin\' OR \'1\'=\'1 --', '192.168.43.174', '2025-02-26 18:14:55');

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`id`, `user_id`, `login_time`) VALUES
(1, 3, '2025-02-03 14:48:53'),
(2, 3, '2025-02-03 14:50:17'),
(3, 2, '2025-02-08 22:45:50'),
(4, 2, '2025-02-08 22:48:30'),
(5, 4, '2025-02-08 22:52:03'),
(6, 4, '2025-02-08 22:54:18'),
(7, 2, '2025-02-09 14:44:14'),
(8, 2, '2025-02-09 14:45:16'),
(9, 2, '2025-02-09 14:45:49'),
(10, 2, '2025-02-09 14:47:06'),
(11, 2, '2025-02-09 14:47:30'),
(12, 2, '2025-02-09 14:48:54'),
(13, 2, '2025-02-09 14:49:08'),
(14, 2, '2025-02-09 14:50:02'),
(15, 2, '2025-02-09 14:56:52'),
(16, 2, '2025-02-09 14:57:01'),
(17, 2, '2025-02-09 14:57:08'),
(18, 2, '2025-02-09 14:58:16'),
(19, 2, '2025-02-09 15:03:40'),
(20, 2, '2025-02-09 15:05:42'),
(21, 2, '2025-02-09 15:10:00'),
(22, 2, '2025-02-09 15:12:54'),
(23, 6, '2025-02-09 15:55:11'),
(24, 5, '2025-02-09 15:56:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('admin','user') NOT NULL DEFAULT 'user',
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `user_type`, `last_login`, `created_at`) VALUES
(2, 'admin', '$2y$10$PG/BQ1gBZt/zEzFib/gpze3GRITLic65XbRXX9EHza/hEXWyX/jnm', 'admin', '2025-02-08 22:48:30', '2025-02-03 06:46:34'),
(3, 'user', '$2y$10$lgQsiEhqkCKGCJX.CSHfjOwAVNZSR6Rpps/j/IOvd9mdPRZpyw59G', 'user', '2025-02-03 14:50:17', '2025-02-03 06:48:45'),
(4, 'me', '$2y$10$T0G25xgOXQyqCbv4aNd58OPmglXROChQTJeYXMlWtWIsD5LOTobc6', 'user', '2025-02-08 22:54:18', '2025-02-08 14:51:56'),
(5, 'my', '$2y$10$pFaAieQNSHuqVgWRBhodI.l1HiUo4AUxxnY5RfZ.Q5VTMps67esI2', 'user', '2025-02-09 15:56:16', '2025-02-09 07:21:31'),
(6, 'ad', '$2y$10$PH5RSsBDVlqXF6v9v.6oc.msegoXFVOmQQPuvcHZPO.WlFQs1wdAG', 'admin', '2025-02-09 15:55:11', '2025-02-09 07:22:22'),
(7, 'loy', '$2y$10$Yw.TbzzxJnzBw55K2OApreIJ8EXZxW2m0OZikqS9xunt3XjqUj58W', 'admin', NULL, '2025-02-26 06:35:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hacker_logs`
--
ALTER TABLE `hacker_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hacker_logs`
--
ALTER TABLE `hacker_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
