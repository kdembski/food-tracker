-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 10, 2020 at 11:42 AM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
CREATE TABLE IF NOT EXISTS `calendar` (
  `date_id` int(63) NOT NULL AUTO_INCREMENT,
  `day` int(63) DEFAULT NULL,
  `month` int(63) DEFAULT NULL,
  `year` int(63) DEFAULT NULL,
  `dish_id` int(63) DEFAULT NULL,
  `meal_number` int(2) DEFAULT NULL,
  PRIMARY KEY (`date_id`),
  UNIQUE KEY `unique_date_index` (`day`,`month`,`year`,`meal_number`) USING BTREE,
  KEY `dish_id_calendar_fk` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10798 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `calendar`
--

INSERT INTO `calendar` (`date_id`, `day`, `month`, `year`, `dish_id`, `meal_number`) VALUES
(10508, 15, 11, 2020, 2, 0),
(10686, 16, 11, 2020, 5, 1),
(10687, 15, 11, 2020, 4, 1),
(10688, 15, 11, 2020, 2, 2),
(10689, 16, 11, 2020, 2, 2),
(10690, 14, 11, 2020, 4, 2),
(10691, 14, 11, 2020, 2, 1),
(10794, 8, 11, 2020, 5, 2),
(10795, 8, 11, 2020, 2, 1),
(10796, 9, 11, 2020, 4, 2),
(10797, 9, 11, 2020, 2, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `date_dish_view`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `date_dish_view`;
CREATE TABLE IF NOT EXISTS `date_dish_view` (
`day` int(63)
,`month` int(63)
,`year` int(63)
,`meal_number` int(2)
,`dish_id` int(63)
,`dish_name` varchar(255)
,`image` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
CREATE TABLE IF NOT EXISTS `dishes` (
  `dish_id` int(63) NOT NULL AUTO_INCREMENT,
  `dish_name` varchar(255) COLLATE cp1250_polish_ci NOT NULL,
  `preparation_time` int(63) DEFAULT NULL,
  `rating` int(2) DEFAULT NULL,
  `image` varchar(255) COLLATE cp1250_polish_ci DEFAULT NULL,
  `portions` int(63) DEFAULT NULL,
  PRIMARY KEY (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `dishes`
--

INSERT INTO `dishes` (`dish_id`, `dish_name`, `preparation_time`, `rating`, `image`, `portions`) VALUES
(2, 'Makaron z kurczakiem i warzywami1', 100, 2, 'http://localhost/food_tracker/Bez%C2%A0tytu%C5%82u.jpg', 2),
(4, 'Makaron z kurczakiem i szpinakiem2', 123, 5, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg', 4),
(5, 'Zupa krem z pomidorów', 323, 1, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg', 4),
(7, 'Zupa krem z marchewek', 40, 5, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/chrupiace-kurczaki.jpg', 2),
(9, 'Racuchy', 345, 2, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/chrupiace-kurczaki.jpg', 2),
(10, 'Makaron z kurczakiem i warzywa', 12, 1, '', 4),
(11, 'Makaron z kurczakiem i warzywami', 354, 3, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg', 2),
(12, 'Makaron z kurczakiem i warzywami', 354, 3, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg', 2),
(13, 'Makaron z kurczakiem i warzywami', 354, 3, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg', 2),
(14, 'Makaron z kurczakiem i warzywami', 354, 5, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg', 22),
(125, 'wwwww wwwww wwwwww wwwwww wwwww wwwwwwwww', 1, 1, '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE IF NOT EXISTS `ingredients` (
  `ingredient_id` int(63) NOT NULL AUTO_INCREMENT,
  `ingredient_name` varchar(63) COLLATE cp1250_polish_ci NOT NULL,
  `unit_id` int(63) NOT NULL,
  `kcal_per_unit` float(63,2) NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `unit_id_fk` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredient_id`, `ingredient_name`, `unit_id`, `kcal_per_unit`) VALUES
(1, 'pierś z kurczaka', 1, 1.00),
(2, 'czosnek', 3, 8.00),
(3, 'ser żółty', 1, 3.80),
(4, 'makaron', 1, 3.50),
(5, 'szpinak', 1, 1.00),
(6, 'jogurt naturalny - kremowy', 1, 0.60);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ingredients_view`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `ingredients_view`;
CREATE TABLE IF NOT EXISTS `ingredients_view` (
`ingredient_id` int(63)
,`ingredient_name` varchar(63)
,`kcal_per_unit` float(63,2)
,`unit_name` varchar(255)
,`unit_id` int(63)
);

-- --------------------------------------------------------

--
-- Table structure for table `recipes_ingredients`
--

DROP TABLE IF EXISTS `recipes_ingredients`;
CREATE TABLE IF NOT EXISTS `recipes_ingredients` (
  `dish_id` int(63) NOT NULL,
  `ingredient_id` int(63) NOT NULL,
  `amount` int(63) DEFAULT NULL,
  `recipe_element_id` int(63) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`recipe_element_id`),
  KEY `ingredients_id_fk` (`ingredient_id`),
  KEY `dish_id_ingredients_fk` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `recipes_ingredients`
--

INSERT INTO `recipes_ingredients` (`dish_id`, `ingredient_id`, `amount`, `recipe_element_id`) VALUES
(4, 3, 1, 1),
(4, 1, 1, 20),
(4, 3, 1, 33),
(2, 4, 1, 77),
(2, 5, 1, 95),
(2, 6, 1, 96);

-- --------------------------------------------------------

--
-- Stand-in structure for view `recipes_ingredients_view`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `recipes_ingredients_view`;
CREATE TABLE IF NOT EXISTS `recipes_ingredients_view` (
`recipe_element_id` int(63)
,`dish_id` int(63)
,`amount` int(63)
,`ingredient_name` varchar(63)
,`ingredient_id` int(63)
,`kcal_per_unit` float(63,2)
,`unit_name` varchar(255)
,`shortcut` varchar(63)
);

-- --------------------------------------------------------

--
-- Table structure for table `recipes_steps`
--

DROP TABLE IF EXISTS `recipes_steps`;
CREATE TABLE IF NOT EXISTS `recipes_steps` (
  `step_id` int(63) NOT NULL AUTO_INCREMENT,
  `step_number` int(63) NOT NULL,
  `instructions` varchar(255) COLLATE cp1250_polish_ci DEFAULT NULL,
  `dish_id` int(63) NOT NULL,
  PRIMARY KEY (`step_id`),
  KEY `dish_id_steps_fk` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `recipes_steps`
--

INSERT INTO `recipes_steps` (`step_id`, `step_number`, `instructions`, `dish_id`) VALUES
(2, 2, 'Na patelnię wlej odrobinę oliwy z oliwek, wrzuć mięso. Kawałki kurczaka grilluj przez kilka minut, aż nabiorą ładnego koloru. Ściągnij kurczaka z patelni.', 4),
(3, 1, 'Na patelnię wlej łyżkę oliwy z oliwek, dodaj posiekany czosnek i szpinak. Całość smaż przez 2 minuty, stale mieszając.', 4),
(51, 1, '123', 2),
(52, 2, '123', 2),
(53, 3, '123', 2),
(66, 3, '123123123', 4),
(70, 4, '123', 2),
(82, 4, '123', 4);

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
CREATE TABLE IF NOT EXISTS `unit` (
  `unit_id` int(63) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) COLLATE cp1250_polish_ci NOT NULL,
  `shortcut` varchar(63) COLLATE cp1250_polish_ci NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`unit_id`, `unit_name`, `shortcut`) VALUES
(1, 'gram', 'g'),
(2, 'mililitr', 'ml'),
(3, 'sztuka', 'szt');

-- --------------------------------------------------------

--
-- Structure for view `date_dish_view`
--
DROP TABLE IF EXISTS `date_dish_view`;

DROP VIEW IF EXISTS `date_dish_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `date_dish_view`  AS  select `calendar`.`day` AS `day`,`calendar`.`month` AS `month`,`calendar`.`year` AS `year`,`calendar`.`meal_number` AS `meal_number`,`dishes`.`dish_id` AS `dish_id`,`dishes`.`dish_name` AS `dish_name`,`dishes`.`image` AS `image` from (`calendar` left join `dishes` on((`dishes`.`dish_id` = `calendar`.`dish_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `ingredients_view`
--
DROP TABLE IF EXISTS `ingredients_view`;

DROP VIEW IF EXISTS `ingredients_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ingredients_view`  AS  select `ingredients`.`ingredient_id` AS `ingredient_id`,`ingredients`.`ingredient_name` AS `ingredient_name`,`ingredients`.`kcal_per_unit` AS `kcal_per_unit`,`unit`.`unit_name` AS `unit_name`,`unit`.`unit_id` AS `unit_id` from (`ingredients` left join `unit` on((`ingredients`.`unit_id` = `unit`.`unit_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `recipes_ingredients_view`
--
DROP TABLE IF EXISTS `recipes_ingredients_view`;

DROP VIEW IF EXISTS `recipes_ingredients_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `recipes_ingredients_view`  AS  select `recipes_ingredients`.`recipe_element_id` AS `recipe_element_id`,`recipes_ingredients`.`dish_id` AS `dish_id`,`recipes_ingredients`.`amount` AS `amount`,`ingredients`.`ingredient_name` AS `ingredient_name`,`ingredients`.`ingredient_id` AS `ingredient_id`,`ingredients`.`kcal_per_unit` AS `kcal_per_unit`,`unit`.`unit_name` AS `unit_name`,`unit`.`shortcut` AS `shortcut` from ((`recipes_ingredients` left join `ingredients` on((`recipes_ingredients`.`ingredient_id` = `ingredients`.`ingredient_id`))) left join `unit` on((`ingredients`.`unit_id` = `unit`.`unit_id`))) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `calendar`
--
ALTER TABLE `calendar`
  ADD CONSTRAINT `dish_id_calendar_fk` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE;

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `unit_id_fk` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`) ON DELETE CASCADE;

--
-- Constraints for table `recipes_ingredients`
--
ALTER TABLE `recipes_ingredients`
  ADD CONSTRAINT `dish_id_ingredients_fk` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ingredients_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`) ON DELETE CASCADE;

--
-- Constraints for table `recipes_steps`
--
ALTER TABLE `recipes_steps`
  ADD CONSTRAINT `dish_id_steps_fk` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
