-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 07, 2025 at 01:16 PM
-- Server version: 8.0.30
-- PHP Version: 8.2.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `authsleepy`
--

-- --------------------------------------------------------

--
-- Table structure for table `daily`
--

CREATE TABLE `daily` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `upper_pressure` int DEFAULT NULL,
  `lower_pressure` int DEFAULT NULL,
  `daily_steps` int DEFAULT NULL,
  `heart_rate` int DEFAULT NULL,
  `duration` float NOT NULL,
  `prediction_result` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `feedback` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `monthly_predictions`
--

CREATE TABLE `monthly_predictions` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `prediction_result` enum('Insomnia','Normal','Sleep Apnea') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sleep_records`
--

CREATE TABLE `sleep_records` (
  `id` int NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sleep_time` datetime NOT NULL,
  `wake_time` datetime NOT NULL,
  `duration` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `sleep_records`
--
DELIMITER $$
CREATE TRIGGER `update_or_insert_daily_from_sleep_records` AFTER INSERT ON `sleep_records` FOR EACH ROW BEGIN
    DECLARE sleepDate DATE;
    SET sleepDate = DATE(NEW.sleep_time);  -- Menggunakan tanggal dari wake_time

    -- Periksa apakah baris sudah ada di tabel 'daily'
    IF EXISTS (SELECT 1 FROM daily WHERE email = NEW.email AND date = sleepDate) THEN
        -- Jika baris ada, lakukan update
        UPDATE daily
        SET 
            duration = NEW.duration  -- Ganti dengan durasi terbaru
        WHERE email = NEW.email AND date = sleepDate;
    ELSE
        -- Jika tidak ada, masukkan baris baru
        INSERT INTO daily (email, date, upper_pressure, lower_pressure, daily_steps, heart_rate, duration)
        VALUES (NEW.email, sleepDate, NULL, NULL, NULL, NULL, NEW.duration);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hashed_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `work` enum('Accountant','Doctor','Engineer','Lawyer','Manager','Nurse','Sales Representative','Salesperson','Scientist','Software Engineer','Teacher') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `age` int DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `height` float DEFAULT NULL,
  `upper_pressure` int DEFAULT NULL,
  `lower_pressure` int DEFAULT NULL,
  `daily_steps` int DEFAULT NULL,
  `heart_rate` int DEFAULT NULL,
  `reset_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `hashed_password`, `created_at`, `name`, `gender`, `work`, `date_of_birth`, `age`, `weight`, `height`, `upper_pressure`, `lower_pressure`, `daily_steps`, `heart_rate`, `reset_token`) VALUES
(218, 'admin@example.com', '$2b$12$BDUYK/ZPEI0HpfvzJtJT1.AxO3N1k0UlkjEZC0gDVCjGlNJsSgTYG', '2025-01-05 10:54:24', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL),
(219, 'zamheb@gmail.com', '$2b$12$DFSw9nJxrY.uEevmAmE9RezPyXsCbjSRQ.iVezQQAMVhowvNFQaF.', '2025-01-05 12:00:41', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL),
(220, 'zam@gmail.com', '$2b$12$.jyef8ue3jvsBmQxQscw1uTosGGyDZ5dQ.qbgWso1rQScDtowvNwC', '2025-01-05 13:02:15', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL),
(221, 'mohammadtajutzamzami07@gmail.com', '$2b$12$pbLBmdMni/XykJ.ln3pjYeKaGn9V98YZEKDpVwhu8Q.OhmUxtLCE.', '2025-01-06 13:48:09', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL),
(222, 'a@gmail.com', '$2b$12$lBZEmOrpJUEmwOa6I3g7veefbyeYMh2ZMGdSrGMJV3k07VtUM8UKO', '2025-01-06 13:59:02', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL),
(223, 'oke@gmail.com', '$2b$12$xoCVr43eMG.agRKilbuFC.WSMveSQvShlfBjpwsEHhSd69ErGc8O.', '2025-01-06 14:09:26', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `update_or_insert_daily_from_users` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    DECLARE currentDate DATE;
    SET currentDate = CURDATE();

    -- Update the daily table with user data
    UPDATE daily
    SET 
        upper_pressure = IFNULL(NEW.upper_pressure, upper_pressure),
        lower_pressure = IFNULL(NEW.lower_pressure, lower_pressure),
        daily_steps = IFNULL(NEW.daily_steps, daily_steps),
        heart_rate = IFNULL(NEW.heart_rate, heart_rate)
    WHERE email = NEW.email AND date = currentDate;

    -- If no row was updated, insert a new row with the relevant data
    IF ROW_COUNT() = 0 THEN
        INSERT INTO daily (email, date, upper_pressure, lower_pressure, daily_steps, heart_rate, duration)
        VALUES (NEW.email, currentDate, NEW.upper_pressure, NEW.lower_pressure, NEW.daily_steps, NEW.heart_rate, 0);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `weekly_predictions`
--

CREATE TABLE `weekly_predictions` (
  `id` int NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prediction_result` enum('Insomnia','Normal','Sleep Apnea') NOT NULL,
  `prediction_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `work_data`
--

CREATE TABLE `work_data` (
  `id` int NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quality_of_sleep` float DEFAULT NULL,
  `physical_activity_level` float DEFAULT NULL,
  `stress_level` float DEFAULT NULL,
  `work_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daily`
--
ALTER TABLE `daily`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `monthly_predictions`
--
ALTER TABLE `monthly_predictions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sleep_records`
--
ALTER TABLE `sleep_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `weekly_predictions`
--
ALTER TABLE `weekly_predictions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `work_data`
--
ALTER TABLE `work_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `daily`
--
ALTER TABLE `daily`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=785;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `monthly_predictions`
--
ALTER TABLE `monthly_predictions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sleep_records`
--
ALTER TABLE `sleep_records`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

--
-- AUTO_INCREMENT for table `weekly_predictions`
--
ALTER TABLE `weekly_predictions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `work_data`
--
ALTER TABLE `work_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `daily`
--
ALTER TABLE `daily`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `sleep_records`
--
ALTER TABLE `sleep_records`
  ADD CONSTRAINT `sleep_records_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `weekly_predictions`
--
ALTER TABLE `weekly_predictions`
  ADD CONSTRAINT `weekly_predictions_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE;

--
-- Constraints for table `work_data`
--
ALTER TABLE `work_data`
  ADD CONSTRAINT `work_data_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
