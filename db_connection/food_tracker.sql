-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Czas generowania: 19 Sty 2021, 19:08
-- Wersja serwera: 5.7.31
-- Wersja PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `food_tracker`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `calendar`
--

DROP TABLE IF EXISTS `calendar`;
CREATE TABLE IF NOT EXISTS `calendar` (
  `date_id` int(63) NOT NULL AUTO_INCREMENT,
  `day` int(63) DEFAULT NULL,
  `month` int(63) DEFAULT NULL,
  `year` int(63) DEFAULT NULL,
  `dish_id` int(63) DEFAULT NULL,
  `meal_number` int(2) DEFAULT NULL,
  `portions` int(63) NOT NULL DEFAULT '1',
  `preparation_time` int(63) DEFAULT NULL,
  `rating` int(2) DEFAULT NULL,
  PRIMARY KEY (`date_id`),
  UNIQUE KEY `unique_date_index` (`day`,`month`,`year`,`meal_number`) USING BTREE,
  KEY `dish_id_calendar_fk` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17622 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Zrzut danych tabeli `calendar`
--

INSERT INTO `calendar` (`date_id`, `day`, `month`, `year`, `dish_id`, `meal_number`, `portions`, `preparation_time`, `rating`) VALUES
(17486, 11, 0, 2021, 263, 2, 2, 15, 5),
(17491, 13, 0, 2021, 262, 1, 2, 30, 4),
(17496, 12, 0, 2021, 262, 1, 2, 30, 4),
(17533, 15, 0, 2021, 270, 1, 2, 60, 5),
(17579, 17, 0, 2021, 286, 1, 2, 150, 5),
(17602, 13, 0, 2021, 263, 2, 2, 15, 5),
(17608, 14, 0, 2021, 270, 1, 2, 60, 5),
(17615, 18, 0, 2021, 286, 1, 2, 150, 5);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `date_dish_view`
-- (Zobacz poniżej rzeczywisty widok)
--
DROP VIEW IF EXISTS `date_dish_view`;
CREATE TABLE IF NOT EXISTS `date_dish_view` (
`day` int(63)
,`month` int(63)
,`year` int(63)
,`meal_number` int(2)
,`portions` int(63)
,`preparation_time` int(63)
,`rating` int(2)
,`dish_id` int(63)
,`dish_name` varchar(255)
,`image` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dishes`
--

DROP TABLE IF EXISTS `dishes`;
CREATE TABLE IF NOT EXISTS `dishes` (
  `dish_id` int(63) NOT NULL AUTO_INCREMENT,
  `dish_name` varchar(255) COLLATE cp1250_polish_ci NOT NULL,
  `preparation_time` int(63) DEFAULT NULL,
  `rating` int(2) DEFAULT NULL,
  `image` varchar(255) COLLATE cp1250_polish_ci DEFAULT NULL,
  `category` int(2) DEFAULT '1',
  PRIMARY KEY (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Zrzut danych tabeli `dishes`
--

INSERT INTO `dishes` (`dish_id`, `dish_name`, `preparation_time`, `rating`, `image`, `category`) VALUES
(131, 'Puree ziemniaczane z jajkami w sosie musztardowym', 40, 4, 'https://kulinarnapolska.org/wp-content/uploads/2018/06/jajka-w-sosie-musztardowym-jak-zrobic-przepis-2.jpg', 2),
(132, 'Kanapki z serkiem Almette i pomidorem', 10, 4, 'https://1.bp.blogspot.com/-915Q6XW5U7c/VyjSeI51WuI/AAAAAAAAJrE/0OY8fFjigHYeEggQ8wHsE-jvEeebGdh_gCLcB/s1600/1.jpg', 13),
(138, 'Rosół', 120, 2, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/rosol_z_kury170242.jpg', 2),
(244, 'Zupa krem z papryki', 50, 5, 'https://cdn.aniagotuje.com/pictures/articles/2019/08/991282-v-720x775.jpg', 2),
(245, 'Makaron ze szpinakiem, suszonymi pomidorami i fetą', 60, 4, 'https://www.kwestiasmaku.com/sites/v123.kwestiasmaku.com/files/page95_4.jpg', 2),
(246, 'Zupa krem z pomidorów', 60, 5, 'https://poprostupycha.com.pl/wp-content/uploads/2019/08/krem-z-pomidorow_2.jpg', 2),
(247, 'Risotto z kurczakiem i warzywami', 90, 4, 'https://pliki.doradcasmaku.pl/risotto-z-warzywami-i-kurczakiem0-4.webp', 2),
(261, 'Spaghetti z szynką i rukolą', 40, 5, 'https://stoliczkunakryjsie.files.wordpress.com/2012/07/makaronzrukola1.jpg', 2),
(262, 'Makaron z sosem cztery sery i mozzarellą', 30, 4, 'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/makaron-z-sosem-4-sery.jpg', 2),
(263, 'Kanapki z pomidorem i serem fetą', 15, 5, 'http://sense-of-taste.com/wp-content/uploads/2014/03/Kanapka-z-fet%C4%85-pomidorkami-cherry-i-bazyli%C4%85-1-1024x682.jpg', 13),
(264, 'Tortille z kurczakiem', 60, 4, 'https://d3iamf8ydd24h9.cloudfront.net/pictures/articles/2019/09/1153198-v-1080x1080.jpg', 123),
(270, 'Udka z kurczaka, ryż i gotowana marchewka', 60, 5, 'https://static.gotujmy.pl/ZDJECIE_PRZEPISU_ETAP/pieczone-podudzia-z-kurczaka-z-ryzem-i-marchewka-529099.jpg', 2),
(271, 'Bagietka z pomidorem, jajkiem i sałatą', 15, 4, 'https://sifu.unileversolutions.com/image/pl-PL/recipe-topvisual/2/1260-709/kanapka-blt-z-chrupi%C4%85cym-boczkiem-50223585.jpg', 13),
(286, 'Zupa pomidorowa', 150, 5, 'https://polki.pl/foto/4_3_LARGE/zupa-pomidorowa-z-ryzem-przepis-skladniki-i-przygotowanie-2382336.jpg', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE IF NOT EXISTS `ingredients` (
  `ingredient_id` int(63) NOT NULL AUTO_INCREMENT,
  `ingredient_name` varchar(63) COLLATE cp1250_polish_ci NOT NULL,
  `unit_id` int(63) NOT NULL,
  `kcal_per_unit` float(63,2) NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `unit_id_fk` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Zrzut danych tabeli `ingredients`
--

INSERT INTO `ingredients` (`ingredient_id`, `ingredient_name`, `unit_id`, `kcal_per_unit`) VALUES
(1, 'pierś z kurczaka', 1, 1.00),
(2, 'ząbek czosnku', 3, 8.00),
(3, 'ser żółty', 1, 3.80),
(4, 'makaron', 1, 3.50),
(5, 'szpinak', 1, 0.24),
(6, 'jogurt naturalny - kremowy', 1, 0.60),
(10, 'masło', 1, 7.50),
(11, 'masło', 5, 75.00),
(12, 'mąka', 1, 3.42),
(13, 'mąka', 5, 51.00),
(14, 'musztarda', 5, 19.00),
(15, 'bulion warzywny', 3, 30.00),
(16, 'woda', 2, 0.00),
(17, 'ziemniaki', 1, 0.79),
(18, 'zioła prowansalskie', 6, 0.00),
(19, 'jajko', 3, 78.00),
(20, 'serek almette', 1, 2.38),
(21, 'chleb', 7, 86.00),
(23, 'marchewka', 3, 15.00),
(24, 'pietruszka', 3, 39.00),
(25, 'seler', 3, 98.00),
(26, 'cebula', 3, 35.00),
(27, 'pałki z kurczaka', 3, 145.00),
(28, 'por', 3, 41.00),
(29, 'liść laurowy', 3, 0.00),
(30, 'ziele angielskie', 3, 0.00),
(31, 'oregano', 6, 0.00),
(32, 'majeranek', 6, 0.00),
(33, 'pomidor', 3, 40.00),
(34, 'czerwona papryka', 3, 68.00),
(35, 'parypka słodka', 6, 0.00),
(36, 'sól', 6, 0.00),
(37, 'pieprz', 6, 0.00),
(38, 'ser feta', 1, 1.90),
(39, 'suszone pomidory', 1, 5.38),
(40, 'pomidor', 1, 0.46),
(41, 'ryż', 1, 3.45),
(42, 'passata pomidorowa', 1, 0.32),
(43, 'szynka zawędzana', 1, 1.02),
(44, 'makaron spaghetti', 1, 3.50),
(45, 'rukola', 1, 0.25),
(46, 'pomidory w puszce', 1, 0.35),
(47, 'mozzarella', 1, 2.29),
(48, 'spaghetti 4 sery z brokułami', 9, 204.00),
(49, 'jogurt naturalny - gęsty', 1, 0.58),
(50, 'placek tortilla', 9, 764.00),
(51, 'mix sałat z rukolą', 9, 37.80),
(52, 'udko z kurczaka', 3, 166.00),
(53, 'przyprawa do kurczaka - złocista', 6, 0.00),
(54, 'oliwa z oliwek', 6, 44.00),
(55, 'oliwa z oliwek', 5, 88.00),
(56, 'bułka tarta', 5, 28.00),
(57, 'bagietka', 3, 371.00),
(58, 'główka sałaty masłowej', 3, 29.00),
(59, 'liść sałaty masłowej', 3, 1.00),
(60, 'przecier pomidorowy', 9, 135.00);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `ingredients_view`
-- (Zobacz poniżej rzeczywisty widok)
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
-- Struktura tabeli dla tabeli `recipes_ingredients`
--

DROP TABLE IF EXISTS `recipes_ingredients`;
CREATE TABLE IF NOT EXISTS `recipes_ingredients` (
  `dish_id` int(63) NOT NULL,
  `ingredient_id` int(63) NOT NULL,
  `amount` float(63,2) DEFAULT NULL,
  `recipe_element_id` int(63) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`recipe_element_id`),
  KEY `ingredients_id_fk` (`ingredient_id`),
  KEY `dish_id_ingredients_fk` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Zrzut danych tabeli `recipes_ingredients`
--

INSERT INTO `recipes_ingredients` (`dish_id`, `ingredient_id`, `amount`, `recipe_element_id`) VALUES
(131, 14, 1.00, 101),
(131, 11, 0.50, 102),
(131, 13, 0.50, 103),
(131, 6, 100.00, 104),
(131, 15, 0.50, 105),
(131, 16, 150.00, 106),
(131, 17, 150.00, 107),
(131, 18, 1.00, 108),
(131, 19, 2.00, 109),
(132, 20, 75.00, 110),
(132, 21, 3.00, 112),
(138, 27, 1.00, 114),
(138, 31, 1.00, 115),
(138, 23, 1.00, 116),
(138, 32, 1.00, 117),
(138, 30, 1.00, 118),
(138, 29, 1.00, 119),
(138, 2, 1.00, 120),
(138, 26, 0.50, 121),
(138, 25, 0.25, 122),
(138, 24, 0.50, 123),
(138, 4, 75.00, 124),
(132, 33, 0.50, 167),
(244, 34, 1.50, 176),
(244, 26, 0.50, 177),
(244, 35, 0.50, 178),
(244, 36, 0.25, 179),
(244, 37, 0.25, 180),
(244, 33, 1.00, 181),
(244, 2, 2.00, 182),
(244, 11, 0.50, 183),
(244, 15, 0.50, 184),
(244, 38, 67.50, 185),
(245, 5, 100.00, 186),
(245, 6, 100.00, 187),
(245, 38, 67.50, 188),
(245, 11, 0.50, 189),
(245, 37, 0.25, 190),
(245, 4, 125.00, 191),
(245, 2, 1.00, 192),
(245, 39, 67.50, 193),
(246, 15, 0.50, 194),
(246, 21, 3.00, 195),
(246, 2, 3.00, 196),
(246, 11, 0.50, 197),
(246, 36, 0.25, 198),
(246, 26, 0.50, 199),
(246, 37, 0.25, 200),
(244, 21, 3.00, 201),
(246, 38, 67.50, 202),
(246, 40, 500.00, 203),
(247, 15, 0.50, 204),
(247, 11, 0.50, 205),
(247, 34, 0.50, 206),
(247, 26, 1.00, 207),
(247, 1, 125.00, 208),
(247, 36, 0.25, 209),
(247, 41, 75.00, 210),
(247, 23, 1.50, 211),
(131, 3, 1.00, 223),
(131, 4, 1.00, 224),
(261, 4, 125.00, 239),
(261, 43, 40.00, 240),
(261, 45, 15.00, 241),
(261, 46, 100.00, 242),
(261, 42, 175.00, 243),
(262, 44, 125.00, 244),
(262, 49, 100.00, 245),
(262, 48, 0.50, 246),
(262, 47, 37.50, 247),
(263, 21, 3.00, 248),
(263, 33, 0.50, 249),
(263, 38, 67.50, 250),
(264, 1, 200.00, 251),
(264, 33, 0.50, 252),
(264, 38, 67.50, 253),
(264, 47, 62.50, 254),
(264, 6, 100.00, 255),
(264, 2, 1.00, 256),
(264, 50, 0.50, 257),
(264, 51, 0.25, 258),
(270, 52, 2.00, 259),
(270, 41, 75.00, 260),
(270, 11, 1.00, 261),
(270, 23, 2.00, 262),
(270, 2, 2.00, 263),
(270, 53, 3.00, 264),
(270, 55, 1.00, 265),
(270, 56, 1.00, 266),
(271, 33, 0.50, 267),
(271, 57, 1.00, 268),
(271, 19, 1.00, 269),
(271, 59, 3.00, 270),
(286, 27, 1.00, 271),
(286, 2, 1.00, 272),
(286, 26, 0.50, 273),
(286, 25, 0.25, 274),
(286, 31, 1.00, 275),
(286, 24, 0.50, 276),
(286, 41, 75.00, 277),
(286, 23, 1.00, 278),
(286, 30, 1.00, 279),
(286, 32, 1.00, 280),
(286, 29, 1.00, 281),
(138, 28, 0.25, 282),
(286, 28, 0.25, 283),
(286, 60, 0.50, 284);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `recipes_ingredients_view`
-- (Zobacz poniżej rzeczywisty widok)
--
DROP VIEW IF EXISTS `recipes_ingredients_view`;
CREATE TABLE IF NOT EXISTS `recipes_ingredients_view` (
`recipe_element_id` int(63)
,`dish_id` int(63)
,`amount` float(63,2)
,`ingredient_name` varchar(63)
,`ingredient_id` int(63)
,`kcal_per_unit` float(63,2)
,`unit_name` varchar(255)
,`shortcut` varchar(63)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `recipes_steps`
--

DROP TABLE IF EXISTS `recipes_steps`;
CREATE TABLE IF NOT EXISTS `recipes_steps` (
  `step_id` int(63) NOT NULL AUTO_INCREMENT,
  `step_number` int(63) NOT NULL,
  `instructions` varchar(255) COLLATE cp1250_polish_ci DEFAULT NULL,
  `dish_id` int(63) NOT NULL,
  PRIMARY KEY (`step_id`),
  KEY `dish_id_steps_fk` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Zrzut danych tabeli `recipes_steps`
--

INSERT INTO `recipes_steps` (`step_id`, `step_number`, `instructions`, `dish_id`) VALUES
(85, 2, 'Dodaj do masła mąkę i smaż tylko do połączenia się składników, na tzw. białą zasmażkę.', 131),
(86, 3, 'Stopniowo wlewaj do rondla ciepły bulion i mieszaj zasmażkę, najlepiej rób to trzepaczką, aby nie było grudek.', 131),
(87, 4, 'Gotuj, wciąż mieszając, do zgęstnienia sosu.', 131),
(88, 1, 'Rozpuść masło w rondelku, ziemniaki ugotuj w posolonej wodzie, jajka ugotuj na twardo.', 131),
(89, 5, 'Ściągnij garnek z ognia, dodaj pieprz musztardę i wymieszaj.', 131),
(90, 8, 'Do ugotowanych ziemniaków dodaj pozostały jogurt naturalny, zioła prowansalskie i ugnieć je na puree.', 131),
(91, 7, 'Ponownie postaw garnek na małym ogniu i gotuj przez kilka minut, ale nie wolno doprowadzić do zagotowania! ', 131),
(92, 6, 'Następnie dodaj połowę jogurtu naturalnego. Zamieszaj.', 131),
(93, 9, 'Podawaj puree z jajkami przekrojonymi na połówki, wszystko polane zrobionym sosem.', 131),
(94, 1, 'Pomidora pokrój w plastry.', 132),
(95, 3, 'Połóż pomidora.', 132),
(96, 2, 'Posmaruj chleb serkiem.', 132),
(97, 4, 'Dodaj majeranek, oregano, liść laurowy i ziele angielskie.', 138),
(98, 1, 'Warzywa obierz i do gara.', 138),
(99, 5, 'Zalej wodą po sam korek i gotuj przez 2h.', 138),
(100, 2, 'Mięso umyj i do gara.', 138),
(101, 3, 'Cebule opal nad palnikiem i do gara.', 138),
(102, 6, 'W miedzy czasie ugotuj makaron.', 138),
(103, 8, 'Jedz.', 138),
(104, 7, 'Po 2h wyciągnij wszystko z rosołu, pokrój, wrzuć do misek i zalej zupką.', 138),
(196, 1, 'Pokrojoną cebulkę z przeciśniętym przez praskę czosnkiem podsmażam w garnku na roztopionym maśle lub na oliwie.', 244),
(197, 2, 'Pomidory sparz we wrzątku, pokrój na mniejsze kawałki i wrzuć do garnka.', 244),
(198, 4, 'Całość zamieszaj i duś pod przykryciem, przez 20 minut na małej mocy palnika.', 244),
(199, 3, 'Z papryki wytnij gniazda nasienne, pokrój na mniejsze kawałki i do gara.', 244),
(200, 5, 'Dodaj przyprawy i wlej bulion.', 244),
(201, 6, 'Krem z papryki gotuj na małej mocy palnika ostatnie 15 minut, bez przykrywki.', 244),
(202, 7, 'Zupę zmiksuj przy użyciu blendera i podawaj z pokrojonym w kostkę serem fetą.', 244),
(203, 1, 'Ser feta pokroić w małą kostkę, suszone pomidory pokroić w paski i odstawić na bok.', 245),
(204, 2, 'Makaron ugotować al dente według przepisu na opakowaniu.', 245),
(205, 4, 'Dodać szpinak i smażyć. Dodać jogurt i ser feta i suszone pomidory. Mieszać, aż ser się rozpuści. Doprawić pieprzem do smaku.', 245),
(206, 3, 'Na dużej patelni rozgrzać masło. Dodać posiekany (lub przeciśnięty przez prasę) czosnek. Podsmażyć chwilkę.', 245),
(207, 5, 'Powstały sos wymieszać w garnku z makaronem.', 245),
(208, 1, 'W garnku, w którym będziesz gotować zupę roztop łyżkę masła.', 246),
(209, 2, 'Do garnka dodaję poszatkowaną cebulę i podsmażam dziesięć minut na bardzo małej mocy palnika. ', 246),
(210, 4, 'Pomidory lekko ponacinaj, sparz wrzątkiem, obierz ze skóry i pokrój na mniejsze kawałki', 246),
(211, 5, 'Dodaj pomidory do garnka, zalej bulionem, dodaj przyprawy i gotuj przez około 20 minut.', 246),
(212, 6, 'Zupę zmiksuj przy użyciu blendera. ', 246),
(213, 7, 'Podawaj z pokrojonym w kostkę serem fetą i grzankami.', 246),
(214, 3, 'Dodaj przeciśnięte przez praskę ząbki czosnku. (Przez cały proces podsmażania cebuli a potem cebuli z czosnkiem, nie przykrywam garnka przykrywką.)', 246),
(215, 1, 'Cebulę pokrój w kostkę, marchewkę w plasterki, paprykę i pierś z kurczaka w kostkę.', 247),
(216, 3, 'Marchewkę i ryż podgotuj w osobnych garnkach.', 247),
(217, 4, 'Na patelnie dodaj paprykę i smaż dalej.', 247),
(218, 5, 'Wszystkie składniki wrzuć do garnka, wymieszaj, dodaj przyprawy i zalej bulionem.', 247),
(219, 6, 'Trzymaj na małym gazie bez pokrywki aż bulion się zredukuje.', 247),
(220, 7, 'Gotowe!', 247),
(221, 2, 'Masło roztop na patelni, usmaż cebule z piersią z kurczaka', 247),
(226, 1, 'Ugotuj makaron.', 261),
(227, 3, 'Dolej passatę i gotuj pod przykryciem przez 20 min.', 261),
(228, 4, 'Makaron, rukolę i sos wymieszaj razem w garnku.', 261),
(229, 2, 'Na patelni podsmaż szynkę, dodaj pomidory i pod przykryciem razem podsmaż.', 261),
(230, 2, 'Makaron ugotuj al dente i odcedź. Na patelnie dodaj pokrojoną mozzarellę i zostaw na małym ogniu aż do roztopienia mozzarelli.', 262),
(231, 1, 'Zawartość opakowania Knorr wymieszaj ze 250 ml zimnej wody oraz jogurtem naturalnym. Płyn wlej na patelnię i zagotuj. Zmniejsz ogień i gotuj sos 8 minut, mieszając co jakiś czas.', 262),
(232, 3, 'Wymieszaj makaron i sos w garnku, podawaj puki ciepłe.', 262),
(233, 1, 'nie no nie bede pisał jak chleb zrobić', 263),
(234, 2, 'Pomidora i fetę pokrój w kostkę, mozzarellę w plasterki.', 264),
(235, 3, 'Z jogurtu naturalnego i czosnku przygotuj sos czosnkowy.', 264),
(236, 4, 'Na placek tortilli układaj kolejno: mix sałat, kurczaka, pomidora, fetę, mozzarellę, sos.', 264),
(237, 1, 'Kurczaka pokrój w kostkę i podsmaż, mix sałat z rukolą opłukaj.', 264),
(238, 5, 'Zawiń placek i włóż na chwilę do grilla elektrycznego.', 264),
(239, 1, 'Ryż i marchewkę ugotuj w osobnych garnkach.', 270),
(240, 2, 'Udka z kurczaka umyj i osusz, czosnek przeciśnij przez praskę i wymieszaj go z przyprawą do kurczaka i oliwą w misce.', 270),
(241, 3, 'Kurczaka wrzuć do miski z marynatą, wymieszaj i odstaw na 30 min do lodówki.', 270),
(242, 5, 'Mięso usmaż na rozgrzanej patelni.', 270),
(243, 4, 'Ugotowaną marchewkę odcedź i wrzuć do niej masło. Poczekaj aż masło się roztopi, wymieszaj, dosyp bułkę tartą i ponownie wymieszaj.', 270),
(244, 1, 'Bagietę na pół wzdłuż i w poprzek.', 271),
(245, 3, 'Liście sałaty umyj i wysusz.', 271),
(246, 4, 'Wszystko to włóż do bagiety.', 271),
(247, 2, 'Jajko ugotuj i pokrój w plastry, podobnie jak pomidora, znaczy tylko w plastry nie, że też ugotować.', 271),
(248, 1, 'Warzywa obierz i do gara.', 286),
(249, 2, 'Mięso umyj i do gara.', 286),
(250, 3, 'Cebule opal nad palnikiem i do gara.', 286),
(251, 4, 'Dodaj majeranek, oregano, liść laurowy i ziele angielskie.', 286),
(252, 5, 'Zalej wodą po sam korek i gotuj przez 2h.', 286),
(253, 6, 'W miedzy czasie ugotuj ryż.', 286),
(254, 7, 'Po 2h wyciągnij wszystko z rosołu i pokrój.', 286),
(255, 8, 'Do zupy wlej przecier pomidorowy, wymieszaj i gotuj jeszcze kilkanaście minut.', 286),
(256, 9, 'Ryż i warzywa zalej zupką i jedz.', 286);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `unit`
--

DROP TABLE IF EXISTS `unit`;
CREATE TABLE IF NOT EXISTS `unit` (
  `unit_id` int(63) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) COLLATE cp1250_polish_ci NOT NULL,
  `shortcut` varchar(63) COLLATE cp1250_polish_ci NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=cp1250 COLLATE=cp1250_polish_ci;

--
-- Zrzut danych tabeli `unit`
--

INSERT INTO `unit` (`unit_id`, `unit_name`, `shortcut`) VALUES
(1, 'gram', 'g'),
(2, 'mililitr', 'ml'),
(3, 'sztuka', 'szt.'),
(5, 'duża łyżka', 'łyż.'),
(6, 'mała łyżka', 'm-łyż.'),
(7, 'kromka', 'krom.'),
(9, 'opakowanie', 'opak.');

-- --------------------------------------------------------

--
-- Struktura widoku `date_dish_view`
--
DROP TABLE IF EXISTS `date_dish_view`;

DROP VIEW IF EXISTS `date_dish_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `date_dish_view`  AS  select `calendar`.`day` AS `day`,`calendar`.`month` AS `month`,`calendar`.`year` AS `year`,`calendar`.`meal_number` AS `meal_number`,`calendar`.`portions` AS `portions`,`calendar`.`preparation_time` AS `preparation_time`,`calendar`.`rating` AS `rating`,`dishes`.`dish_id` AS `dish_id`,`dishes`.`dish_name` AS `dish_name`,`dishes`.`image` AS `image` from (`calendar` left join `dishes` on((`dishes`.`dish_id` = `calendar`.`dish_id`))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `ingredients_view`
--
DROP TABLE IF EXISTS `ingredients_view`;

DROP VIEW IF EXISTS `ingredients_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ingredients_view`  AS  select `ingredients`.`ingredient_id` AS `ingredient_id`,`ingredients`.`ingredient_name` AS `ingredient_name`,`ingredients`.`kcal_per_unit` AS `kcal_per_unit`,`unit`.`unit_name` AS `unit_name`,`unit`.`unit_id` AS `unit_id` from (`ingredients` left join `unit` on((`ingredients`.`unit_id` = `unit`.`unit_id`))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `recipes_ingredients_view`
--
DROP TABLE IF EXISTS `recipes_ingredients_view`;

DROP VIEW IF EXISTS `recipes_ingredients_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `recipes_ingredients_view`  AS  select `recipes_ingredients`.`recipe_element_id` AS `recipe_element_id`,`recipes_ingredients`.`dish_id` AS `dish_id`,`recipes_ingredients`.`amount` AS `amount`,`ingredients`.`ingredient_name` AS `ingredient_name`,`ingredients`.`ingredient_id` AS `ingredient_id`,`ingredients`.`kcal_per_unit` AS `kcal_per_unit`,`unit`.`unit_name` AS `unit_name`,`unit`.`shortcut` AS `shortcut` from ((`recipes_ingredients` left join `ingredients` on((`recipes_ingredients`.`ingredient_id` = `ingredients`.`ingredient_id`))) left join `unit` on((`ingredients`.`unit_id` = `unit`.`unit_id`))) ;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `calendar`
--
ALTER TABLE `calendar`
  ADD CONSTRAINT `dish_id_calendar_fk` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `unit_id_fk` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `recipes_ingredients`
--
ALTER TABLE `recipes_ingredients`
  ADD CONSTRAINT `dish_id_ingredients_fk` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ingredients_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `recipes_steps`
--
ALTER TABLE `recipes_steps`
  ADD CONSTRAINT `dish_id_steps_fk` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
