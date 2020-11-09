-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 09, 2020 at 06:56 AM
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
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
CREATE TABLE IF NOT EXISTS `dishes` (
  `dish_id` int(63) NOT NULL AUTO_INCREMENT,
  `dish_name` varchar(255) COLLATE cp1250_polish_ci NOT NULL,
  `preparation_time` int(63) DEFAULT NULL,
  `rating` int(2) DEFAULT NULL,
  `image` varchar(255) COLLATE cp1250_polish_ci DEFAULT NULL,
  PRIMARY KEY (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `dishes`
--

INSERT INTO `dishes` (`dish_id`, `dish_name`, `preparation_time`, `rating`, `image`) VALUES
(2, 'Makaron z kurczakiem i warzywami', 100, 5, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg'),
(4, 'Makaron z kurczakiem i szpinakiem', 30, 4, 'https://www.przyslijprzepis.pl/media/cache/default_view/uploads/media/recipe/0006/40/f21b0c6846ee2fe2af5147d71df1687ab25d5c79.jpeg'),
(5, 'Zupa krem z pomidorów', 123, 1, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg'),
(7, 'Zupa krem z marchewek', 456, 5, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/chrupiace-kurczaki.jpg'),
(8, 'Ramen', 234, 3, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/chrupiace-kurczaki.jpg'),
(9, 'Racuchy z jabłkami', 345, 2, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/chrupiace-kurczaki.jpg'),
(10, 'Makaron z kurczakiem i warzywami', 312, 2, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zupa-krem-z-marchewki-z-migdalami.jpg'),
(11, 'Makaron z kurczakiem i warzywami', 354, 3, '');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredient_id`, `ingredient_name`, `unit_id`, `kcal_per_unit`) VALUES
(1, 'pierś z kurczaka', 1, 1.00),
(2, 'czosnek', 3, 8.00),
(3, 'ser żółty', 1, 3.80),
(4, 'makaron', 1, 3.50),
(5, 'szpinak', 1, 0.24),
(6, 'jogurt naturalny - kremowy', 1, 0.60);

-- --------------------------------------------------------

--
-- Table structure for table `recipes_ingredients`
--

DROP TABLE IF EXISTS `recipes_ingredients`;
CREATE TABLE IF NOT EXISTS `recipes_ingredients` (
  `dish_id` int(63) NOT NULL,
  `ingredient_id` int(63) NOT NULL,
  `amount` int(63) DEFAULT NULL,
  KEY `dish_id_fk2` (`dish_id`),
  KEY `ingredients_id_fk` (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `recipes_ingredients`
--

INSERT INTO `recipes_ingredients` (`dish_id`, `ingredient_id`, `amount`) VALUES
(4, 1, 600),
(4, 4, 500),
(4, 3, 40),
(4, 5, 500),
(4, 6, 400),
(4, 2, 3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `recipes_ingredients_view`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `recipes_ingredients_view`;
CREATE TABLE IF NOT EXISTS `recipes_ingredients_view` (
`dish_id` int(63)
,`amount` int(63)
,`ingredient_name` varchar(63)
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
  KEY `dish_id_fk` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `recipes_steps`
--

INSERT INTO `recipes_steps` (`step_id`, `step_number`, `instructions`, `dish_id`) VALUES
(1, 1, 'Piersi kurczaka umyj, osusz, pokrój w cienkie paseczki, obsyp solą i pieprzem.', 4),
(2, 2, 'Na patelnię wlej odrobinę oliwy z oliwek, wrzuć mięso. Kawałki kurczaka grilluj przez kilka minut, aż nabiorą ładnego koloru. Ściągnij kurczaka z patelni.', 4),
(3, 3, 'Na patelnię wlej łyżkę oliwy z oliwek, dodaj posiekany czosnek i szpinak. Całość smaż przez 2 minuty, stale mieszając.', 4),
(4, 4, 'Do szpinaku dodaj jogurt i mięso z kurczaka. Sos gotuj przez kilka minut. Dopraw do smaku.', 4),
(5, 5, 'Makaron ugotuj al dente i wymieszaj z sosem. Podawaj posypane startym serem żółtym.', 4);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`unit_id`, `unit_name`, `shortcut`) VALUES
(1, 'gram', 'g'),
(2, 'mililitr', 'ml'),
(3, 'sztuka', 'szt');

-- --------------------------------------------------------

--
-- Structure for view `recipes_ingredients_view`
--
DROP TABLE IF EXISTS `recipes_ingredients_view`;

DROP VIEW IF EXISTS `recipes_ingredients_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `recipes_ingredients_view`  AS  select `recipes_ingredients`.`dish_id` AS `dish_id`,`recipes_ingredients`.`amount` AS `amount`,`ingredients`.`ingredient_name` AS `ingredient_name`,`ingredients`.`kcal_per_unit` AS `kcal_per_unit`,`unit`.`unit_name` AS `unit_name`,`unit`.`shortcut` AS `shortcut` from ((`recipes_ingredients` left join `ingredients` on((`recipes_ingredients`.`ingredient_id` = `ingredients`.`ingredient_id`))) left join `unit` on((`ingredients`.`unit_id` = `unit`.`unit_id`))) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `unit_id_fk` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`);

--
-- Constraints for table `recipes_ingredients`
--
ALTER TABLE `recipes_ingredients`
  ADD CONSTRAINT `dish_id_fk2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`),
  ADD CONSTRAINT `ingredients_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`);

--
-- Constraints for table `recipes_steps`
--
ALTER TABLE `recipes_steps`
  ADD CONSTRAINT `dish_id_fk` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
