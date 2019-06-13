/*
SELECT d.*, SUM(b.total_fair) AS final_total, b.app_income, i.balance
						FROM driver d JOIN
							booking b
							ON d.id = b.driver_id LEFT JOIN
							(SELECT i.driver_id, 
							 SUM(i.credit) - SUM(i.debit) AS balance
							FROM app_income i
							GROUP BY i.driver_id) i
							ON i.driver_id = d.id
							GROUP BY d.id, i.balance
							ORDER BY d.id DESC
*/
-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 148.72.232.172:3306
-- Generation Time: Jun 12, 2019 at 05:44 PM
-- Server version: 5.5.51-38.1-log
-- PHP Version: 7.1.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `driverOnApp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(20) NOT NULL,
  `username` varchar(245) DEFAULT NULL,
  `auth_id` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `mobile_no1` varchar(20) DEFAULT NULL,
  `profile_img` varchar(245) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `auth_id`, `password`, `email`, `mobile_no`, `mobile_no1`, `profile_img`) VALUES
(1, 'DriverOnApp', 'admin', '12345', 'admin@gmail.com', '8949724055', '9828784536', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_income`
--

CREATE TABLE `app_income` (
  `id` int(11) NOT NULL,
  `driver_id` varchar(10) NOT NULL,
  `credit` float NOT NULL DEFAULT '0',
  `debit` float NOT NULL DEFAULT '0',
  `date_of_payment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(20) NOT NULL,
  `client_id` int(20) DEFAULT NULL,
  `driver_id` int(20) DEFAULT NULL,
  `latitude` varchar(245) NOT NULL,
  `longitude` varchar(245) NOT NULL,
  `convPrice` float NOT NULL,
  `discount` float NOT NULL,
  `extra_charges` float NOT NULL,
  `tax` float NOT NULL,
  `actualPrice` float NOT NULL,
  `night_charge` int(10) NOT NULL,
  `pick_location` varchar(245) DEFAULT NULL,
  `drop_location` varchar(245) DEFAULT NULL,
  `tripType` varchar(245) NOT NULL,
  `carType` varchar(245) NOT NULL,
  `gearType` varchar(245) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `e_start_time` datetime DEFAULT NULL,
  `e_end_time` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `total_fair` float DEFAULT NULL,
  `app_income` float NOT NULL DEFAULT '0',
  `initiate_time` datetime NOT NULL,
  `go_time` datetime NOT NULL,
  `arrived_time` datetime NOT NULL,
  `driver_rating` int(2) NOT NULL,
  `driver_review` text NOT NULL,
  `client_rating` int(2) NOT NULL,
  `client_review` text NOT NULL,
  `desLat` varchar(245) NOT NULL,
  `desLng` varchar(245) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `client_id`, `driver_id`, `latitude`, `longitude`, `convPrice`, `discount`, `extra_charges`, `tax`, `actualPrice`, `night_charge`, `pick_location`, `drop_location`, `tripType`, `carType`, `gearType`, `start_time`, `end_time`, `e_start_time`, `e_end_time`, `status`, `total_fair`, `app_income`, `initiate_time`, `go_time`, `arrived_time`, `driver_rating`, `driver_review`, `client_rating`, `client_review`, `desLat`, `desLng`) VALUES
(10715, 61, 95, '26.9176886', '75.8197435', 50, 0, 0, 0, 284, 0, 'Dawa Bazaar Complex', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, '', 0, '', '', ''),
(10737, 277, 95, '26.8519398', '75.7812974', 50, 0, 0, 0, 3482, 0, '290.mahaveernagar 2 maharani farm Jaipur ', 'Jhunjhunu khatushyam etc', 'outstation', 'small', 'manual', '2019-05-27 07:06:55', '2019-05-31 16:12:38', '2019-05-27 07:30:33', '2019-05-31 16:00:33', 'complete', 3532, 353.2, '2019-05-27 07:06:48', '2019-05-27 07:06:49', '2019-05-27 07:06:51', 0, '', 0, '', '', ''),
(10736, 250, 87, '26.83996019334', '75.741610136576', 100, 0, 0, 0, 756, 0, '22A, Sheer Sagar Patarkar Colony, Dholai, Jaipur, Rajasthan 302029, India', 'Hisar, Haryana, India', 'oneway', 'medium', 'manual', '2019-05-27 11:01:31', '2019-05-27 16:30:31', '2019-05-27 11:01:31', '2019-05-27 16:30:31', 'start', 856, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, '', 0, '', '29.1491875', '75.7216527'),
(10741, 33, 1, '26.9411343', '75.8470406', 50, 0, 0, 0, 906, 100, '4, Suraj Colony, Shankar Nagar, Jaipur, Rajasthan 302002, India', 'A - 406, Ganesh Residency, Mansarovar Road, IOC Rd, Vaikunth Nagar, Aabugiri Tenement, Chandkheda, Ahmedabad, Gujarat 382424, India', 'local', 'small', 'manual', '2019-05-28 11:30:55', '2019-05-29 09:26:30', '2019-05-28 11:25:04', '2019-05-29 12:23:04', 'complete', 1056, 105.6, '2019-05-28 11:15:55', '2019-05-28 11:20:55', '2019-05-28 11:25:55', 4, '', 0, '', '23.1112371', '72.5663146'),
(10729, 519, 87, '26.8573823', '75.7882257', 50, 0, 0, 0, 332, 0, 'Ekta Block, Mahaveer Nagar, Durgapura, Jaipur, Rajasthan 302018, India', 'Ekta Block, Mahaveer Nagar, Durgapura, Jaipur, Rajasthan 302018, India', 'local', 'medium', 'manual', '2019-05-18 16:32:31', '2019-05-18 21:33:21', '2019-05-18 17:00:15', '2019-05-18 21:00:15', 'complete', 382, 38.2, '2019-05-18 16:32:23', '2019-05-18 16:32:25', '2019-05-18 16:32:29', 0, '', 0, '', '26.8573823', '75.7882257'),
(10747, 558, 87, '26.888480639255', '75.762257698869', 50, 0, 0, 0, 142, 0, 'Plot no 482A-B, Sethia Nandini Heights, Laxman Path, Vivek Vihar, Shyam Nagar, Jaipur, Rajasthan 302019, India', 'Vaishali nagar', 'local', 'small', 'manual', '2019-06-02 16:54:18', '2019-06-02 18:10:31', '2019-06-02 17:00:09', '2019-06-02 19:00:09', 'complete', 192, 19.2, '2019-06-02 16:54:11', '2019-06-02 16:54:13', '2019-06-02 16:54:15', 0, '', 5, '', '', ''),
(10754, 569, 57, '13.0523911', '77.6361742', 50, 0, 0, 0, 284, 0, '4th Main Rd, Sanchar Nagar MCECHS Layout, Ashwath Nagar, HBR Layout, Bengaluru, Karnataka 560045, India', '4th Main Rd, Sanchar Nagar MCECHS Layout, Ashwath Nagar, HBR Layout, Bengaluru, Karnataka 560045, India', 'local', 'small', 'manual', '2019-06-07 12:00:45', '2019-06-07 16:00:45', '2019-06-07 12:00:45', '2019-06-07 16:00:45', 'pending', 334, 0, '1970-01-01 05:30:00', '1970-01-01 05:30:00', '1970-01-01 05:30:00', 0, '', 0, '', '13.0523911', '77.6361742'),
(10757, 147, 90, '26.8371763', '75.8585741', 50, 0, 0, 0, 542, 0, '1/65, Indira Gandhi Nagar, Sector-1, Jagatpura, Jaipur, Rajasthan 302017, India', 'Bhilwara, Rajasthan, India', 'outstation', 'medium', 'manual', '2019-06-10 03:55:55', '2019-06-10 14:10:36', '2019-06-10 04:00:00', '2019-06-10 16:00:00', 'complete', 592, 59.2, '2019-06-10 03:55:44', '2019-06-10 03:55:48', '2019-06-10 03:55:51', 0, '', 0, '', '25.3407388', '74.6313183'),
(10746, 495, 95, '26.8521711', '75.7589744', 50, 0, 0, 0, 1092, 0, 'F-21, Sumer Nagar, Sunder Nagar, Jaipur, Rajasthan 302020, India', 'Bhilwara, Rajasthan, India', 'outstation', 'medium', 'manual', '2019-06-02 12:36:04', '0000-00-00 00:00:00', '2019-06-02 14:00:45', '2019-06-03 18:00:45', 'pending', 1142, 0, '2019-06-02 12:35:49', '2019-06-02 12:35:51', '2019-06-02 12:35:53', 0, '', 0, '', '25.3407388', '74.6313183'),
(10756, 551, 90, '26.88864', '75.810731', 50, 0, 0, 0, 695, 0, 'C-100, Moti Marg, Bapu Nagar, Jaipur, Rajasthan 302015, India', 'Kota, Rajasthan, India', 'outstation', 'luxury', 'manual', '2019-06-09 07:01:05', '2019-06-09 20:10:41', '2019-06-09 07:15:00', '2019-06-09 20:00:00', 'complete', 745, 74.5, '2019-06-09 07:00:52', '2019-06-09 07:00:57', '2019-06-09 07:01:01', 0, '', 0, '', '25.2138156', '75.8647527'),
(10752, 250, 87, '26.84026346', '75.74159515', 100, 0, 0, 0, 662, 0, '22A, Sheer Sagar Patarkar Colony, Dholai, Jaipur, Rajasthan 302029, India', '236 patrakar colony new sanganer road mansarovar Jaipur', 'oneway', 'medium', 'manual', '2019-06-06 15:00:06', '2019-06-06 20:00:06', '2019-06-06 15:00:06', '2019-06-06 20:00:06', 'pending', 762, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, '', 0, '', '', ''),
(10758, 307, 90, '26.9383431', '75.7834813', 50, 0, 0, 0, 2828, 0, 'S 10 AmbabariJaipur, Rajasthan 302039 India', 'Mussoorie, Uttarakhand, India', 'outstation', 'large', 'manual', '2019-06-11 07:07:46', '0000-00-00 00:00:00', '2019-06-11 07:00:52', '2019-06-14 19:00:52', 'pending', 2878, 0, '2019-06-11 07:07:39', '2019-06-11 07:07:41', '2019-06-11 07:07:43', 0, '', 0, '', '30.4599099', '78.0663978'),
(10759, 67, 99, '26.836845138945', '75.772191007774', 50, 0, 0, 0, 284, 0, '5/12, SFS Manasarovar, Hans Vihar, Sector 5, Mansarovar, Jaipur, Rajasthan 302020, India', 'Various locations in Jaipur', 'local', 'small', 'manual', '2019-06-11 15:23:54', '2019-06-11 19:20:25', '2019-06-11 15:30:53', '2019-06-11 19:30:53', 'complete', 334, 33.4, '2019-06-11 13:06:56', '2019-06-11 13:23:40', '2019-06-11 15:22:40', 0, '', 0, '', '', ''),
(10760, 584, 83, '26.89053086729', '75.839230411237', 50, 0, 0, 0, 689, 0, '3-NA-9, Jawahar Magor Colony, Sector 3, Jawahar Nagar, Jaipur, Rajasthan 302004, India', 'Alwar', 'outstation', 'large', 'auto', '2019-06-12 08:00:11', '2019-06-12 22:30:11', '2019-06-12 08:00:11', '2019-06-12 22:30:11', 'pending', 739, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, '', 0, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int(20) NOT NULL,
  `name` varchar(245) DEFAULT NULL,
  `email_id` varchar(245) DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `address` text,
  `mobile_no` varchar(20) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `profile_img` varchar(245) DEFAULT NULL,
  `auth_id` varchar(50) NOT NULL,
  `auth_pswrd` varchar(50) NOT NULL,
  `clientLat` varchar(245) NOT NULL,
  `clientLng` varchar(245) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `name`, `email_id`, `gender`, `address`, `mobile_no`, `zip_code`, `profile_img`, `auth_id`, `auth_pswrd`, `clientLat`, `clientLng`) VALUES
(503, 'Kailash Chand Sharma', 'kailashsharma67762@gmail.com', 'F', 'Plot-123 Panchsheel Enclave Durgapura', '9414067762', '302018', NULL, '', 'anuj1489', '', ''),
(504, 'MAHESH AGATWAL', 'agarwalmahesh337@gmail.com', 'M', '28, mangal vihar,ram nagar ext. swez farm,sodala', '9214517443', '302019', NULL, '', 'mahesh28', '', ''),
(1, 'Mani Singhal', 'mani@gmail.com', 'M', 'Mansarowar, Obere Str. 57', '7891171378', '302020', NULL, 'mani', '123456', '', ''),
(72, 'Sunil Kumar Sharma ', 'gunna21feb@gmail.com', 'M', NULL, '8619502900', NULL, NULL, '', '9887019543', '', ''),
(506, 'Er.jgupta', 'er.jgupta@gmail.com', 'M', 'X the egg to hhj', '9739273537', '560077', NULL, '', '@aryan782@', '', ''),
(505, 'Ashok Falor', 'ashokfalor@yahoo.com', 'M', '2/203vidhyadhar nagar jaipur', '9829013321', '302023', NULL, '', '1418', '', ''),
(7, 'Fr?d?rique Citeaux', 'mani@gmail.com', 'M', '24, place Kl?ber', '7777456532', '302020', NULL, 'Nancy', 'doda#123', '', ''),
(9, 'Laurence Lebihans', 'test@gmail.com', 'M', '12, rue des Bouchers', '9999444555', '302020', NULL, 'Janet', 'doda#123', '', ''),
(10, 'Elizabeth Lincoln', 'deep@gmail.com', 'M', '23 Tsawassen Blvd.', '9898755345', '890890', NULL, 'Margaret', 'doda#123', '', ''),
(11, 'Victoria Ashworth', 'krani@gmail.com', 'M', 'Fauntleroy Circus', '8979879845', '302020', NULL, 'Steven', 'doda#123', '', ''),
(12, 'Patricio Simpson', 'ujagar@gmail.com', 'M', 'Cerrito 333', '7891171378', '302020', NULL, 'Michael', 'doda#123', '', ''),
(13, 'Francisco Chang', 'mani@gmail.com', 'M', 'Sierras de Granada 9993', '9999565612', '898989', NULL, 'Robert', 'doda#123', '', ''),
(14, 'Yang Wang', 'jaipur@gmail.com', 'M', 'Hauptstr. 29', '7777456532', '302020', NULL, 'Laura', 'doda#123', '', ''),
(15, 'Pedro Afonso', 'test@gmail.com', 'M', 'Av. dos Lus?adas, 23', '1234567890', '890890', NULL, 'Anne', 'doda#123', '', ''),
(16, 'Elizabeth Brown', 'deep@gmail.com', 'M', 'Berkeley Gardens 12 Brewery', '9999444555', '302020', NULL, 'Adam', 'doda#123', '', ''),
(17, 'Sven Ottlieb', 'krani@gmail.com', 'M', 'Walserweg 21', '9898755345', '302020', NULL, 'Nancy', 'doda#123', '', ''),
(18, 'Janine Labrune', 'ujagar@gmail.com', 'M', '67, rue des Cinquante Otages', '8979879845', '898989', NULL, 'Andrew', 'doda#123', '', ''),
(19, 'Ann Devon', 'mani@gmail.com', 'M', '35 King George', '7891171378', '302020', NULL, 'Janet', 'doda#123', '', ''),
(20, 'Roland Mendel', 'jaipur@gmail.com', 'M', 'Kirchgasse 6', '9999565612', '890890', NULL, 'Margaret', 'doda#123', '', ''),
(21, 'Aria Cruz', 'test@gmail.com', 'M', 'Rua Or?s, 92', '7777456532', '302020', NULL, 'Steven', 'doda#123', '', ''),
(22, 'Diego Roel', 'deep@gmail.com', 'M', 'C/ Moralzarzal, 86', '1234567890', '302020', NULL, 'Michael', 'doda#123', '', ''),
(23, 'Rajat', 'Rajatpancholi01@gmail.com', 'M', NULL, '9928734821', NULL, NULL, '', 'Password123#', '', ''),
(24, 'Deepak', 'dsinghal70@gmail.com', 'M', NULL, '8696707656', NULL, NULL, '', 'salmaankhan', '', ''),
(25, 'Mani ratnam', 'maniratnam@gmail.com', 'M', NULL, '', NULL, NULL, '', '', '', ''),
(26, 'Maniratnam1', 'maniratnam1@gmail.com', 'M', NULL, '8890901000', NULL, NULL, '', '1234', '', ''),
(27, 'Ravi pancholi', 'ravipancholi0055@gmail.com', 'M', '31dadu dayal colony', '8949724055', '302020', NULL, '', 'ravi@0055', '', ''),
(28, 'Karan Singh', 'karansinghbadangrh@gmail.com', 'M', NULL, '8233717773', NULL, NULL, '', '1995', '', ''),
(29, 'anuj6959', 'anuj6959@gmail.com', 'M', NULL, '9314516959', NULL, NULL, '', 'Pa&&word7823', '', ''),
(30, 'Prayag', 'prayagrajtrivedi23@gmail.com', 'M', NULL, '9782041751', NULL, NULL, '', '123456', '', ''),
(31, 'Uma Shankar Shukla', 'shukla.umashankar123@gmail.com', 'M', NULL, '9530244931', NULL, NULL, '', 'uma@1948', '', ''),
(32, 'Manish kumar mahawar', 'manishmahawar45@gmail.com', 'M', NULL, '9694780921', NULL, NULL, '', 'manish@45', '', ''),
(33, 'Ujagar', 'ujagarsingh@gmail.com', 'M', NULL, '9828784536', NULL, NULL, '', '1234', '', ''),
(34, 'd68082', 'dr.deepandra@gmail.com', 'M', NULL, '9414268082', NULL, NULL, '', 'dvy155', '', ''),
(35, 'Jhalanim', 'jhalanim23@gmail.com', 'M', NULL, '9772222247', NULL, NULL, '', 'driver123', '', ''),
(36, 'ganesh chopra', 'chopraganesh3100@gmail.com', 'M', NULL, '7976265171', NULL, NULL, '', 'chopra3100', '', ''),
(37, 'Manish', 'manish.antic2014@gmail.com', 'M', NULL, '9588969683', NULL, NULL, '', 'manish123', '', ''),
(38, 'Aditya Sharma ', 'adityasharmanannu@gmail.com', 'M', NULL, '9782599950', NULL, NULL, '', 'Admin@12345', '', ''),
(39, 'Murlidhra khandal', 'murlidharkhandal@gmail.com', 'M', NULL, '9950603753', NULL, NULL, '', 'Sumitra09', '', ''),
(40, 'ameriya', 'ameriya@gmail.com', 'M', NULL, '9828035811', NULL, NULL, '', 'jaya@123', '', ''),
(41, 'Bhupesh ', 'bhupeshkumargoyal@gmail.com', 'M', NULL, '8005543347', NULL, NULL, '', 'Welcome1*', '', ''),
(42, 'Suresh ', 'sureshbadiwal84@gmail.com', 'M', NULL, '9929166946', NULL, NULL, '', '9828249996', '', ''),
(43, 'Rajesh yadav', 'rajeshyadav2281@gmail.com', 'M', NULL, '8003972340', NULL, NULL, '', 'rajesh2281', '', ''),
(44, 'Rajesh meena', 'rajeshmeena2281@gmail.com', 'M', NULL, '8003972340', NULL, NULL, '', 'rajesh2281', '', ''),
(45, 'bhagchand Gurjar ', 'bhagchandgurjar@gmail.com', 'M', NULL, '9887772587', NULL, NULL, '', '9887772587', '', ''),
(46, 'bhagchand', 'bhagchandgurjar@gamil.com', 'M', NULL, '9887772587', NULL, NULL, '', '123456', '', ''),
(47, 'Ram', 'ram@gmail.com', 'M', NULL, '9828784536', NULL, NULL, '', '1234', '', ''),
(48, 'Ramavtar sharma', 'ramavtar2898@gmail.com', 'M', NULL, '9928655517', NULL, NULL, '', 'yash2898', '', ''),
(49, 'Balaji', 'maheshwari.apeksha@gmail.com', 'M', NULL, '9414056513', NULL, NULL, '', 'India123', '', ''),
(50, 'Suresh chand gupta', 'scgupta515@gmail.com', 'M', NULL, '9413444458', NULL, NULL, '', 'suresh1655', '', ''),
(51, 'Bhawani Shankar Kumawat', 'Bhawanishankar9460@gmail.com', 'M', NULL, '8875575756', NULL, NULL, '', '8875575756', '', ''),
(52, 'Shyam samor', 'shyamsamor@yahoo.co.in', 'M', 'C-264 kings road nirmanngar jaipur ', '9829060352', '302019', NULL, '', '1056shyam', '', ''),
(53, 'Dimple', 'bardiadimple@gmail.com', 'M', NULL, '8955193353', NULL, NULL, '', 'dimple3353', '', ''),
(54, 'ganesh chopra', 'ganeshchopra0055@gmail.com', 'M', NULL, '9976265171', NULL, NULL, '', 'ganeshchopra', '', ''),
(55, 'Girraj sharma', 'girirajsharma1944@gmail.com', 'M', NULL, '9829137639', NULL, NULL, '', 'bc@0925', '', ''),
(56, 'Girraj sharma', 'girirajsharma44@yahoo.in', 'M', NULL, '9829137639', NULL, NULL, '', 'bc@0925', '', ''),
(57, 'JASWANT SINGH ', 'toreadorj@gmail.com', 'M', NULL, '9414054830', NULL, NULL, '', 'Jaswant1105', '', ''),
(58, 'KRISHNA MURARI', 'kmurari.mn@gmail.com', 'M', NULL, '9414312647', NULL, NULL, '', 'krishna46', '', ''),
(59, 'Lavesh ', 'lavesh@gmail.com', 'M', NULL, '9998887770', NULL, NULL, '', '1234', '', ''),
(60, 'bhagchand gurjar', 'bhagchandgurjar0055@gmail.com', 'M', NULL, '9887772587', NULL, NULL, '', 'gurjar0055', '', ''),
(61, 'Mohit Goyal ', 'mohitmt.goyal@gmail.com', 'M', NULL, '7239995999', NULL, NULL, '', 'mikku123@@', '', ''),
(62, 'Test new client', 'testclient@gmail.com', 'M', NULL, '9828784536', NULL, NULL, '', '12345', '', ''),
(63, 'Kaluram', 'kaluram@720gmail.com', 'M', NULL, '9928441539', NULL, NULL, '', '123456', '', ''),
(64, 'Archana', 'apd_n@yahoo.com', 'M', NULL, '9929204908', NULL, NULL, '', 'argoargo512', '', ''),
(65, 'Divyankjain', 'divyankjain171094@gmail.com', 'M', NULL, '8952852443', NULL, NULL, '', '8952852443', '', ''),
(66, 'Dr.jogendra pal dua', 'jpdua11@gmail.com', 'M', NULL, '9929090826', NULL, NULL, '', '1957', '', ''),
(67, 'Prof. (Dr.) Praveen Dhyani', 'dhyani_p@yahoo.com', 'M', '5/12, SFS, Agrawal Farm, Mansarovar, Jaipur', '9929112465; 79768683', '302020', NULL, '', 'adpd2373', '', ''),
(68, 'Deepak', 'deepak.joshi1985@yahoo.in', 'M', NULL, '8295322113', NULL, NULL, '', 'deepak', '', ''),
(69, 'Ramesh  Chandra', 'rameshchandra.baresa@yahoo.in', 'M', NULL, '9664084539', NULL, NULL, '', 'channa@123', '', ''),
(70, 'Hari meena', 'hari@gmail.com', 'M', '', '9828784536', '', NULL, '', '1234', '', ''),
(71, 'Ashish', 'ashish_brommie@yahoo.com', 'M', NULL, '9352957209', NULL, NULL, '', 'ashishb', '', ''),
(73, 'dspon123', 'dsaini279@gmail.com', 'M', NULL, '9588279505', NULL, NULL, '', 'saini123', '', ''),
(74, 'dspon0638', 'sdeep1740@gmail.com', 'M', NULL, '9588279505', NULL, NULL, '', 'saini123', '', ''),
(75, 'Amit', 'vijayamit83@gmail.com', 'M', NULL, '8890126720', NULL, NULL, '', '1seiaaseac', '', ''),
(76, 'Anant jain', 'anant_enterprises88@yahoo.com', 'M', NULL, '9828502444', NULL, NULL, '', 'tanvi2010', '', ''),
(77, 'Nikhil jain', 'rinkybaid@rediffmail.com', 'M', NULL, '8955879818', NULL, NULL, '', 'nradnrad', '', ''),
(78, 'Yash ', 'yash5491.aiesec@gmail.com', 'M', NULL, '9772896600', NULL, NULL, '', 'Augu@2017', '', ''),
(79, 'Rohin pancholi', 'rohinpancholi0055@gmail.com', 'M', NULL, '9782698311', NULL, NULL, '', 'rohin@0055', '', ''),
(80, 'KEJRIWAL15', 'kejriwal15@yahoo.com', 'M', NULL, '9314502285', NULL, NULL, '', 'Utsav1995', '', ''),
(81, 'Chakresh Jain', 'chakreshjain63@gmail.com', 'M', NULL, '9828160801', NULL, NULL, '', 'chirag1096', '', ''),
(82, 'mathurrajkumar', 'mathurrajkumar@rediffmail.com', 'M', NULL, '', NULL, NULL, '', '', '', ''),
(83, 'Reena', 'reenajain1980@gmail.com', 'M', NULL, '7597000025', NULL, NULL, '', '7597000025', '', ''),
(84, 'mathurrajkumar', 'mathurrajkumar13@gmail.com', 'M', NULL, '9686418290', NULL, NULL, '', 'kalpana12', '', ''),
(85, 'Sanjay Bajpai', 'bajpaisanjay@cegindia.com', 'M', NULL, '7896006041', NULL, NULL, '', 'san44rak', '', ''),
(86, 'Radha mohan', 'mohan@gmail.com', 'M', NULL, '9828784536', NULL, NULL, '', '12345', '', ''),
(87, 'Manish', 'manishaiet17@gmail.com', 'M', NULL, '', NULL, NULL, '', '@1759200', '', ''),
(88, 'Prabhaluhadia', 'drprabhaluhadia@gmail.com', 'M', NULL, '9414794684', NULL, NULL, '', 'prabha6152', '', ''),
(89, 'app', 'app@gmail.com', 'M', 'app pura jaipur', '1234567890', '123123', NULL, '', '123', '', ''),
(90, 'Kanhaiya Sharma ', 'kanhaiya.sharma08@gmail.com', 'M', 'Golyawas ', '9799488850', '302020', NULL, '', 'Admin@12345', '', ''),
(91, 'Sajjan gurjar', 'sajjangurjar@gmail.com', 'M', 'Nirayan nivash gurjaro ka mohla sanganer', '9680513992', '300306', NULL, '', 'sajjan', '', ''),
(92, 'golu', 'golu@gmail.com', 'M', 'jaipur', '7891171378', '302020', NULL, '', '123', '', ''),
(93, 'Testhari', 'testhari@gmail.com', 'M', 'Jaipur', '9828784536', '320987', NULL, '', '1234', '', ''),
(94, 'Rakesh', 'contactsb@y7mail.com', 'M', 'Sri Villa,Block-D,House No 23,Surya Nagar,Taron ki koot,Tonk Road,Jaipur', '9314068996', '302018', NULL, '', '9314068996', '', ''),
(95, 'vkk30', 'vineet.khajanchi@gmail.com', 'M', 'M25/26 , Income tax colony,Durgapura,Tonk Road,Jaipur', '9351330400', '302018', NULL, '', 'vineet28', '', ''),
(96, 'Kshitij chhabra', 'kshitijchhabra@yahoo.co.in', 'M', '144, mahaveer nagar first,  durgapura', '9983471085', '302018', NULL, '', '1270144305k', '', ''),
(97, 'Ruchin', 'ruchinsharma@gmail.com', 'M', '35,kailashpuri,opp sanghi Farm, tonk Road ', '9829111225', '302018', NULL, '', 'dev123', '', ''),
(98, 'Prakash puri', '03satyaprakash@gmail.com', 'M', 'Kalishpuri, jaipur', '7014924058', '', NULL, '', 'satya12345', '', ''),
(99, 'Aditya', 'kavya300.ms@gmail.com', 'M', 'A83 jagdamba nagar heerapura ajmer road', '8619804408', '302021', NULL, '', 'aditya619', '', ''),
(100, 'Sandeep', 'mittal.sukanta@gmail.com', 'M', 'E76 chirtranjan marg cscheme', '7742470010', '302002', NULL, '', 'tarumittal', '', ''),
(101, 'Sachin Tanwar', 'sachintanwar002@gmail.com', 'M', 'B-47, sitaram Bhawan, natraj Nagar,imli phatak, Jaipur, ', '9413552967', '302015', NULL, '', 'sachin2190', '', ''),
(102, 'Dkpancho', 'dineshpancholi@ymail.com', 'M', '', '', '', NULL, '', 'HARLEy61456194775', '', ''),
(103, 'Ujdh', 'yyd@fhfj.com', 'M', '', '', '', NULL, '', '', '', ''),
(104, 'Navnit', 'navnitnks@gmail.com', 'M', '73/95, madhyam marg, mansarovar', '8003330105', '302020', NULL, '', 'kingsu', '', ''),
(105, 'Honey goyal', 'honeygoyal1471999@gmail.com', 'M', '82/593 pratap nagar sector 8 sanganer jaipur', '7891558633', '', NULL, '', 'qwerty9', '', ''),
(106, 'Anil', 'anil@gmail.com', 'M', 'Mansarovar jaipur', '8432214292', '302020', NULL, '', '123', '', ''),
(107, 'Yash raj pancholi', 'yashraj2898@gmail.com', 'M', '27 dadu dayal colony mansarovar', '9529233654', '302020', NULL, '', '2898', '', ''),
(108, 'Rashmi ', 'chaitanya.sharma@mail.com', 'M', '76 Patel Nagar Iskcon temple road mansarovar Jaipur  ', '9414050627', '302020 ', NULL, '', 'rashmijis', '', ''),
(109, 'Kuldeep', 'kuldeep.infomedia@gmail.com', 'M', 'Jaipur', '9782444122', '302018', NULL, '', '12345678', '', ''),
(110, 'MohanGoenka', 'mohan3112goenka@gmail.com', 'M', 'C-17A,jamuna nagar, sodala, ajmer road', '9314473401', '302006', NULL, '', 'mohan3112', '', ''),
(111, 'Suman', 'sumanjain0681@gmail.com', 'M', '116 vrindavan vihar jaipur', '9352241783', '302019', NULL, '', '09999680162', '', ''),
(112, 'arvindmeena96', 'arvindmeena96@gmail.com', 'M', 'P 45 Parmanand nagar niwaro road jhotwara Jaipur', '9983432000', '302012', NULL, '', 'neetu96022', '', ''),
(113, 'Piyush Nemani', 'piyushnemani@gmail.com', 'M', 'A1B murti nagar meenawala Jaipur', '', '', NULL, '', 'piyushpiyush', '', ''),
(114, 'Ashwin', 'kumar.ashwani777@gmail.com', 'M', 'Jaipur', '9799605400', '302020', NULL, '', '', '', ''),
(115, 'Jaskaran dugar', 'jkdugar.jaipur2014@gmail.com', 'M', 'E 164 Ramesh marg c Scheme Neelkanth 2nd floor C scheme Jaipur', '9829053724', '', NULL, '', 'arihant21', '', ''),
(116, 'Kamlesh jain ', 'kamleshkumarjain12@gmail.com', 'M', '92, Nand Colony, opp. Choudhary petrol pump, Tonk Road Sanganer, Jaipur ', '9529088175', '1278', NULL, '', 'KAML0709', '', ''),
(117, 'R B Sharma', 'rbsdenabank@gmail.com', 'M', 'E-5/70, Chitrakoot, AjmerRoad, Jaipur', '9829052420', '302021', NULL, '', 'rbs@1234', '', ''),
(118, 'Rahulmathurjpr', 'rahulmathurjpr@gmail.com', '', 'A-87 manu path shyam nagar jaipur ', '8209789227', '302019', NULL, '', 'ka20e4882', '', ''),
(119, 'Pratyaksh jain', 'pratyakshj96@gmail.com', 'M', '158 Milap nagar Tonk road Jaipur', '302018', '', NULL, '', '1234jain', '', ''),
(120, '', 'pjain@nidaan.com', 'M', '', '7793008902', '', NULL, '', '123456789', '', ''),
(121, 'test', 't@gmail.com', 'M', 'jaipur', '7891171378', '302020', NULL, '', '123', '', ''),
(122, 'golu', 'g@gmail.com', 'M', 'jaipur', '7891171378', '302020', NULL, '', '123', '', ''),
(123, 'Raju', 'raju751985@gmail.com', 'M', '', '9829054632', '', NULL, '', 'raju', '', ''),
(124, 'Ronak Sodha', 'ronaksodha23816@gmail.com', 'M', 'Raja park jaipur', '9782184426', '99999999', NULL, '', 'ronaksodha', '', ''),
(125, 'Bhagwan singh', 'bhagwansingh95529@gmail.com', 'M', '', '8278628436', '', NULL, '', '123456', '', ''),
(126, 'Ram prasad ', 'vyasramprasad3333@gmail.com', 'M', 'Jaipur', '8233332975', '123456', NULL, '', '123456', '', ''),
(127, 'pramod kumar', 'pramodsharmasahil@gmail.com', 'M', 'manglamxity', '8290077706', '302028', NULL, '', 'myv@0709', '', ''),
(128, 'ak', 'ak@gmail.com', 'M', 'jaipur sapotra', '7891171378', '302020', NULL, '', '1234', '', ''),
(129, 'Vikas Rohilla', 'vikas@fmar.in', 'M', 'Jaipur', '9785852141', '302015', NULL, '', 'vkrohilla', '', ''),
(130, 'Anil', 'anildosi1964@ymail.com', 'M', '', '9331027153', '302019', NULL, '', '123456', '', ''),
(131, 'Sujata123', 'sujatajain0205@gmail.com', 'M', '979, Shantinagar, Durgapura, Jaipur(RAJ.)', '8005988598', '302018', NULL, '', 'Sujata@123', '', ''),
(132, 'Jitendra chouhan', 'jitendrachouhan2013@gmail.com', 'M', '', '8209196604', '', NULL, '', 'jeetu123', '', ''),
(133, 'Manish Mathur', 'manishmathur01@gmail.com', 'M', '1/6 Shivanand Marg , Malviya Nagar , Jaipur', '7023322203', '302017', NULL, '', 'manish94133', '', ''),
(134, 'Manish', 'manishagr710@gmail.com', 'M', '19, vijay nagar , opp. Narayan vatika, murlipura, jaipur.', '9024038124', '302001', NULL, '', '2686268600', '', ''),
(135, 'achaturvedis@gmail.com', 'achaturvedis@gmail.com', 'M', 'S1, plot no. 95,aditya vihar, Gandhi path, vaishali nagar, jaipur', '7728886755', '302021', NULL, '', 'panditji', '', ''),
(136, 'Meena sharma', 'meenarohin@gmail.com', 'M', '1 sumer nagerB golaways mansarover', '9782698311', '302020', NULL, '', 'rohin@0055', '', ''),
(137, 'Dr.sharma', 'sharmajitendra152@gmail.com', 'M', '114 ganesh nagar mansarovar jaipur', '7728944449', '302020', NULL, '', '9314269399', '', ''),
(138, 'Abhay3855', 'r.hanutiya@gmail.com', 'M', 'Vaishali nagar', '8107550821', '', NULL, '', '3855', '', ''),
(139, 'Suraj ', 'qikecommerce@gmail.com', 'M', '', '8209101942', '', NULL, '', 'suraj1444', '', ''),
(140, 'Sagarji', 'ss4487462@gmail.com', 'M', 'Mansarovar ', '9983484201', '302020', NULL, '', 'sagar3012000', '', ''),
(141, '', 'ag.neha91@gmail.com', 'M', '', '9887325885', '', NULL, '', 'nehahatesyou', '', ''),
(142, 'Nihar', 'worldnix1@gmail.com', 'M', '15, Lane 14, Ashok Nagar, Narishala Road, Ajmer', '7877409955', '302020', NULL, '', 'halfblooded', '', ''),
(143, 'Divya verma', 'vermadivya233125@gmail.com', 'M', '2/158 near crown plaza vaishali nagar jaipur', '6375148216', '302020', NULL, '', 'divyamanish', '', ''),
(144, 'Sandeep kumar yogi ', 'sandeep.yogi1983@gmail.com', 'M', 'Murlipur jaipur', '9784771605', '302016', NULL, '', '9784771605', '', ''),
(145, 'Akhil Mangal ', 'Akhilmangal88@gmail.com', 'M', 'C303, Raheja residential complex, Patrakar Colony, mansarovar, jaipur ', '8432174044', '302022', NULL, '', 'akhil@1001', '', ''),
(146, 'Bhagwan Mahajan ', 'prdp135@gmail.com', 'M', 'Andheri west ', '8169585952', '400053', NULL, '', '9546912017', '', ''),
(147, 'drumesh_meena@yahoo.co.in', 'drumesh_meena@yahoo.co.in', 'M', '1-H-168, Indira Gandhi Nagar sector 1, jagatpura', '9636367130', '302017', NULL, '', '*rj14cp2415#', '', ''),
(148, 'mani', 'name@gmail.com', 'M', 'mansarovar jaipur', '7891171378', '302020', NULL, '', '123', '', ''),
(149, 'Rajendra Kumar Meena ', 'rajendrakumarmeena2015@gmail.com', 'M', 'JAIPUR ', '9950031244', '12345', NULL, '', '9950031244', '', ''),
(150, 'Lr Bairwa', 'lrbjpr@gmail.com', 'M', '369, sector 6 Malviya Nagar Jaipur', '8619722080', '302017', NULL, '', 'lrb7890jpr', '', ''),
(151, 'Akshay', 'akshay@gmail.com', 'M', 'Jhotwara', '9680049417', '302020', NULL, '', '123', '', ''),
(152, 'Ujagar singh', 'Ujagar.singh.meena@gmail.com', 'M', 'Jaipur', '9828784536', '303109', NULL, '', '9828784536', '', ''),
(153, 'JUGAL', 'jugaljk24@gmail.com', 'M', '38/31 kiran path madhyam marg mansarovar', '9983312135', '302020', NULL, '', 'guruji@30', '', ''),
(154, 'Vikash yadav ', 'vikashthathwari7777@gmail.com', 'M', 'Skit jagatpura ', '8397944046', '1234', NULL, '', '12345', '', ''),
(155, 'Mohit esrani', 'smartymht6@gmail.com', 'M', '117/140 thadi matket agarwal farm mansarover', '8949492856', '302020', NULL, '', '9782957442', '', ''),
(156, 'Nizam Mansuri', 'nijammansuri141@gmail.com', 'M', 'Sector 35 PRATAP Nagar Sanganer', '9672625972', '302033', NULL, '', 'NIZAM141786', '', ''),
(157, 'Dinesh', 'replydinesh06@gmail.com', 'M', 'Plot no.55 vivek vihar jaipur', '9461902090', '302015', NULL, '', 'choudhary06', '', ''),
(158, 'Pawan kumar', 'pawansheoran60@gnail.com', 'M', 'Varun path mansrover , jaipur', '9610001640', '302020', NULL, '', '9610001640', '', ''),
(159, 'Anand Agarwal ', 'apama.impex@gmail.com', 'M', '99, Raghu Vihar, Mansarover,, Jaipur ', '9314080906', '302020', NULL, '', 'vibgyor88', '', ''),
(160, 'Rahul', 'mbmrahul545@gmail.com', 'M', '84/68 Shankaracharya marg Mansarovar jaipur', '9461549919', '302020', NULL, '', 'driver@4321', '', ''),
(161, 'Virendra soni', 'biloo1979@gmail.com', 'M', '11133 Block 34 Rangoli Garden maharana pratap Road Vaishali nagar jaipur ', '9680802233', '302021', NULL, '', 'dairymilk', '', ''),
(162, 'Pawan sheoran', 'pawansheoran60@gmail.com', 'M', '43/20/04 varun path , mansrover jaipur', '9610001640', '302020', NULL, '', 'p.k.s.129', '', ''),
(163, 'Jitendra', 'dentistjodhpur1@gmail.com', 'M', 'B-9, Kamla Nehru Nagar Extension-1, Jodhpur', '9413329547', '342001', NULL, '', '12345678', '', ''),
(164, 'IMST', 'imst101@yahoo.co.in', 'M', 'C-101sethi colony Jaipur', '9414072520', '302004', NULL, '', 'malik101', '', ''),
(165, 'Pawan', 'chenu1733@rediffmail.com', 'M', 'Jaipur', '9829244220', '302021', NULL, '', 'pawan420', '', ''),
(166, 'sipuria11', 'sipuria11@gmail.com', 'M', 'Plot No 10 Shalimar Bagh Colony Chitrakut Marg Ajmer Road Jaipur Rajasthan India', '9928012610', '302021', NULL, '', 'sipuria@11', '', ''),
(167, 'Sankul Gupta ', 'sankullalgarhia@gmail.com', 'M', 'E-16/101, Panchratan apartments,  Hanuman Nagar, Vaishali Nagar, JAIPUR ', '9928246110', '302021', NULL, '', 'lalgarhia', '', ''),
(168, 'Ksp', 'kanmalparakh@gmail.com', 'M', '103 Akansha residency J58 J59 Tagore Nagar Ajmer road Jaipur Rajasthan', '9414205783', '302021', NULL, '', '1957', '', ''),
(169, 'Sneha', 'sssnehasharma009@gmail.com', 'M', 'B-27 Bhaskar enclave 2nd patrakar colony mansarovar Jaipur', '9314899179', '302020', NULL, '', '9314899179', '', ''),
(170, 'Seema', 'cmasharma97@gmail.com', 'M', 'D-29, Vaishali Nagar, Jaipur', '9784610062', '302021', NULL, '', 'sean173', '', ''),
(171, 'Jyoti Mohta ', 'jyotimohta16@gmail.com', 'M', 'D-10/72A, Chitrakoot,  Vaishali Nagar. Jaipur ', '9413337211', '302021', NULL, '', 'jyoti0311', '', ''),
(172, 'Ridhimaa gupta', 'ridhimaag392@gmail.com', 'M', '60-c jagdishpuri 200-ft bypasa ', '8741033870', '302021', NULL, '', 'rhythm1234', '', ''),
(173, 'Gaurav chaudhary ', 'gouravnitharwal@gmail.com', 'M', 'Chittrkoot ', '7427845191', '123456789', NULL, '', '1a2s3d4f', '', ''),
(174, 'Ramesh kaswan', 'rameshkaswan@gmail.com', 'M', '47 Paschim Vihar, Vaishali Nagar, jaipur, rajasthan ', '7891269958', '302021', NULL, '', 'virajsingh', '', ''),
(175, 'Ravi mathur', 'ravmathur@gmail.com', 'M', '261 gomes defence colony vaishali nagar jaipur', '9828344411', '302021', NULL, '', 'navya44411', '', ''),
(176, 'J K JAIN ', 'jkjain8001@gmail.com', 'M', '152 nemisagar colony ', '9351055600', '303021', NULL, '', 'sudha111', '', ''),
(177, 'J K JAIN ', 'jkjain8002@gmail.com', 'M', '152nemisagar colony', '9351055600', '302021', NULL, '', 'sudha111', '', ''),
(178, 'Manish', 'mani.alw25@gmail.com', 'M', '35 kailash sarovar patrakar colony mansarovar jaipur rajasthan', '9828012540', '302020', NULL, '', 'janumegha', '', ''),
(179, 'Bxhdhxhdud', 'hdhdhdh@gmail.com', 'M', '8 Aditya vihar', '9680557700', '302021', NULL, '', 'qwertyuiop', '', ''),
(180, 'Susheel ', 'gupta_susheel@rediffmail.com', 'M', '207 Guru Jambeshwar Nagar A,Queens Road,Vaishali Nagar, Jaipur ', '9461500295', '302021', NULL, '', 'susheel', '', ''),
(181, 'aagya kya', 'tomar88abhinav@gmail.com', 'M', 's1', '9571371551', '302019', NULL, '', 'cab6989', '', ''),
(182, 'deep chandra', 'deepchandra1008@yahoo.com.com', 'M', '41 shri gopal nagar meena wala naipur', '9782828288', '302012', NULL, '', 'neeru1008', '', ''),
(183, 'Ferozjpr', 'ferozjpr@yahoo.co.in', 'M', 'G-4, Park Avenue, Scheme no.8, Aditya Vihar, Gandhi Path, Vaishali Nagar, Jaipur', '9958821161', '302021', NULL, '', 'arpita12', '', ''),
(184, 'Brahm Prakash Mathur ', 'gamajaipur@gmail.com', 'M', 'E 70 Vaishali Nagar Jaipur', '9314879422', '9314879422', NULL, '', '000000', '', ''),
(185, 'Arvind Handa', 'arvindhanda1957@g.mail.com', 'M', '54, Cosmo Colony, AmraPali Marg, Jaipur-302021', '9982612488', '302021', NULL, '', 'pinky1957', '', ''),
(186, 'Rohin sharma', 'rohinsharma3155@gmail.com', 'M', 'Herapath mansarover jaipur', '9462996060', '302020', NULL, '', 'rohin3155', '', ''),
(187, 'Antik Chakraborty', 'antikchakraborty2k17@gmail.com', 'M', 'F8/48 Chitrakoot behind SBI bank', '9414824651', '302021', NULL, '', 'antikjaipur18', '', ''),
(188, 'pravin@9352', 'pravinbhati67@gmail.com', 'M', 'vt road mansarovar', '8112282005', '302020', NULL, '', 'pravinbhati', '', ''),
(189, 'vikhyat', 'vikhyatgautam1992@gmail.com', 'M', 'nareda colony jaipur', '9462418025', '302021', NULL, '', 'vikhyat15', '', ''),
(190, 'Ramsawroop', 'ramsinghjaat1212@gmail.com', 'M', 'Bad ka balaji  k pichay ward n 5 laxmangarh sikar rajasthan', '8003210041', '0041', NULL, '', 'ramsinghjaat', '', ''),
(191, 'Sitaram Jhanwar', 'srjhanwar17@hotmail.com', 'M', 'C-17 new light colony Tonk road Jaipur', '9829888819', '302015', NULL, '', 'Reset$123', '', ''),
(192, 'Gyan chand jain', 'gyanjijain524@gmail.com', 'M', '181vishwaraya nagar extensation Triveni nagar shopping center gopal pura bi pass Jaipur ', '9460318092', 'Gyan', NULL, '', 'à¤—à¥à¤¯à¤¨', '', ''),
(193, 'Ajay kumar Agarwal', 'ajaygrwl76@gmail.com', 'M', 'Flat no.201,SL-1,Income Tax Colony,Tonk Road Near Bombay Mishthan Bhandar Jaipur', '9460109525', '302018', NULL, '', 'akak*3009', '', ''),
(194, 'Aditi vijay', 'aditivijay.96@gamil.com', 'M', 'A-213 80 feet road mahesh nagar jaipur', '8561093063', '302015', NULL, '', 'aDi1996:)', '', ''),
(195, 'Aditi vijay', 'aditivijay.96@gmail.com', 'M', 'A-213 80 feet road mahesh nagar jaipur', '8561093063', '302015', NULL, '', 'adi1996', '', ''),
(196, 'Ghanshyam', 'kumawatg483@gmail.com', 'M', 'Plot no.15, Kishan marg, janakpuri-1, imali wala phatak', '9782504446', '3838', NULL, '', '9680318215', '', ''),
(197, 'pmjaipur', 'pmjaipur@gmail.com', 'M', '51, milap nagar, tonk road, jaipur', '9829012501', '302018', NULL, '', 'pinkcity', '', ''),
(198, 'Nitin kumawat ', 'nitinraj315@gmail.com', 'M', 'Sikar ', '8233840315', '181204', NULL, '', '181204', '', ''),
(199, 'rohitsharma', 'rohitsharmaravi11@gmail.com', 'M', 'nalini hospital l,gopalpura', '7023969320', '322017', NULL, '', '1234567890', '', ''),
(200, 'Asha', 'jaguumeeba0@gmail.com', 'M', 'Plot no 88 patel nagar ', '8949252592', '302915', NULL, '', 'jagriti.5', '', ''),
(201, 'Shubham', 'shub29july@gmail.com', 'M', '69, nalanda vihar, maharani farm , jaipur', '9672060495', '302018', NULL, '', 'shubham@1@1', '', ''),
(202, 'ajay saini', 'asainim71@gmail.com', 'M', 'mahesh nagar', '9782483476', '302015', NULL, '', '9782483476ajay', '', ''),
(203, 'Samit. Kumar', 'samitberla@gmail.com', 'M', '1352 barkat nagar Jaipur', '9929684683', '123', NULL, '', '9929684683', '', ''),
(204, 'HITESH Kardam ', 'dr.hiteshkardam@gmail.com', 'M', '382, Surya Nagar,  Gopal Puts By Pass,  Jaipur ', '9461235269', '302015', NULL, '', 'khanak1609', '', ''),
(205, 'Rajendra Bhandari', 'rajendrabhandari60@gmail.com', 'M', '149, Himmat Nagar, Near Gopalpua Choraha, Tonk Road, Jaipur', '9829061161', '302018', NULL, '', 'vinoba61', '', ''),
(206, 'Deepak', 'deepaknagar9950@gmail.com', 'M', 'Gems public school,jaipur', '7062403027', '302015', NULL, '', 'deepak123', '', ''),
(207, 'Manohar Bhandari', 'mlbatjaipur@gmail.com', 'M', 'SDC Roshan Residency, sahakar marg, bais godown circle, near IOC petrol pump, jaipur', '8619477988', '302005', NULL, '', 'mister1200', '', ''),
(208, 'Niranjan ', 'n_gupta06@rediffmail.com', 'M', 'Jaipur ', '9828547440', '302018', NULL, '', 'Driver@123', '', ''),
(209, 'shyamgurjar', 'shyamgurjar92@gmail.com', 'M', 'Kisan marg,tonk road', '9887030230', '302015', NULL, '', 'shyam@123', '', ''),
(210, 'deepu_1237', 'sharmadeepak8947@gmail.com', 'M', 'Krishna vihar gopalpura bypass jaipur', '7665420058', '302015', NULL, '', 'deeksha@9057', '', ''),
(211, 'Raghuveer kumawat', 'raghuveerkumawat1@gmail.com', 'M', 'A65 shiv vihar colony khatipura jaipur', '8952978393', '8890', NULL, '', 'barfi.9571577641', '', ''),
(212, 'Vasudev02', 'vstiwari3.vstiwari3@gmail.com', 'M', 'Shanti Nagar Jaipur', '7014257374', '302018', NULL, '', '9694653592', '', ''),
(213, 'Vansh', 'madansingla1911@gmail.com', 'M', '24 partap nagar jaipur', '9468881911', '302015', NULL, '', '9468881911', '', ''),
(214, 'Gopal 879', 'gopalagarwal879@gmail.com', 'M', '879,barkat nagar,kishan marg,jaipur', '9928997990', '7100', NULL, '', 'gop879', '', ''),
(215, 'Robin Gupta', 'rbgupta11@gmail.com', 'M', 'Jaipur', '9782012090', '302018', NULL, '', 'iamsmarty', '', ''),
(216, 'DILEEP', 'dileeprajgarh66@gmail.com', 'M', 'à¤¬à¤°à¤•à¤¤ à¤¨à¤—à¤° à¤œà¤¯à¤ªà¥à¤°', '9413739442', '322201', NULL, '', 'DEEP9442', '', ''),
(217, 'Jeevesh sain', 'jeeveshsain@gmail.com', 'M', 'Bassi jaipur', '8005925510', '303301', NULL, '', '8824043761', '', ''),
(218, 'Himanshu98', 'himanshuchoudhary10051998@gmail.com', 'M', '1059 barkatnagar jaipur', '9549747733', '302018', NULL, '', '10051998', '', ''),
(219, 'Aditi', 'aditi2128@gmail.com', 'M', 'P-50,madhuban west ,kissan marg,tonk road jaipur', '9929112030', '302015', NULL, '', 'virgo21', '', ''),
(220, 'Anjali vaishnav', 'anjalivaishnav1972@gmail.com', 'M', 'D-2 sarswati colony', '9414066125', '9414066125', NULL, '', 'anjali@123', '', ''),
(221, 'mpjain10858', 'mpjain10858@gmail.com', 'M', '19 mahaveer nagar 2', '9460533388', '302018', NULL, '', '9460533388', '', ''),
(222, 'Hariom', 'hariom1774@gmail.com', 'M', 'K 15, Himmat nagar,gopalpura mod,Tonk Road, jaipur', '8209941068', '302015', NULL, '', '8882', '', ''),
(223, 'Deepak ', 'deepakmundotiya10101994@gmail.com', 'M', 'Rambhag Jaipur ', '9928900633', '6890', NULL, '', 'deepak12', '', ''),
(224, 'amitmeena', 'meenaanmol3012@gmail.com', 'M', 'jaipur', '9664066766', '302018', NULL, '', 'ducati123', '', ''),
(225, 'Pawan kr prajapat', 'pawankumarprajapat033@gmail.com', 'M', 'Plot no 113 Tagore nagar kartarpura jaipur', '9799068724', '302006', NULL, '', 'pawan3719', '', ''),
(226, 'Rajendra', 'rbhandari133@gmail.com', 'M', '149, Himmat Nagar, Near Gopalpura Choraha, Tonk Road, Jaipur', '9414060288', '302018', NULL, '', 'vinoba61', '', ''),
(227, 'Deepak meena', 'deepaksirra1997@gmail.com', 'M', 'Jaipur', '7014181068', '123', NULL, '', 'deep0335', '', ''),
(228, 'Bhajjii29', 'bhajjii29@yahoo.com', 'M', '34/501,sector5 , pratap nagar', '7062662929', '2009', NULL, '', 'param2009', '', ''),
(229, 'Manish Jain ', 'manishjain_1509@yahoo.com', 'M', '14/229, Kaveri Path Mansarovar Jaipur ', '9828146301', '302020', NULL, '', 'manish@123', '', ''),
(230, 'neeraj', 'niranjansingh11223344@gmail.com', 'M', '61/15 rajat path mansarover jaipur', '7073167440', '302020', NULL, '', 'ducati123', '', ''),
(231, 'Pavitra ', 'pavitrasharma79@gmail.com', 'M', '36 everest colony Lal kothi near powerhouse gym ', '9829236880', '01412742537', NULL, '', 'pavitra123', '', ''),
(232, 'Devlux', 'dev_t2000@yahoo.com', 'M', 'Vaishali Nagar Jaipur', '9352214447', '302021', NULL, '', 'deven@13', '', ''),
(233, 'Naina', 'nainasharma296@gmail.com', 'M', '2210, mankaystha ka chowk', '9587300159', '302001', NULL, '', 'ns992900', '', ''),
(234, 'Abhishek jain', 'arhampapers@gmail.com', 'M', '282,flat no. 304,muktanand nagar,jaipur', '9414077050', '302018', NULL, '', 'nitika@2', '', ''),
(235, 'Sanjeev', 'sanjeevrerc@gmail.com', 'M', 'Jaipur', '9460759523', '302015', NULL, '', 'Driveronapp1#', '', ''),
(236, 'Arun Kumar Ajmer ', 'arunajmera29@yahoo.in', 'M', '224,Gayatri Nagar a maharani farm lane no.17.durgapura jaipur ', '7976592958', 'Jaipur302018', NULL, '', 'jaipur18', '', ''),
(237, 'Adarsh', 'adarsh51322@gmail.com', 'M', 'A 63 Shanti Niketan colony barkat nagar Jaipur', '8826249399', '302015', NULL, '', 'bookmark', '', ''),
(238, 'Arpit', 'arpitgolia@gmail.com', 'M', '33 nirmohi nagar ', '7014195508', '1989', NULL, '', 'arpit210@', '', ''),
(239, 'hemant', 'kumarhemantgoyal123@gmail.com', 'M', 'MAHESH NAGAR PHATAK, JAIPUR', '9413738079', '302015', NULL, '', 'hemanthcl12@#', '', ''),
(240, 'Ankit agarwal', 'monuagarwal009@gmail.com', 'M', 'A-202,Mahesh nagar, jaipur', '9509077091', '302015', NULL, '', 'rekhaankit', '', ''),
(241, 'Abhinay Sharma', 'abhinay1966@gmail.com', 'M', 'A 6-7, kirti nagar tonk road jaipur', '9782638955', '302018', NULL, '', 'priyank19', '', ''),
(242, 'Ananda', 'ashwanisingh250@gmal.com', 'M', 'E-5/88,chitrakoot scheme,  ajmer road,  Jaipur, Rajasthan ', '9772122211', '302021', NULL, '', 'ananda007', '', ''),
(243, 'Andy', 'iwish007@gmail.com', 'M', 'E-5/88, chitrakoot scheme,  Jaipur, rajasthan ', '9772122211', '302021', NULL, '', 'ananda007', '', ''),
(244, 'Bahadur1982', 'as074217@gmail.com', 'M', 'Vpo nangal teh. Udaipurwati dist.  Jhunjhunu', '9983199959', '1982', NULL, '', '159359', '', ''),
(245, 'Tina', 'tinakanwarsingh@gmail.com', 'M', 'Sodala jaipur', '8561804121', '302019', NULL, '', 'tina*123', '', ''),
(246, 'Shikhar', 'shikhar.kulshrestha1105@gmail.com', 'M', '177,Mahatma Gandhi Nagar, D. C. M,  Ajmer Road, Jaipur', '9680569748', '302021', NULL, '', 'radhasoami@1', '', ''),
(247, 'Shubham joshi', 'shubhamjoshi748@gmail.com', 'M', 'Payda', '8562088498', '313001', NULL, '', '8890652552', '', ''),
(248, 'Seema jain', 'seemajain6237@gmail.com', 'M', '1051 barkat nagar kisan marg jaipur', '9828996401', '302015', NULL, '', 'seemaajay', '', ''),
(249, 'Shubham saini', 'shubhamrajoriya0730@gmail.com', 'M', '21 ganpati enclave ganatpura mansovar jaipur ', '8696983923', '123r', NULL, '', 'shubham0730', '', ''),
(250, 'Dr kcbansal', 'drkcbansal25@gmail.com', 'M', '236 patrakar colony dhaulai mansarovar Jaipur', '9983761169', '302020', NULL, '', 'hardik2008', '', ''),
(251, 'Puneet Biltiwala', 'puneetbiltiwala@gmail.com', 'M', '76, Mohan Nagar, Gopalpura Byepass, Jaipur', '9540328602', '302018', NULL, '', 'PUNEET', '', ''),
(252, 'Dr Krishan Kumar Sharma ', 'drkrishanksharma@gmail.com', 'M', '83 prathviraj nagar maharani farm Durgapura jaipur ', '9414652650', '302018', NULL, '', 'rj14ch9765', '', ''),
(253, 'Nk kumawat', 'drnkkumawat@gmail.com', 'M', 'S 68 adinath nagar opp wtp jln marg jaipur', '9414717666', '302018', NULL, '', 'nkk12345', '', ''),
(254, 'Om prakesh', 'rompltg@gmail.com', 'M', '9/11 vidhyadhar nagar Jaipur', '8875681106', '302023', NULL, '', '12345op', '', ''),
(255, 'sunita', 'sohusunita5@gmail.com', 'M', 'flat no.c4,ganesh nagar near iscon temple, jaipur', '9928055779', '302020', NULL, '', 'sunitasohu', '', ''),
(256, 'Sureshkumawat', 'raj82a57p@gmail.com', 'M', 'Patrakar colony jaipur', '7742902675', '302020', NULL, '', 'kmwt', '', ''),
(257, 'drumesh1', 'drumesh1@rediffmail.com', 'M', 'Mansarovar, Jaipur', '9460034403', '302020', NULL, '', 'bruce@lee1', '', ''),
(258, 'SumitJiyani', 'kjsumit000@gmail.com', 'M', '67/21, heera path, mansarovar, jaipur', '7665917435', '302020', NULL, '', '*qwerty1347#driveronapp', '', ''),
(259, 'Anil Jain', 'anil.jain5713@gmail.com', 'M', 'Flat no 302 Plot no 13-14 Aashi Heights Beind SBI Bank Patrakar Colony Mansarovar Jaipur', '8619132624', '302020', NULL, '', 'indra1959', '', ''),
(260, 'Ankit', 'agarwalankit101@gmail.com', 'M', 'A-202,mahesh negative, Jaipur ', '9509077091', '302015', NULL, '', 'rekhankit', '', ''),
(261, 'Shailendra', 'shailendrakaushik24@gmail.com', 'M', '198 Mahaveer Nagar Maharani Farm Durgapura Jaipur', '8305283005', '302018', NULL, '', 'alb@123456', '', ''),
(262, 'Arvind Handa', 'globalconsultants_ah@yahoo.co.in', 'M', '54, Cosmo Colony, Amrapali Matg, Jaipur', '9982612488', '30201', NULL, '', 'pinky1957', '', ''),
(263, 'ksakethrao20172018', 'ksakethrao92@gmail.com', 'M', 'Sai Krupa Shanti park nallasopara West', '8169588235', '401203', NULL, '', 'Lakshmi@456#', '', ''),
(264, 'Pradeep Saini', 'pdaini1274@gmail.com', 'M', '153/3, SSM Colony, Yamunanagar', '9896549567', '135001', NULL, '', 'laxmi11274', '', ''),
(265, 'Aarti', 'aartishah09@yahoo.in', 'M', 'Hotel ronak fine dine, ramdev park road mira road east. ', '8689955733', '401107 ', NULL, '', 'janubabu', '', ''),
(266, 'Chayan', 'chayangarg98@gmail.com', 'M', 'Flat number 504 Unique Sanghi apts mahaveer nagar Jaipur', '9828213358', '302018', NULL, '', 'lawntennis', '', ''),
(267, 'sumitmathur75@gmail.com', 'sumitmathur75@gmail.com', 'M', 'S-17,Krishna Marg,Shyam Nagar,Jaipur', '9414044321', '302019', NULL, '', 'sumit@28', '', ''),
(268, 'akmittal16', 'akmittal16@yahoo.com', 'M', '731 mahaveer nagar opp ayyapa temple gopalpura mod tonk road jaipur ', '9680000040', '302018 ', NULL, '', 'ankur290984', '', ''),
(269, 'Amit', 'amitsharma1487@gmail.com', 'M', 'F-58 Sumer nagar extn. F-Block Mansarovar Jaipur', '9602353270', '302029', NULL, '', '22866322', '', ''),
(270, 'ASHISH', 'malikashishjaipur@gmail.com', 'M', 'Shanti path,Jaipur', '9414323989', '302004', NULL, '', 'giridhar', '', ''),
(271, 'Arushi', 'bhumi.gupya07@gmail.com', 'M', '21, Ganesh colony near rural police line amer road jaipur', '8094123426', '302001', NULL, '', 'Arushi@1234', '', ''),
(272, 'Arushi', 'bhumi.gupta07@gmail.com', 'M', '21 Ganesh colony near rural police line amer road jaipur', '8094123426', '302001', NULL, '', 'Arushi1234', '', ''),
(273, 'Ranu joshi', 'joshi.ranu27@gmail.com', 'M', '115 champa nagar', '7891426881', 'Virendra', NULL, '', 'ranu@123', '', ''),
(274, 'Harsha', 'hridayesh.kaushik@gmail.com', 'M', 'Mansarovar jaipur', '9461628777', '302020', NULL, '', '123456', '', ''),
(275, 'Himanshu aggarwal', 'himanshu200915@gmail.com', 'M', 'Wz207d gali no 16 Sadh Nagar palam', '9250523937', '110045', NULL, '', '4135#Sonu', '', ''),
(276, 'Arvind Handa', 'arvindhanda1957@gmail.com', 'M', '54, Cosmo Colony, Amrapali Marg, Jaipur', '9982612488', '302021', NULL, '', 'pinky1957', '', ''),
(277, 'Suresh mathur', 'sb.shreejee@gmail.com', 'M', '290 mahaveer nagar 2,maharani farm,durgapura,jaipur', '8949373235', '302018', NULL, '', 'suresh', '', ''),
(278, 'Praveen1963', 'pratibha.praveentak@gmail.com', 'M', 'T9, flat no-703, blue ridge, Hinjwadi', '9414613748', '411057', NULL, '', 'pratibha1966', '', ''),
(279, 'Rav virender singh', 'ravchoudhary56@gmail.com', 'M', 'B 135 modal town jaipur', '8696052778', '7766', NULL, '', '9017173872', '', ''),
(280, 'Male', 'obaidwanio9@gmail.com', 'M', 'Wani dorsa ', '7006080229', '8082', NULL, '', '8082', '', ''),
(281, 'Tanuj', 'tanumathur5@gmail.com', 'M', 'Mahima Panorama', '7568705588', '302017', NULL, '', 'tanumathur5', '', ''),
(282, 'asomani', 'adityajpr@yahoo.com', 'M', '125/126, Queens Road, Jaipur', '9414072020', '302021', NULL, '', '090854', '', ''),
(283, 'Kamal', 'kamalkbhagani302004@gmail.com', 'M', '272 sindhi coloni adarsh nagar Jaipur', '9521566768', '302004', NULL, '', '7619794772', '', ''),
(284, 'Mukesh', 'in.mukeshsaini@gmail.com', 'M', 'Makrana', '9024051135', '341505', NULL, '', 'tm123456', '', ''),
(285, 'Divya saxena', 'dabbu5444@gmail.com', 'M', '544 hari bhau upadhaya nagar ajmer', '7023468698', '305001', NULL, '', '9462135448', '', ''),
(286, 'Ramprakash saxena', 'rpsaxena544@gmail.com', 'M', '544 hari bhau upadhaya nagar ajmer', '9414327097', '305001', NULL, '', 'liva574', '', ''),
(287, 'Parveen Khan ', 'parveenkhan26366@gmail.com', 'M', 'K-5 green Park House no 81 khati pura Road Vaishali nagar jaipur near sankalp tower ', '9602957124', '302021', NULL, '', 'Parveen#123', '', ''),
(288, 'Tusharchop03', 'tusharchop03@gmail.com', 'M', '714,New RMO hostel,sion', '9561844723', '400022', NULL, '', 'trooper@10', '', ''),
(289, 'vhmanglani', 'vhmanglani@yahoo.com', 'M', 'Malviya Nagar', '7568010010', '302017', NULL, '', 'narbutta', '', ''),
(290, 'Arvind sharma', 'arvind.call@gmail.com', 'M', 'Vinoba vihar malviya nagar', '9414076978', '302017', NULL, '', 'safedrive', '', ''),
(291, 'Vattu', 'vatsal.mithal@gmail.com', 'M', '10/986 malviya nagar naipur 302017', '9785058653', '302017', NULL, '', 'vattu1709', '', ''),
(292, 'Mahen parihar', 'mahenparihar69@gmail.com', 'M', 'Malviya nagar', '9782151294', '302017', NULL, '', 'parihar2810', '', ''),
(293, 'Peeyush Sharma', 'peeyushsharma123@gmail.com', 'M', 'Plot No. 48, Sitavihar Colony, Niwaru Road, Jhotwara, Jaipur', '9928883310', '302012', NULL, '', 'trisha@786', '', ''),
(294, 'jatinsinghnirwan844@gmail.com ', 'jatinsinghnirwan844@gmail.com', 'M', 'sunrise City ', '9166544502', '55757', NULL, '', '7793033995', '', ''),
(295, 'Dheeraj', 'bdheeraj51@yahoo.com', 'M', '14/186, Neeti nagar girdhar marg, malviya nagar, Jaipur', '8696909700', '302017', NULL, '', 'Tuna##007', '', ''),
(296, 'ajay', 'ajaysinghparmarap1727@gmail.com', 'M', 'niwaru road jhotwara', '7742657573', '302012', NULL, '', '7742657573', '', ''),
(297, 'Pradeep Saxena', 'pksaxena11121959@gmail.com', 'M', '3/293 Malviya Nagar Jaipur', '9413764620', '302017', NULL, '', 'aradhna21', '', ''),
(298, 'Amit jain', 'amitjain2341146@gmail.com', 'M', '23 nemisagar colony vaishali nagar Jaipur', '9829073904', '303021', NULL, '', '9829073904', '', ''),
(299, 'Govind singh', 'gsrajput7848@gmail.com', 'M', 'Jaipur', '8949719134', '302020', NULL, '', '7690892712', '', ''),
(300, 'lavish rawat', 'lavishrawat00@gmail.com', 'M', '224 om shiv colony jhotwara jaipur ', '8619685054', '302012', NULL, '', 'lavish123@', '', ''),
(301, 'Naresh', 'nareshgupta64@yahoo.co.in', 'M', 'E 135 Sector 14, Malviya Nagar, lane opposite ghiya hospital  Jaipur', '8209981536', '302017', NULL, '', 'naresh3976', '', ''),
(302, '120653', 'Gyanendrajadon49@gmail.com', 'M', 'Jhotwara niwaru', '9588228676', '3040', NULL, '', '7568977698', '', ''),
(303, 'Vikashalok', 'vikashkumar1985@hotmail.com', 'M', 'Malviya Nagar, Jaipur', '8003191403', '302017', NULL, '', 'Aayush@123', '', ''),
(304, 'Rupesh Sharma ', 'rupeshsharma1988@gmail.com', 'M', 'Plot no. 74 Sector-1, new vidyadhar nagar, jaipur', '9636961030', '302039', NULL, '', 'nidhirupesh', '', ''),
(305, 'Rajnikoolwal', 'rajnikoolwal@gmail.com', 'M', 'Plot 104 vikas nagar murlipur school sikar road Jaipur', '7737282034', '302013', NULL, '', 'rajni1983', '', ''),
(306, 'Ashwani ', 'akjalewa@gmail.com', 'M', 'Shivshakti Paradise, Central Spine, Vidyadhar nagar, Jaipur ', '9829402610', '302039', NULL, '', 'sharmila', '', ''),
(307, 'Sher singh mahla', 'shersinghmahla1@gmail.com', 'M', 'Plot no S - 10 A Ambabari Jaipur', '9829369111', '302039', NULL, '', '11july1982', '', ''),
(308, 'Abhishek tinker', 'abhishektinker11@gmail.com', 'M', 'D429 sector8 vidhyadhar nagar jaipur', '9664112047', '302039', NULL, '', 'abhishek', '', ''),
(309, 'Prahlad ', 'singhprahalad42@gmail.com', 'M', 'E.40 vijay nagar murlipura jaipur rajasthan ', '9352910002', '302013', NULL, '', '9352910002', '', ''),
(310, '', '', 'M', '', '', '', NULL, '', 'rinkus@623', '', ''),
(323, 'Abhishekvyas', 'abhi.vyas.50746444@gmail.com', 'M', 'Vidhyadhar nagar jaipur', '7297049001', '302012', NULL, '', 'Fanyfind1', '', ''),
(311, 'Meenu Gupta', 'menugupta501@gmail.com', 'M', 'K 5253 Shree Shyam residency Bhawani nagar Sikar road Jaipur', '6375725288', '302023', NULL, '', 'vedant', '', ''),
(312, 'Parineeta bothra ', 'Parineeta2211@hotmail.com', 'M', 'Plot no 247 sec 2 vidhyadhar Nagar jaipur 302039 ', '9057510507', '302039 ', NULL, '', 'pb123456789', '', ''),
(313, 'Amit Sharma', 'amit.as903@gmail.com', 'M', 'Bhawani Nagar, Jaipur ', '9929986443', '302039', NULL, '', 'amit4423', '', ''),
(314, 'Chiragbadaya ', 'chiragbadaya@gmail.com', 'M', 'B-17, metal colony, behind hotel paradise, Ambabari,  Jaipur ', '9828099774', '302016', NULL, '', 'CHIRAG11', '', ''),
(315, 'Saraswatpn', 'saraswatpn@gmail.com', 'M', '4/107Vidyadharnagar Jaipur', '8619984019', '302039', NULL, '', '#yugs1424', '', ''),
(316, 'à¤®à¥à¤•à¥‡à¤¶ à¤•à¥à¤®à¤¾à¤° à¤šà¥Œà¤§à¤°à¥€', 'me.mukeshjat@gmail.com', 'M', 'à¤ªà¤¹à¤²à¤¾ à¤µà¤¾à¤²à¤¾ à¤œà¤¾à¤Ÿà¤¾à¤¨ à¤¤à¤¹à¤¸à¥€à¤² à¤¬à¤¸à¥à¤¸à¥€ à¤œà¤¿à¤²à¤¾ à¤œà¤¯à¤ªà¥à¤°', '9828475800', 'Driveronapp', NULL, '', '9549888809', '', ''),
(317, 'Govindkoolwal', 'Koolwalgovind8@gmail.co', 'M', 'A. 38.rajdhani anajmandi sikar road. Jaipur ', '9314513163', '302013', NULL, '', 'govind1981', '', ''),
(318, 'Ankit bajargan', 'ankitbajar007@gmail.com', 'M', 'B-8,sugan vihar,awho apartment,sector-2,vidhyadhar nagar', '9772973344', '302039', NULL, '', '9772973344', '', ''),
(319, 'gopalsgahlot', 'gopalsgahlot@gmail.com', 'M', '1, Ashok Nagar, Niwaru Road, Jhotwara, Jaipur', '9414234865', '302012', NULL, '', 'Runjun#2006', '', ''),
(320, 'Banwari lal sharma', 'bls.kolkata@yahoo.co.in', 'M', 'Corporate bhawan 22 godam', '9461151757', '302001', NULL, '', 'mca@1234', '', ''),
(321, 'mikhil.90', 'advocate.mikhilgarg@gmail.com', 'M', 'sikar road, jaipur', '9549922200', '302039', NULL, '', '12345678', '', ''),
(322, 'Jitesh', 'jdhingra85@gmail.com', 'M', '4/111 vidyadhar nagar Jaipur', '7014260271', '302004', NULL, '', '17051998', '', ''),
(324, 'Samagya sharma', 'samagya0407@gmail.com', 'M', 'A-301 kardhani kalwar road near Jaipur pet hospital', '9079746132', '302012', NULL, '', 'vibgyor7', '', ''),
(325, 'Amit Jain ', 'amit_ipjain@yahoo.co.in', 'M', '67/54 mansarover Jaipur ', '9828600500', '302020', NULL, '', 'chiyajain', '', ''),
(326, 'IP Jain ', 'indraprakash@gmail.com', 'M', '67/54 Mansarover Jaipur ', '9829210471', '302020', NULL, '', 'amitjain', '', ''),
(327, 'Kanchan Agarwal', 'tanuagarwal6555@gmail.com', 'M', '9/133 malviy nagar jaipur', '9983582496', '302017', NULL, '', 'Tanu@12345', '', ''),
(328, 'Manish', 'manishkumar97721@gmail.com', 'M', 'F 16 sumer nagar ext behind cheelgadi restaurant Mansarovar jaipur', '9588969683', '302001', NULL, '', 'manishdivya', '', ''),
(329, 'Gopal Sharma', 'gopalsharmapnb@gmail.com', 'M', 'Flat No 104,shree enclave,SNG GROUP,Nivaru road,In front of Ganga marriage garden', '7096508715', 'saket', NULL, '', 'gvs12345', '', ''),
(330, 'Surendra', 'shekhawat.1@email.com', 'M', 'Vidyadharnagar', '9828409640', '302039', NULL, '', 'ehcc@123', '', ''),
(331, 'Meghna Mittal', 'meghna1641@gmail.com', 'M', 'A-561, Govind Marg, Malviya Nagar, Jaipur', '8005952914', '302017', NULL, '', '99dinesh', '', ''),
(332, 'Manoj Gupta', 'manojgupta2311@gmail.com', 'M', '66/81 Heera Path Mansarovar Jaipur', '8209714910', '302020', NULL, '', 'afnet@123', '', ''),
(333, 'Vimal Kumar Nawal', 'vimal_nawal@rediffmail.com', 'M', '73/52, Param Hans marg, Mansarovar, Jaipur', '9680158060', '302020', NULL, '', 'vknawal', '', ''),
(334, 'Shahid Sheikh', 'shahidalishekh332@gmail.com', 'M', 'Mansrovar Jaipur ', '7023506085', '302020', NULL, '', '002660', '', ''),
(335, 'GS JINGAR', 'gspjingar@gmail.com', 'M', '60/118  RAJAT PATH BEHIND SAINT ANSELMS SCHOOL MANSAROVAR JAIPUR', '9414262244', '302020', NULL, '', 'gsp94142', '', ''),
(336, 'Preet mishra', 'papabdjd864@gmail.com', 'M', 'Swarn path mansarover jaipur', '7014666291', '302020', NULL, '', '9782853449a', '', ''),
(337, 'Jitendra Dave', 'jitendradave@gmail.com', 'M', '53/28, Saryu Marg, V T Road, Mansarovar, Jaipur', '9829010364', '302020', NULL, '', 'dave2807', '', ''),
(338, 'suveen', 'suveen.agarwal@gmail.com', 'M', '52/14 Shipra path , Mansarovar, Jaipur', '9829530550', '302020', NULL, '', 'ssdn1008', '', ''),
(339, 'rakesh khatri', 'rakesh12055@gmail.com', 'M', '104/94 vijay path mamsarover', '9829475935', '302020', NULL, '', '9829475935', '', ''),
(340, 'Sanju sen', 'sanjusen6547@gmail.com', 'M', '38/373,mansarovar Rajth path,Jaipur', '9571793029', '302015', NULL, '', 'sanjusen9521845254', '', ''),
(341, 'swati saxena', 'swaticomputers01@gmail.com', 'M', 'Bhrigu apartment, bhrigu path, mansarovar, jaipur', '9829440773', '302020', NULL, '', 'saxena2019', '', ''),
(342, 'Uttam', 'uttamsharma668@gmail.com', 'M', '52/14 Aanand Shree Marg Shipra path mansarovar Jaipur', '9057886804', '302020', NULL, '', 'uttamsharma', '', ''),
(343, 'Rahul ', 'tamolirahulom@gmail.com', 'M', 'Flat number 104 utsav apartment Vidhaydhar Nagar Jaipur ', '8209419752', '302039', NULL, '', 'rt1985', '', ''),
(344, 'Girdhar goyal', 'giradhargoyal@gmail.com', 'M', '53/92 mansarovar jaipur', '9414235414', '302020', NULL, '', 'pari2007', '', ''),
(345, 'rakesh khatri', 'dhawal312@gmail.com', 'M', '104/94 vijay path mansarover jaipur', '9829475935', '302020', NULL, '', '9829475935', '', ''),
(346, 'HARSHVARDHAN GURJAR ', 'harshvardhang21@gmail.com', 'M', '69/285, Ward 27, sector 6, VT choraha, mansarover,  Jaipur 322020', '7062749202', 'Harsh1210', NULL, '', 'harsh1210', '', ''),
(347, 'Siddharth ', 'shsharma1507o@gmail.com', 'M', '124/70 Agarwal Farm Mansarovar Jaipur ', '8209845013', '302020', NULL, '', 'skgautam', '', ''),
(348, 'Ayush', 'ayushswami3@gmail.com', 'M', 'Vinayak path', '9057555981', '302020', NULL, '', '123456789', '', ''),
(349, 'Ramkeshmeena', 'ramkeshmeena09061994@gmail.com', 'M', 'Jaipur', '9929765545', 'Meena56', NULL, '', '9929765545', '', ''),
(350, 'Sourabh', 'sourabhkhetan302020@gmail.com', 'M', '12/3 kaveri path mansarovar', '7976297425', '1234', NULL, '', 'sourabh2019', '', ''),
(351, 'Mohan Lal Balani ', 'mlbalan1954@gmail.com', 'M', '120/5 Vijay Path Mansarovar Jaipur ', '9636052945', '302020', NULL, '', '9636052945', '', ''),
(352, 'Prakhar28', 'pushkar280394@gmail.com', 'M', '72/127 Patel marg, mansarovar, jaipur', '8233106170', '302020', NULL, '', '8233106170', '', ''),
(353, 'Nagesh', 'n26_1956@yahoo.co.in', 'M', '82/107mansarower jaipur', '9414025628', '302020', NULL, '', 'nagesh@26', '', ''),
(354, 'pradhuman nepalia', 'pradhumannepalia0905@gmail.com', 'M', '92/21durga path, patel marg, mansarovar,jaipur.', '8764181611', '302020', NULL, '', 'pradhuman@0905', '', ''),
(355, 'Subhash Chandra Yadav', 'scyadav555@gmail.com', 'M', '78/2, Arawali Marg, Shipra Path , Mansarovar , Jaipur', '9982221822', '302020', NULL, '', '5522s5522', '', ''),
(356, 'Sudarshan', 'sudarshansaini780@gmail.com', 'M', 'Jaipur', '6350013661', '303325', NULL, '', '6350013661', '', ''),
(357, 'Suresh Gupta', 'guptas1961@rediffmail.com', 'M', '63/86,Heera Path, Madhyam, Marg, Mansarover, Jaipur', '9352822661', '302020', NULL, '', '9352822661', '', ''),
(358, 'Sanjeev', 'sanjeevchhabra65@gmail.com', 'M', '124/412 Agrawal Farm, Mansarovar, Jaipur ', '9829261323', '302020', NULL, '', 'driver3162', '', ''),
(359, 'Ashok kimar jain', 'ashokkumarjain70@gmail.com', 'M', '73/176, mansarovar jaipur', '9460710390', '302020', NULL, '', '1234', '', ''),
(360, 'Yogesh', 'yogeshmanghwani.182001@gmail.com', 'M', '104/42 vijaypath mansarovar jaipur', '7073571274', '302020', NULL, '', 'Mummylove', '', ''),
(361, 'Himanshu jain', 'jain.himanshu4@gmail.com', 'M', '112/183, agarwal farm jaipur', '9929290799', '302020', NULL, '', 'hima0799', '', ''),
(362, 'akshay', 'akshay00711@gmail.com', 'M', 'Jhotwara jaipur', '9680049417', '302012', NULL, '', '1234567890', '', ''),
(363, 'Kalpana', 'kalpanavaibhav08@gmail.com', 'M', '71/305 Patel Marg Mansarovar Jaipur', '8560011555', '1234', NULL, '', 'k85600', '', ''),
(364, 'Kalakesh', 'kalakeshpatel@gmail.com', 'M', '54,silicon town, near by tech mahendra silicon town, Electronic city bengaluru karnataka 560100', '9071236299', '560100', NULL, '', 'kalakesh', '', ''),
(365, 'Sunil', 'sk7305544@gmail.com', 'M', 'Jhotwara Jaipur', '7734945997', '302012', NULL, '', '7737722222', '', ''),
(366, 'Sunil Dutt Arya', 'sunildarya@gmail.com', 'M', '94/138Mansarovar Jaipur Rajasthan', '9414280355', '302020', NULL, '', 'vinilokesh2011', '', '');
INSERT INTO `client` (`id`, `name`, `email_id`, `gender`, `address`, `mobile_no`, `zip_code`, `profile_img`, `auth_id`, `auth_pswrd`, `clientLat`, `clientLng`) VALUES
(367, 'Ramnaresh jangid', 'ramnareshjangid6@gmail.com', 'M', 'JAIPUR ', '9660347650', '302020', NULL, '', 'tiger@88999', '', ''),
(368, 'Antony simson ', 'simsonselvaraj199594s@gmail.com', 'M', 'kannikapuri, mookkaiyur-po, kadaladi-tk, ramanathapuram-dt, ', '8189958828', '623120 ', NULL, '', '2233445$', '', ''),
(369, 'Ashish Gangwal ', 'prabhuashish071981@gmail.com', 'M', '92/19, Durga Path Mansarovar Jaipur-302020 ', '8209077148', '302020', NULL, '', 'ash@071981', '', ''),
(370, 'Ashish agarwal', 'bajrangfurnishing@gmail.com', 'M', '21/282 madhyam marg kaveri path mansarovar jaipur', '9024260738', '302020', NULL, '', '01412390368', '', ''),
(371, 'Beer Singh', 'disodia1969@gmail.com', 'M', '48 KESHAV NAGAR civil line jaipur.', '7984176848', '302006', NULL, '', 'sahil@183', '', ''),
(372, 'Prakash ', 'psingh8680@gmail.com', 'M', 'Mansrover jaipur', '8875868580', '321605', NULL, '', 'ps8875868580', '', ''),
(373, 'Abhishek  Sharma ', 'osheenboutique9@gmail.com', 'M', '41/37 veena  Kunj, 1st floor, varun path,near police station, varun Park, Mansarover, jaipur. ', '9460380945', '302020', NULL, '', 'pooja11', '', ''),
(374, 'Akshay jain', 'akshayjain826@gmail.com', 'M', '71/61 paramhans marg near Mansarovar plazza Jaipur', '8619145155', '302020', NULL, '', '008emtec', '', ''),
(375, 'Ghan shyam', 'neetughan786@gmail.com', 'M', 'D-270 murlpura scheme Jaipur', '9928471615', '302039', NULL, '', 'vaibhavji', '', ''),
(376, 'Surendra Kumar Bhambhani', 'bhambhanisk@gmail.com', 'M', '73/32 Paramhans Marg Mansarover Jaipur', '9829077860', '302020', NULL, '', '03021958Surendra', '', ''),
(377, 'dinesh sharma', 'dinesh_balesara@yahoo.co.in', 'M', '112,patel nager,kalyanpura,mansarover,jaipur', '9414038005', '302020', NULL, '', 'loveurmil143', '', ''),
(378, 'Ramesh Kumar Lalwani', 'ramesh.lalwani@sbi.co.in', 'M', 'House No. H 3, Palm Groves Apartment, Chitranjan Marg, C Scheme, Jaipur', '9717233550', '302001', NULL, '', 'sunita1969#', '', ''),
(379, 'Sunita chaudhary', 'sunitachaudhary75@gmail.com', 'M', '83/1nilgiri marg mansarover', '9782808687', '302020', NULL, '', 's4121975', '', ''),
(380, 'sharad1105', 'sharadgarg1105@gmail.com', 'M', 'S-23,24, kirti nagar, tonk road, jaipur', '7877785133', '302018', NULL, '', 'sharad1105', '', ''),
(381, 'Govind123', 'govinddaphal@gmail.com', 'M', 'Pune Sadashiv peth ', '9326495073', '411011', NULL, '', 'swara7712', '', ''),
(382, 'Hitendra Gupta', 'hitendra_gupta@rediffmail.com', 'M', '90 B Gayatri Nagar B Maharani Farm Durgapura Jaipur ', '9314901979', '302018', NULL, '', 'ejgsndgv', '', ''),
(383, 'Bharat Bhargava ', 'bharatbhargava1965@yahoo.in', 'M', 'B 140 Siddhartha Nagar behind jhanwar circle terminal 2 road jagt pura Jaipur ', '9829056586', '302017', NULL, '', '3008', '', ''),
(384, 'Ritik keswani', 'ritikkeswani22@gmail.com', 'M', '45/19 kiran path mansarovar jaipur', '7424876432', '302020', NULL, '', 'nik@1122', '', ''),
(385, 'Vinod kumar', 'vsahu9924@gmail.com', 'M', 'P no. 36 nilkanth vihar b chopra bhawan ', '8005973717', '302021', NULL, '', '9983276130', '', ''),
(386, 'Ravi Soni', 'ravisoni3103@gmail.com', 'M', 'Hhbbb', '7300000293', 'Hbbbb', NULL, '', 'ravisoni.', '', ''),
(387, 'Dinesh Mittal', 'mittal2607@rediffmail.com', 'M', '106/89, Vijay Path Mansarovar Jaipur', '8696924214', '302020', NULL, '', '$ganesh0804$', '', ''),
(388, 'Jitndear Raghav', 'ashavari13@gmail.com', 'M', 'Alwar', '9772177097', '301030', NULL, '', 'A9772177097', '', ''),
(389, 'Vikram', 'vicky.smarthome@gmail.com', 'M', 'A-414,malviya nagar', '9414020796', '302017', NULL, '', '1869', '', ''),
(390, 'Prateekkhublani', 'prateek.khublani@gmail.com', 'M', 'E 19 pradhan marg moji colony malviya nagar jaipur ', '9769665603', '302017', NULL, '', '7colours', '', ''),
(391, 'JITNDEAR RAGHAV', 'ashavri13@gmail.com', 'M', 'Alwar mia', '9887957790', '301030', NULL, '', 'A9772177097', '', ''),
(392, 'NEERAJ ', 'neeraj.6113@gmail.com', 'M', '260, vasundhara colony, street of big bazar, gopal pura bypass, tonk road, jaipur', '9829139519', '302018', NULL, '', 'mahabali.2', '', ''),
(393, 'Ajit meena', 'ajitmeena786@gmail.com', 'M', 'Patarkar colony ', '9799508797', '302020', NULL, '', '9799508797', '', ''),
(394, 'Bahadur Singh', 'b.singh@gmail.com', 'M', '40/150 Swarn Path Mansarovar Jaipur', '9829316094', '302020', NULL, '', 'JPR15008', '', ''),
(395, 'BAHADUR SINGH', 'b.singh1946@gmail.com', 'M', '40/150,Swarn Path,Mansarovar,Jaipur', '9829316094', '302020', NULL, '', 'JPR15008', '', ''),
(396, 'Geetanjali singh', 'geetanjalisingh18088@gmail.com', 'M', 'A 111 Tara Nagar Jhotwara Jaipur 12', '6377832312', '302012', NULL, '', 'pdsingh18088', '', ''),
(397, 'Shaikh Asif', 'shaikhasif.salim1@gmail.com', 'M', 'Mumbra', '8169756425', '400612', NULL, '', 'Mumbra400612', '', ''),
(398, 'Mudit jain', 'mudit.jain879@gmail.com', 'M', '79b model town new sanganer mansarovar', '9928863263', '302020', NULL, '', 'shalini10', '', ''),
(399, 'Arjun', 'mahaveerbuildteck@gmail.com', 'M', 'Mahaveer nagar', '9887379523', '302020', NULL, '', '9887379523', '', ''),
(400, 'Hiteshtewani', 'hiteshtewani249@gmail.com', 'M', '124/41 thadi market ', '9529099049', '302020', NULL, '', 'Hitesh85', '', ''),
(401, 'Rohit', 'Rohitpancholi97@gmail.com', 'M', 'Anantpura,jaitpura,chomu,jaipur', '9660347411', '303704', NULL, '', 'Rohit1234', '', ''),
(402, 'Saravanan', 'saravanan26055@gmail.com', 'M', 'Ambattur, chennai', '8754514295', '600053', NULL, '', 'sarav26055', '', ''),
(403, 'Vinod pokale', 'vinodp6075@gmail.com', 'M', 'Sr .no 47 jijau nagar Dhayari', '7020819109', '6162', NULL, '', '', '', ''),
(404, 'Gaurav parashar', 'g.parashar151@gmail.com', 'M', 'Mansarovar', '9782154067', '302020', NULL, '', 'gaurav123', '', ''),
(405, 'Prakash ', 'paliwalprakash45@gmail.com', 'M', 'Mansarovar Jaipur ', '9887051543', '302020', NULL, '', 'jaipur2019', '', ''),
(406, 'Riyu1309', 'gkgupta754@gmail.com', 'M', 'Komal paradise', '9460945003', '302020', NULL, '', 'gunu15!#', '', ''),
(407, 'Neelesh Singhal', 'neelesh.singhal29@gmail.com', 'M', 'Jagatpura', '9928993700', '91', NULL, '', 'Neelesh', '', ''),
(408, 'rajesh', 'manitatu2331@gmail.com', 'M', 'jaipur', '7734017825', 'abhay1993', NULL, '', 'manisha', '', ''),
(409, 'Jain1990', 'tarunkantluhadia@gmail.com', 'M', '43 shilp colony khatipura road jhotwara jaipur', '9799040000', '302012', NULL, '', 'Tarun@1234', '', ''),
(410, 'Mahender charan', 'mahendercharan21@gmail.com', 'M', 'Shiv nagar soc bhestan surat', '9909350841', '394210', NULL, '', 'mssa8866', '', ''),
(411, 'Raja', 'alli.raja@gmail.com', 'M', 'Hyderabad ', '8886999469', '500054', NULL, '', 'ravikiran01', '', ''),
(412, 'abs', 'aysays2268@gmail.com', 'M', 'kuniyamuthur', '8667272240', '641008', NULL, '', '22682268', '', ''),
(413, 'Jhajha1234', 'arihantsell@gmail.com', 'M', 'Madipur delhi ', '9810222036', '110063', NULL, '', '123456', '', ''),
(414, 'R. S. Parwal', 'radheyshyamparwal@gmail.com', 'M', 'Parwal Vila, D - 62,  Vaishali Nagar D Block, Jaipur', '9414061636', '1234', NULL, '', 'ganeshji', '', ''),
(415, 'Mahipal', 'maahirathore199@gmail.com', 'M', 'Khirni phatak', '8104200634', 'Maahi81', NULL, '', 'maahi81', '', ''),
(416, 'UN chaturvedi', 'unchaturvedi1953@gmail.com', 'M', '6/262, kabir marg, vidhyadhar nagar, near gail vihar, jaipur', '9414247247', '302039', NULL, '', '9414714421', '', ''),
(417, 'Shraddha Chaturvedi', 'jp.shraddha@gmail.com', 'M', '6/262, kabir marg, vidhyadhar nagar, near gail vihar, jaipur', '9829550730', '302039', NULL, '', 'God12680', '', ''),
(418, 'Himanshu arora', 'himarora1234@gmail.com', 'M', 'Mansrowar', '8112276345', '302020', NULL, '', '7725959366', '', ''),
(419, 'sanarth', 'sam13202jain@gmail.com', 'M', '120/121 Vijay Path Mansarovar Jaipur ', '6375510049', '302020', NULL, '', 'driveronapp', '', ''),
(420, 'Ankur Tripathi ', 'ankur.tripathi@gmail.com', 'M', 'JAIPUR', '9833725036', '302020', NULL, '', 'dopa2805', '', ''),
(421, 'Manoj Jain', 'manojjainkathmandu@gmail.com', 'M', '120/121 Vijay Path Mansarovar Jaipur', '9414362756', '302020', NULL, '', 'driveronapp', '', ''),
(422, 'K thakur ', 'kthakur720@gmail.com', 'M', 'Kamothe Navi Mumbai ', '9323694574', '410209', NULL, '', 'thakur', '', ''),
(423, 'Balaji', 'balajirajinikanth@gmail.com', 'M', '259, Narayana Pillai Street, Shivajinagar, Bangalore', '7411989898', '560001', NULL, '', 'Balajianupama1980@', '', ''),
(424, 'pallavmakwana', 'makwanapallav@gmail.vom', 'M', '239, Vasundhra Colony, Opp Ram Mandir, Tonk Road, Jaipur', '9829078467', '302015', NULL, '', 'kamal1972', '', ''),
(425, 'Premnath.R', 'premdurga12345@gmail.com', 'M', '9.thalampoo st,sri ramnagar,sammattipuram,madurai.', '6379403028', '4082', NULL, '', '9994422962', '', ''),
(426, 'abhishekgodara785', 'abhishekgodara785@gmail.com', 'M', 'Mansarover,jaipur', '7014537152', '302020', NULL, '', 'Godaraji1', '', ''),
(427, 'Mahendra saini', 'mahendraboss786@gmail.com', 'M', 'F6a deepak watika, kartarpura, jaipur', '9309243288', '302006', NULL, '', 'poonammahi', '', ''),
(428, 'pallavmakwana', 'makwanapallav@gmail.com', 'M', '239, Vasundhra Colony, Tonk Road, Jaipur', '9829078467', '302015', NULL, '', 'kamal1972', '', ''),
(429, 'Gaurav Devnani', 'lajpatraidevnani64@gmail.com', 'M', 'Villa no -43 , Manglam Arpan, near patrakar colony, mansarovar, jaipur, rajasthan', '9351280746', '302020', NULL, '', 'rajudevnani1', '', ''),
(430, 'Eustace', 'eustacebothello@gmail.com', 'M', 'Ganga Jamuna socity nl2 bldg no11 room no A7 sector 15 Nerul (E) Navi Mumbai.', '9082624540', '400706', NULL, '', '8652588450', '', ''),
(431, 'Gursevek Singh', 'gurseveksynovia1989@gmail.com', 'M', '72/192, Patel Marg, Mansarovar, Jaipur-302020', '9950207388', '2081', NULL, '', '00002081', '', ''),
(432, 'Dr Shrivastava', 'ompaingo@gmail.com', 'M', '9/37 Chittrakoot jaipur', '9828150327', '302021', NULL, '', '432gharkota432', '', ''),
(433, 'Suresh kumawat', 'suresh.kumawat@heifer.org', 'M', 'D84, gautam marg, nirman Nagar, Jaipur ', '7742902675', '302020', NULL, '', '123', '', ''),
(434, 'Anuj Sharma', 'anujs118@gmail.com', 'M', '123 panchsheel enclave durgapura Jaipur', '9828633555', '302018', NULL, '', '9828633555', '', ''),
(435, 'Rekha routray', 'routray10feb@yahoo.co.in', 'M', '69/254 vt road mansarovar jaipur', '9024398897', '302020', NULL, '', 'drnroutray', '', ''),
(436, 'Sameer Agarwal', 'sameer15041974@gmail.com', 'M', '69/204 v.t. road Mansarovar Jaipur', '9351671146', '302020', NULL, '', '15041974', '', ''),
(437, 'Manoj jain', 'jain.manoj.bt@gmail.com', 'M', 'Kaveri path mansarovar jaipur', '9462867745', '302020', NULL, '', '9460737506', '', ''),
(438, 'nand', 'nk@gmail.com', 'M', 'jaipur', '7891171378', '302020', NULL, '', '111', '', ''),
(439, 'Arun Gupta ', 'aarun1809@gmail.com', 'M', '54 Sidhrarth Enclave Ashram Delhi -110014', '9873336065', '110014', NULL, '', 'aarun1809', '', ''),
(507, 'Rohin pancholi', 'rohinpancholi@gmail.com', '', 'Mansarovar', '9462996060', '302020', NULL, '', 'rohin@0055', '', ''),
(440, 'Bhupendra singh', 'bhuppyrathore65@gmail.com', '', '50/29 meena colony bai ji ki kothi jhalana dungri jaipur', '9928123325', '302004', NULL, '', '9680409220', '', ''),
(441, 'Kabiraah_', 'sumitkapoor616@gmail.com', '', 'Chitrakoot Vaishali nagar', '9672119445', '334001', NULL, '', 'kabir0161', '', ''),
(442, 'ABHISHEK', 'abhishekssis89@gmail.com', '', '107 hanumanth tower central spine vidharnager Jaipur  ', '9928362648', '12345', NULL, '', '12345', '', ''),
(443, 'Ujagarsingh', 'ujagar1234@gmail.com', 'M', 'Jaipur', '9828784536', '302033', NULL, '', '1234', '', ''),
(444, 'Praveenkumar ', 'praveenpraveen8031@gmail.com', '', 'Bangalore Whitefield near Whitefield global school ', '9741250412', '560067', NULL, '', 'praveenkumar', '', ''),
(445, 'Uttam dadhich', 'ukdadhich81@gmail.com', '', 'Niwaru road', '9351170233', '302012', NULL, '', 'killer1210', '', ''),
(446, 'Jassi', 'jaspalsinghazad@gmail.com', '', 'Gobindpuri', '9268145707', '110019', NULL, '', 'reebok123', '', ''),
(447, 'Satya Narayan Khandelwal', 'satyaatsodala@gmail.com', '', '38, Gayatri Nagar, Sodala, Jaipur', '9352976205', '302006', NULL, '', 'Satya@2018', '', ''),
(448, 'chiranjeet singh', 'chiranjeetsingh87@gmail.com', '', 'niti marg bajaj nagar jaipur', '9079780883', '302015', NULL, '', 'chiranjeet', '', ''),
(449, 'Vivek rawat', 'vivek.rawats22@gmail.com', '', '27 ved vatika triveni nagar jaipur', '8003397818', '302018', NULL, '', 'starcity', '', ''),
(450, 'Vijay Gaikwad', 'gaikwadviju18@gmail.com', '', 'Karjat', '9823252329', '410206', NULL, '', 'Vijay0001', '', ''),
(451, 'Ashish vishwakarama', 'ashishashish0973@gmail.com', '', 'Thane', '8779794581', 'Ashish', NULL, '', '112233', '', ''),
(452, 'Ravi', 'ravipancholi3100@gmail.com', 'M', 'Mansarover jaipur', '9929698862', '302020', NULL, '', 'ravi0055', '', ''),
(453, 'susa1967', 'scyadav17@gmail.com', '', 'House No-56,Gali No-04,Chandan Colony, Saidullajab ,Saket New Delhi', '8745980471', '110068', NULL, '', 'susa1967', '', ''),
(454, 'mandla', 'mandlamaddiletikala390@gmail.com', '', 'amberpet, Hyderabad', '9550305893', '500044', NULL, '', 'mandla3128', '', ''),
(455, 'Harish', 'harish1851988@gmail.com', 'M', 'Patal marg mansarovar', '9166244834', '301703', NULL, '', '1988', '', ''),
(456, 'Davindersethi', 'davindersethi@gmail.com', '', '7, 2nd Floor, Bahunia Street, Urban Woods, Vatika Infotech City, Near Gvk Toll Plaza, Ajmer Road, Jaipur', '9829122744', '302026', NULL, '', 'Mansi@123', '', ''),
(457, 'Ramesh', 'rvgala123@gmail.com', 'M', 'P 502 Navneet Nagar deshlepada bhopargaon Dombivali east', '9137996224', '421201', NULL, '', 'mayagala2019', '', ''),
(458, 'Sag', 'sag@gmail.com', 'M', 'Jaipur', '7240265265', '1234', NULL, '', '0987', '', ''),
(459, 'Moin khan', '9929520550.mk@gmail.com', 'M', 'Udaipur rajasthan', '9929520550', '313001', NULL, '', '12340000', '', ''),
(460, 'Praveenkumar', 'www.praveenasha4005@email.com', 'M', '2|56.anna street sothuperumbedu chennai 600067.', '8939097560', '600067', NULL, '', 'praveenasha4005', '', ''),
(461, 'Abialkeesh', 'muneeswaran.transport@gmail.com', 'M', 'Chennai', '9500148314', '600099', NULL, '', 'abialkeesh1@', '', ''),
(462, 'Siddharth ', 'coolcloudsmarketing@gmail.com', 'M', '703 - Nishigandha, Royal Gardens, Daman Road, Chala, Vapi - 396191', '9723811749', '396191 ', NULL, '', 'sheetal749', '', ''),
(463, 'Irfan khan', 'irrfankhan9279@gmail.com', 'M', '10,55/12 u i l. Colony savina udaipur', '9079152239', '313001', NULL, '', 'irfan1144', '', ''),
(464, 'Mukesh chand', 'mchand70@gmail.com', 'M', '101/86 patel marg mansarovar', '9414386458', '302020', NULL, '', 'mukesh#70', '', ''),
(465, 'Sunit', 'sunittekriwal@yahoo.com', 'M', 'D 276, Todarmal Marg, Banipark, Jaipur.', '9414065665', '302016', NULL, '', 'sunit1973', '', ''),
(466, 'sunnyrdr4@gmail.com', 'sunnyrdr4@gmail.com', 'M', 'Seawoods sec 27', '7977365509', '400706', NULL, '', 'Lovaboy@18', '', ''),
(467, 'Appukuttannair', 'www.appulatha@gmail.com', 'M', 'Koodaram oockode nemom p o trivandrum 20', '9847281421', '695020', NULL, '', 'appukuttannair', '', ''),
(468, 'Shivinguota', 'shivingupta0@gmail.com', 'M', '25 shakti nagar behind Genapct', '7014777344', '302017', NULL, '', '2609149sn', '', ''),
(469, 'Manoj daruka', 'monu93566@gmail.com', '', '4173/74 ganga bax joshi ka rasta galta road jaipur', '9829093566', '302003', NULL, '', '9829093566', '', ''),
(470, 'Yprince', 'yprince.86@gmail.com', 'M', 'Malviya nagar, jaipur', '9829121111', '302017', NULL, '', 'ashivani1986', '', ''),
(471, 'Buddhi prakash sharma', 'buddhiprakashsharma25692@gamil.com', 'M', 'Jai kishan pura tonk rajasthan 304801', '6350251189', '304801', NULL, '', '9784394950', '', ''),
(472, 'Himanshu jain', 'Jainhimanshu1997@gmail.com', 'M', '61,mahaveer nagar, Golyawas, patrakar colony road', '7976515518', '302020', NULL, '', 'honey', '', ''),
(473, 'Simer', 'sumerchoudhary706@gmail.com', 'M', 'Manserover jaipur', '9057740238', '302020', NULL, '', '70233456', '', ''),
(474, 'Navratan agarwal', 'rukmanigj7@gmail.com', 'M', '311, shanti nayar shopping centre', '9024729431', '302018', NULL, '', 'agarwal@9431', '', ''),
(475, 'Jeevraj', 'jeevraj25rj@gmail.com', 'M', 'Mahima panache', '8758610205', '302033', NULL, '', 'npsa6565', '', ''),
(476, 'Manmohan singh', 'manmohansingh12345.ms@gmail.com', 'M', '29, ganesh nagar, near 200 feet bypass, niwaru road, jhotwara, jaipur, rajasthan ', '9529037546', '302012', NULL, '', 'Monusingh1', '', ''),
(477, 'Kamlesh ', 'kkgarg66@gmail.com', 'M', '23,ganesh nagar main, niwaru road, jhotwara ', '7976010212', '302012', NULL, '', 'kkagarwal', '', ''),
(478, 'B S Rathore', 'renund8889@gmail.com', 'M', '47, Govind Nagar-7th, Sitawali Fatak, Benar Road, Jaipur', '7976585152', '302012', NULL, '', '805817', '', ''),
(479, 'Babu Lal Meena ', 'meena.tcil4505@gmail.com', 'M', 'H. No. 30 Jai Jawan Colony-2 Durgapura Jaipur ', '9414408307', '302015', NULL, '', 'meena@4505', '', ''),
(480, 'Pankaj', 'pankaj94sharma94@gmail.com', 'M', 'Bhamoria', '8890450158', '302026', NULL, '', 'pankaj123', '', ''),
(481, 'Deepak tank', 'deepaktank4785@gmail.com', 'M', 'C24 manglam city kalwar road jaipur', '7665789324', '30 20 12 ', NULL, '', 'deepaktank', '', ''),
(482, 'Ranjit Kumar Mallick', 'ranjitkumar.248@gmail.com', 'M', 'Kharghar , sector 35', '8879743120', '410210', NULL, '', 'ranjit@123', '', ''),
(483, 'Ashu banna', 'bannaashu9782@gmail.com', 'M', '72 A shanti nagar gurjar ki thadi mansarover jaipur rajasthan india', '9782283146', '302020', NULL, '', 'nareshkumar', '', ''),
(484, 'Sawkat', 'gonukataria@gmail.com', '', '73/194 Tagore Lane Mansarovar Jaipur', '9929376083', '302020', NULL, '', 'elgoog', '', ''),
(485, 'Avani', 'avani.lekhara@gmail.com', '', 'E101 Ashiana Greenwood Jagatpura jaipur ', '9413347778', '302017', NULL, '', 'jaipur123', '', ''),
(486, 'Amit', 'amitabh040980@gmail.com', 'M', '99 à¤¬à¤°à¤•à¤¤ à¤¨à¤—à¤°', '9460006095', '302015', NULL, '', 'amit1234', '', ''),
(487, 'Shankar Devraj', 'shankarcrown@gmail.com', 'M', '403, Springhill, Hiranandani Estate, Near Hiranandani Foundation School, Off Ghodbunder Road, Thane, Maharashtra', '9323568545', '400607', NULL, '', 'sha5727', '', ''),
(488, 'R. S. Rastogi', 'rastogirs@yahoo.com', 'M', '171 A, Rampath, Suryanagar, Gopalpura Byepass, Jaipur', '7597921726', '302015', NULL, '', '1750', '', ''),
(489, 'Rahul', 'rahulgupta1234@gmail.com', 'M', 'Nirman nagr om hotel', '9950693669', '302020', NULL, '', '12345678', '', ''),
(490, 'Anurag Singh Dhakar ', 'anuragcoolbud@gmail.com', 'M', '6/415 Malviya Nagar jaipur ', '9811118495', '302017 ', NULL, '', 'rajapark', '', ''),
(491, 'Himani', 'himanibhatnagar11@gmail.com', 'F', '501 dawraka apratment mansarovar jaipir ', '9694924262', '302020', NULL, '', 'bnkbnk', '', ''),
(492, 'Naveen', 'naveen.raichandani1989@gmail.com', 'M', 'E-36 bank colony murlipura jaipur', '9251678651', '302039', NULL, '', 'nkrc@240489', '', ''),
(493, 'Gaur_mohit', 'gaur_mohit@yahoo.com', 'M', 'S1, Plot no.5, Krishna Sarover near iskon temple', '9982299971', '302020', NULL, '', 'Kush2019@1', '', ''),
(494, 'Pradeep gupta', 'drpradeepg@gmail.com', 'M', 'AA-8, triveni nagar, jaipur', '6350487282', '302018', NULL, '', 'topta420', '', ''),
(495, 'Manish ', 'manishkumar00000@gmail.com', 'M', 'Mansarovar', '9772198797', '302020', NULL, '', 'manishdivya', '', ''),
(496, 'Kapil maheshwari', 'kapilcmo@gmail.com', 'M', 'B392a, 10b scheme, gopalpura bypass jaipur', '9468847928', '302018', NULL, '', 'server123', '', ''),
(497, 'shridhi', 'shridhigarg154@gmail.com', 'F', 'Ghas katla naya bazar ajmer', '9983441956', '305001', NULL, '', 'shridhi1987', '', ''),
(498, 'Amit3518', 'amit3518@gmail.com', '', 'Shyam nagar ', '9829061644', '302019', NULL, '', '27041981', '', ''),
(499, 'S N Verma', 'verma.sn377@gmail.com', 'M', 'Anukrti tewnship jaisinghpura', '7229982277', '302026', NULL, '', 'Menubeta7#', '', ''),
(500, 'Varyn', 'varun332001@yahoo.com', 'M', 'Wtp', '8058174106', '302017', NULL, '', '123', '', ''),
(501, 'Satish', 'sraj47900@gmail.com', 'M', 'Sakinaka', '9372311951', '400072', NULL, '', '1544', '', ''),
(502, 'M K MITTAL ', 'mittalmulendra@gmail.com', 'M', '4/75, VIDYADHAR NAGAR JAIPUR ', '8619104523', '302039', NULL, '', '1753', '', ''),
(508, 'Adit Bhargava ', 'aditbhargava@devoysoftech.com', 'M', 'Jaipur', '9602320214', '302033', NULL, '', 'qwerty', '', ''),
(509, 'prateekgupta', 'prateekgupta00@gmail.com', 'M', 'B 96 janta colony jaipur', '9413101329', '302004', NULL, '', 'prateekGUPTA', '', ''),
(510, 'Rahul', '2222rahul9999@gmail.com', 'M', 'Xyz', '8094206561', '302021', NULL, '', '1r2a3h4u5l', '', ''),
(511, 'Rajesh Goyal', 'rajesh.goyal744@gmail.com', 'M', 'Chaura rasta', '9414400744', '302003', NULL, '', '9509', '', ''),
(512, 'Rajendra', 'xyz1@gmail.com', 'M', 'Xyz', '6350562829', '302003', NULL, '', '1234', '', ''),
(513, 'Aakash', 'dixitc31@gmail.com', 'M', '769, mahaveer nagar', '8696939666', '302018', NULL, '', 'ranusonach1', '', ''),
(514, 'Yuvraj singh', 'cashrum2016@gmail.com', '', 'B 453 a sumer nagar mansarover', '9602946086', '302020', NULL, '', 'emma@watson', '', ''),
(515, 'ram175', 'rkishore780@gmail.com', 'M', 'A-175,Malviya Nagar,Jaipur', '9414320704', '302017', NULL, '', 'Meena@175', '', ''),
(516, 'Mukesh gupta', 'rajatagarwal452@gmail.com', 'M', '2/116Malviya nagar jaipur', '9983522282', '302017', NULL, '', 'rajagarwal452', '', ''),
(517, 'Mayur', 'xyz12345@gmail.com', 'M', '23', '9116332253', '302003', NULL, '', '123456', '', ''),
(518, 'Mikku', 'tdc.jpr@gmail.com', 'M', 'Abcd', '8741879999', '302003', NULL, '', '12345', '', ''),
(519, 'Ruchir', 'ruchir@vkalp.com', 'M', 'Unique Sanghi Apartment mahaveer Nagar Tonk Road jaipur', '9610808088', '302018', NULL, '', 'rg123456785656', '', ''),
(520, 'Sunil Kabra', 'kabsunil@gmail.com', 'M', 'A 37, 2nd floor, Brij Vihar, Ghaziabad, U. P', '9868169880', '201011', NULL, '', 'rasmay248!', '', ''),
(521, 'Viccky', 'vsingh65598@gmail.com', 'M', 'HOUSE NO.A110 CIVIL LINE YADAV PATH HARI MARG.JAIPUR', '8005903114', '302006', NULL, '', '4204234', '', ''),
(522, 'Vivek agarwal', 'rdvivek78@gmail.com', 'M', 'A-647,shiv marg,malviya nagar,jaipur', '9829204006', '302017', NULL, '', 'scorpio3176', '', ''),
(523, 'Goutam soni ', 'gulmohan96385@gmail.com', 'M', 'Manglam city  Kalwar road jhowara ', '8209959726', '302016', NULL, '', '9829393927', '', ''),
(524, 'Sanket', 'Sanketnagare8889@gmail.com', 'M', 'Nashik', '8446448889', '42201', NULL, '', '123456789', '', ''),
(525, 'Veer singh ', 'zuzugujjar007@gmail.com', 'M', 'Rajat path ', '9116107587', '302020', NULL, '', 'veer12345', '', ''),
(526, 'Gowri', 'gauri.vishwanath@gmail.com', 'F', '#607, 45th cross, 8th block Jayanagar, Bangalore 560082', '9611229988', '560082', NULL, '', 'Atharv1113', '', ''),
(527, 'Ashonrocks', 'ashonrocks@gmail.com', 'M', 'A106 mahesh nagar tonk fatak jaipur', '9799886698', '302015', NULL, '', 'Ashuzindagi9.', '', ''),
(528, 'Sachin ', 'skumar21644@gmail.com', 'M', 'Ssspg', '6375643512', '302020', NULL, '', '89723088', '', ''),
(529, 'Lekha  garg', 'lekhagarg.in@gmail.com', 'F', '616, unique sanghi apartment, mahaveer nagar, jaipur', '9992000456', '302018', NULL, '', 'motherinlow', '', ''),
(530, 'Jaipur laundry and dry cleaners', 'sales.jaipurlaundry@gmail.com', 'F', 'G-5 plot no 379 Gali No 2,Rajapark Jaipur', '9116366663', '302004', NULL, '', 'Pass@123', '', ''),
(531, 'Dinesh kumar ', 'dkumar2627@gmail.com', 'M', 'Vpo napawali tehsil neem ka thana ', '7732995700', '332713', NULL, '', '7732995700', '', ''),
(532, 'Pawan Ghunawat', 'pawanghunawat25@gmail.com', 'M', 'E-453,Lal Kothi Scheme,Near Apex International School,Jaiput', '9530037969', '302015', NULL, '', 'pawan@786', '', ''),
(533, 'sumit mehta', 'sumitmehtajpr@gmail.com', 'M', 'A-38,tilak nagar,jaipur', '9829065382', '302004', NULL, '', 'sumit', '', ''),
(534, 'Purushottam sharma ', 'purushottamsharma5@gmail.com', 'M', 'B-3,lal khoti shopping centre near laxmi mandir cinema tonk road jaipur ', '9414076583', '302015', NULL, '', '1968', '', ''),
(535, 'SANJAY71352', 'sanjay71352@gmail.com', 'M', 'Raj velle,flat no 201,jawahar nagar, sector 5,opp.st Edmund school, Jaipur', '9414071352', '302004', NULL, '', 'sanjuanju2003', '', ''),
(536, 'Rajendra Kumar ajmera ', 'rajendra.ajmera1@gmail.com', 'M', 'Flate no 401 golden indralok D 17 ganesh marg bapu nagar jaipur ', '9829141206', '302015', NULL, '', 'rajendra@41206', '', ''),
(537, 'Suresh kumar meena', 'Sureshmina1970@gmail.com', 'M', '4D8 Govt Multystory Flats near nehru garden Gandhinagar jaipur', '9782474605', '302015', NULL, '', '0000', '', ''),
(538, 'jhuranitushar', 'jhuranitushar@gmail.com', 'M', '4/106, jawahar nagar, jaipur', '7728847989', '302004', NULL, '', 'tushar1309', '', ''),
(539, 'Sunny', 'sunny.kalra07@gmail.com', 'M', '143 ram gali no 3 near bhatia bhwan raja park jaipur', '9829072400', '302004', NULL, '', '9283', '', ''),
(540, 'Devendra Gurjar ', 'devendragurjar4185@gmail.com', 'M', 'F- 216 Lal Kothi sceme opposite new assembly Jaipur ', '7976563981', '302015', NULL, '', '654274', '', ''),
(541, 'Shuchi', 'ansindia1008@gmail.com', 'F', 'Bapu nagar', '7727999911', '302015', NULL, '', 'anekant', '', ''),
(542, 'Vini', 'vinijaisinghani@rediffmail.com', 'M', 'Jaipur', '9571987548', '302015', NULL, '', '300980', '', ''),
(543, 'Khushal arora', 'riddhitourtravells6615@gmail.com', 'M', 'Sanganer court', '9828799759', '302029', NULL, '', 'riddhima', '', ''),
(544, 'Babloo', 'babloo20200@rediffmail.com', 'M', 'A-25 taneja block saket colony jaipur rajasthan', '7014972546', '302004', NULL, '', 'bany40', '', ''),
(545, 'Alok ', 'xyz8654@gmail.com', 'M', '4-GA-12, Jawahar Nagar, Jaipur', '9828149836', '302004', NULL, '', 'alokmathur', '', ''),
(546, 'Jagdish Bansal', 'bansalcapital@gmail.com', 'M', '4 M 61 Jahawar Nagar Jaipur', '9468862653', '302004', NULL, '', 'samarth1@', '', ''),
(547, 'Ramit Chawla', 'ramitchawla2@gmail.com', 'M', '2 CHA 4, jawahar nagar, jaipur', '9829595555', '302004', NULL, '', 'pppp', '', ''),
(548, 'Shiva', 'super.antic2014@gmail.com', 'M', 'F 16', '9784511522', '302020', NULL, '', '9784511522', '', ''),
(549, 'Sumam', 'rohan2003garg@gmail.com', 'F', 'C-71 lal kothi scheme ', '8233847070', '30215', NULL, '', 'Virus182003', '', ''),
(550, 'Dr sunita agarwal', 'sunitadhanvi@gmail.com', 'F', 'B_83 ganesh marg 301 golden jewels bapu nagar Jaipur', '9829010552', '302015', NULL, '', 'dhanvi1432', '', ''),
(551, 'Love kumar', 'lovekumar468@gmail.com', 'M', 'Saganer jaipur', '9166235290', '302033', NULL, '', '2234', '', ''),
(552, 'Yogesh', 'yogeshkumawat3838@gmail.com', 'M', '64/539 Pratap Nagar Sanganer Jaipur', '6375560297', '302033', NULL, '', '1006789', '', ''),
(553, 'Praveen sharma', 'Sharmapraveen7892@gmail.com', 'M', '362 devi nagar new sanganer road sodala jaipur', '7014664389', '302019', NULL, '', '9828277555', '', ''),
(554, 'Jaikishan jangir', 'krishnajangir9460907316@gmail.com', 'M', 'E-68 govindpuri, Sodala', '9460907316', '302019', NULL, '', 'jai123', '', ''),
(555, 'OM PRAKASH CHOUDHARY', 'jyaniomprakash2@gmai.com', 'M', 'vill-sirsi post-lunwa nawa nagour', '8058957820', '341509', NULL, '', '9636073665', '', ''),
(556, 'Dheeraj', 'dhiraj247@rediffmail.com', 'M', 'Plot no 176, f3 varun apartment kishan nagar shyam nagar jaipur', '9983347508', '302019', NULL, '', 'dhiraj@1234', '', ''),
(557, 'narulavikas3', 'narulavikas@gmail.com', 'M', 'Sodala', '9818388186', '302019', NULL, '', 'r1e1e1t1', '', ''),
(558, 'Nidhisanadhya', 'sgnnidhi@gmail.com', 'F', 'G-1 ,plot no-482,laxman path,vivek vihar,jaipur.', '9462211201', '302019', NULL, '', 'drnidhisanadhya84', '', ''),
(559, 'Alpna agarwal', 'alpnaagarwal26@gmail.com', 'F', 'E-240 hem marg jaipur', '9414407128', '302019', NULL, '', 'varun1', '', ''),
(560, 'micaps', 'micaps@rediffmail.com', 'M', '71-Shanti Nagar-A, Gujar Ki Thadi, Jaipur -302019', '9829053425', '302019', NULL, '', '20pvjose19', '', ''),
(561, 'cakeshav', 'singhal.keshav88@gmail.com', 'M', 'house 150, moti nagar, queens road, jaipur', '9828591889', '301001', NULL, '', 'keshav_123', '', ''),
(562, 'Nikhil soni ', 'Nikhilsoniip50@gmail.com', 'M', '124/ 104 thadi market', '9694319218', '302020', NULL, '', '9694319218', '', ''),
(563, 'Priyanka', 'priyankagoenka30112@gmail.com', 'F', 'A-470 malviya naga', '8955255563', '302017', NULL, '', '251975s', '', ''),
(564, 'Sarbeswar Dakua ', 'dilutax@gmail.com', 'M', 'Dumuduma housing board colony ', '9338025086', '751019', NULL, '', 'taxdillu1978', '', ''),
(565, 'Pinku Agarwala', 'pinku@maaruji.com', 'M', 'Rangoli Garden', '8094013131', '302034', NULL, '', 'pinku1248', '', ''),
(566, 'Ajit', 'ajitsure50@gmail.com', 'M', 'Dno 7/8/3,srirampuram,narasaraopet', '8297793614', '522601', NULL, '', 'ajit1234', '', ''),
(567, 'Pranjal Pareek', 'pareekpranjal86@gmail.com', 'M', 'Mansarovar', '7220053904', '302020', NULL, '', 'pranjal98', '', ''),
(568, 'Ram Sunder thakur', 'ramsundra.t@gmail.com', 'M', 'M block Dilshad garden', '9312348375', '110095', NULL, '', 'sonal007', '', ''),
(569, 'Ravichandra', 'godboler@gmail.com', 'M', 'No. 127, 4th Main Sancharnagar (Telecom Layout), Thanisandra Main Road, Aswathnagar, Bangalore', '9742329259', '560077', NULL, '', 'Ravi1234', '', ''),
(570, 'Sanmeet', 'sanmeetshah7@gmail.com', 'M', 'Pune', '9822672189', '41037', NULL, '', 'mh11ak325', '', ''),
(571, 'Dipak ', 'dipakb1981@gmail.com', 'M', 'Dombivli', '9223505391', '421203', NULL, '', 'orchid@05818791', '', ''),
(572, 'Mala Jain', 'malajain2005@gmail.com', 'F', '54B1 Gangwal park,MD road ,Jaipur', '9460871076', '302004', NULL, '', 'malajmalajmalaj', '', ''),
(573, 'Harsh', 'batameezharsh@gmail.com', 'M', 'Jhotwara', '8117811021', '302012', NULL, '', 'santhalia123', '', ''),
(574, 'Pratik', 'pratikw2@gmail.com', 'M', 'Navi mumbai', '9594595867', '400709', NULL, '', 'Wadu@98706', '', ''),
(575, 'JAIPRAKASH', 'JPS006692@gmail.com', 'M', 'Plot C-180 A, Gyan Marg, Jaipur', '9928914692', '302004', NULL, '', 'jaiprakash', '', ''),
(576, 'Anuj', 'tanvi307@gmail.com', 'M', 'Plt-123 Panchsheel Enclave Durgapura', '9928633555', '302018', NULL, '', 'anuj1489', '', ''),
(577, 'Sunil agrawal', 'sragrawal97@gmail.com', 'M', 'Kota', '9414966908', '324007', NULL, '', '1234', '', ''),
(578, 'Ravindra sharma', 'sharma.ravindra2@sbi.co.in', 'M', '71/157 prtap nagar jaipur', '9414476048', '302033', NULL, '', 'shreeram123', '', ''),
(579, 'Kumar', 'jadish52@yahoo.com', 'M', 'B48 Govind puri Ramnager Ext. Sodala Jaipur', '8829040830', '302019', NULL, '', '521234', '', ''),
(580, 'Ayush pancholi', 'ayushs338@gmail.com', 'M', 'Pno 1 . Kailash marg . Civil lines . Jaipur', '9358880211', '302006', NULL, '', 'Abcd@123', '', ''),
(581, 'Ajay', '123ajaygowda@gmail.com', 'M', '#6,1st,mainroad,bhovipalya,mahalakshmipura,bangalore', '9902861588', '560086', NULL, '', 'aj5475', '', ''),
(582, 'Dhruv', 'dkiphones620@gmail.com', 'M', '51/412', '8946824714', '302033', NULL, '', 'betrworld', '', ''),
(583, 'Prakash', 'prakashsolanki12345678910@gmail.com', 'M', '51/327 ,sector 5, pratap nagar', '9799278349', '302033', NULL, '', 'jacksparrow123', '', ''),
(584, 'Samyak1098', 'samyakjprjain@gmail.com', 'M', '3-NA-9, jawahar nagar jaipur', '9672125946', '302004', NULL, '', 'samyakpro', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `id` int(20) NOT NULL,
  `first_name` varchar(245) DEFAULT NULL,
  `last_name` varchar(245) NOT NULL,
  `attendance` varchar(10) NOT NULL DEFAULT 'false',
  `online` varchar(10) NOT NULL DEFAULT 'false',
  `status` varchar(245) NOT NULL,
  `email_id` varchar(245) DEFAULT NULL,
  `address` text,
  `mobile_no` varchar(20) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `licance_no` varchar(245) DEFAULT NULL,
  `profile_img` varchar(245) DEFAULT NULL,
  `auth_id` varchar(50) NOT NULL,
  `auth_pswrd` varchar(50) NOT NULL,
  `driverLat` varchar(245) NOT NULL,
  `driverLng` varchar(245) NOT NULL,
  `dummy_cr` float NOT NULL DEFAULT '0',
  `dummy_dr` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`id`, `first_name`, `last_name`, `attendance`, `online`, `status`, `email_id`, `address`, `mobile_no`, `zip_code`, `licance_no`, `profile_img`, `auth_id`, `auth_pswrd`, `driverLat`, `driverLng`, `dummy_cr`, `dummy_dr`) VALUES
(38, 'Ravi', 'Pancholi', 'true', 'true', '', 'ravipancholi0055@gmail.com', '31dadu dayal colony patal marg mansarover', '8949724055', '302020', 'Gjknhk khich gh', NULL, '', 'ravi@0055', '26.86837601', '75.7838595', 0, 0),
(39, 'Ujagar singh', 'Meena', 'false', 'false', '', 'ujagar.singh.meena@gmail.com', 'Jaipur', '9828784536', '302020', 'RJ-14/12345/12345-23', NULL, '', '1234', '26.9432681', '75.8503088', 0, 0),
(97, 'Ramjilal', 'Sharma', 'true', 'true', '', 'RAMJILALBAGDA9512@gmail.com', 'Surajpura,dadiya,Sanganer,Jaipur', '9694419512', '303905', 'Rj14 20140021013', NULL, '', 'RAMJILALBAGDA9512', '26.756174', '75.8459512', 0, 0),
(52, 'Kailash', 'Khoj', 'false', 'false', '', 'Kailashkhoj4946@gmail.com', 'Bill titariya teh chaksu distribution Jaipur', '9829931113', '303903', 'Rj1420020210191', NULL, '', 'Doa@0055', '', '', 0, 0),
(57, 'Kailash', 'Khoj', 'false', 'false', '', 'Kailashkhoj0055@gmail.com', 'Vill titariya teh chaksu dist jaipur raj.', '9829931113', '303903', 'Rj14 20020210191', NULL, '', 'Khoj0055', '26.851161', '75.7573491', 0, 0),
(58, 'Bhaver lal', 'Choudhary', 'false', 'false', '', 'Bhaverlal0055@gmail.com', 'Vill.Dholi sanganer', '7062495144', '302020', 'Rj1467i998', NULL, '', 'Bhaver0055', '26.8531011', '75.7568327', 0, 0),
(74, 'Sanjay', 'Sharma', 'false', 'false', '', 'Sanjaysharma0055@gmail.com', 'Vill-jola,Teh-piplu,Tonk,Raj.', '9950680828', '304021', 'Rj26 20130112971', NULL, '', 'Sanjaysharma0055', '26.79766667', '75.81620192', 0, 0),
(79, 'Ravindra', 'Kumar', 'false', 'true', '', 'Ravindrakumar0055@gmail.com', '157 vill.purana nimodiya, teh.chaksu, Jaipur,Raj.', '9358417989', '303901', 'Rj14 20150029748', NULL, '', 'Ravindrakumar0055', '26.864785', '75.7873667', 0, 0),
(78, 'Govindpuri', 'Goswami', 'false', 'false', '', 'Govindgoswami0055@gmail.com', 'Ward no.13,kanarpura, the.chomu,Jaipur,Raj.', '9119202994', '303801', 'Rj 41 20140003845', NULL, '', 'Govindpurigoswami0055', '', '', 0, 0),
(80, 'Mukesh', 'Choudhary', 'true', 'true', '', 'Mukeshchoudhary0055@gmail.com', 'Tibali dhani palawala Jatan, teh. Bassai,jaipur,raj.', '9828475800', '303301', 'Rj 14 D20170002877', NULL, '', 'Mukeshchoudhary0055', '26.69430064', '75.72730765', 0, 0),
(83, 'Dholiyaram', 'Meena', 'true', 'true', '', 'Dholiyarammeena0055@gmail.com', 'Khohara (mawali) teh.laxhmangarh,Alwar', '7014570876', '321633', 'Rj02 20130019258', NULL, '', 'Dholiyarammeena0055', '26.8668754', '75.7575189', 0, 0),
(86, 'Shubhankar', 'Kaushal', 'false', 'false', '', 'Shubhankarkaushal0055@gmail.com', 'B-2 Keith hari enclave dholpur rajasthan', '7976653181', '328029', 'Rj11 20150000012', NULL, '', 'Shubhankarkaushal0055', '26.9176695', '75.8197489', 0, 0),
(87, 'Himanshu', 'Arora', 'true', 'true', '', 'Himanshuarora0055@gmail.com', '12/165 kaveri path mansarovar Jaipur rajasthan', '8112276345', '302020', 'RJ14C20170019987', NULL, '', 'Himanshuarora0055', '26.8883624', '75.7622991', 0, 0),
(88, 'Ramji lal', 'Sharma', 'true', 'true', '', 'Ramjilalsharma0055@gmail.com', 'Vill.Surajpura,dadiya,sanganer,jaipur,Raj.', '9694419512', '303905', 'Rj14 20140021013', NULL, '', 'Ramjilalsharma0055', '26.7376504', '75.8242443', 0, 0),
(89, 'Bhanu Pratap', 'Singh Bhati', 'true', 'true', '', 'Bhanupratapsingh0055@gmail.com', '144 jagannath puri a jhotwada jaipur', '8058107601', '302012', 'Rj1420110589761', NULL, '', 'Bhanupratapsingh0055', '26.9525725', '75.7243766', 0, 0),
(90, 'Laxmikant', 'Dadhich', 'true', 'true', '', 'Laxmikantdadhich@gmail.com', '1691 khawash ji rasta subhash chowk Jaipur', '9413972859', '302002', 'Rj1420060633363', NULL, '', 'Laxmikantdadhich0055', '26.89674064', '75.7752222', 0, 0),
(91, 'Shivram', 'Choudhary', 'true', 'true', '', 'Shivramchoudhary0055@gmail.com', '46 singhaniya ki dhani ward no 12 sanganer jaipur', '9785986666', '302020', 'Rj1420150013166', NULL, '', 'Shivramchoudhary0055', '26.836387278074', '75.743708888635', 0, 0),
(93, 'Jitendra', 'Jangir', 'true', 'true', '', 'Jitendrajangir0055@gmail.com', '119/468 agarwal farm mansarovar Jaipur', '9660993396', '302020', 'Rj14b20180002406', NULL, '', 'Jitendrajangir0055', '26.851628333333', '75.778768333333', 0, 0),
(99, 'Inder Jeet', 'Singh', 'false', 'false', '', 'Inderjeetsingh0055@gmail.com', 'Plot no-51 flat no 5302 bhaskar enclave patrakar colony mansarovar jaipur', '8949629267', '302020', 'Rj 14 20030265793', NULL, '', 'Inderjeet0055', '26.8641963', '75.7935986', 0, 0),
(95, 'Bharat singh', 'Shekhawat', 'false', 'false', '', 'Bharatsingh0055@gmail.com', '2D- 61 Tata Nagar Shastri Nagar Jaipur', '8949839188', '302016', 'Rj 14 20050446085', NULL, '', 'Bharatsingh0055', '26.92989392', '75.76323864', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `memid` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`memid`, `username`, `password`, `firstname`, `lastname`, `address`) VALUES
(1, 'admin', 'ravi@946299', 'Ravi', 'Pancholi', 'Jaipur');

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `convenience` int(10) NOT NULL,
  `firstForth` int(10) NOT NULL,
  `secondForth` int(10) NOT NULL,
  `thirdForth` int(10) NOT NULL,
  `discountPer` int(10) NOT NULL,
  `extra_charges` int(11) NOT NULL,
  `taxPer` int(10) NOT NULL,
  `min_minuts` int(10) NOT NULL,
  `night_charge` int(10) NOT NULL,
  `auto` int(10) NOT NULL,
  `manual` int(10) NOT NULL,
  `local` int(10) NOT NULL,
  `oneway` int(10) NOT NULL,
  `outstation` int(10) NOT NULL,
  `small` int(10) NOT NULL,
  `medium` int(10) NOT NULL,
  `large` int(10) NOT NULL,
  `luxury` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`convenience`, `firstForth`, `secondForth`, `thirdForth`, `discountPer`, `extra_charges`, `taxPer`, `min_minuts`, `night_charge`, `auto`, `manual`, `local`, `oneway`, `outstation`, `small`, `medium`, `large`, `luxury`) VALUES
(50, 71, 47, 31, 0, 0, 0, 25, 100, 0, 0, 0, 100, 0, 0, 0, 0, 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(20) NOT NULL,
  `user_name` varchar(245) NOT NULL,
  `password` varchar(245) NOT NULL,
  `name` varchar(245) NOT NULL,
  `email_id` varchar(245) NOT NULL,
  `mobile_no` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `user_name`, `password`, `name`, `email_id`, `mobile_no`) VALUES
(1, 'mani123', '25d55ad283aa400af464c76d713c07ad', '', 'manisinghal@gmail.com', ''),
(2, 'mani123', '12345', '', 'mani@gmail.com', ''),
(3, 'manis', '123123', '', 'maniSinghal@gmail.com', ''),
(4, 'mani123', 'mani123', '', 'manip@gmail.com', ''),
(5, 'manip123', '879879', '', 'manipo@gmail.com', '');

-- --------------------------------------------------------

--
-- Table structure for table `user_data`
--

CREATE TABLE `user_data` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_phone` varchar(15) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_address` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_data`
--

INSERT INTO `user_data` (`user_id`, `user_name`, `user_email`, `user_phone`, `user_password`, `user_address`, `created`) VALUES
(2, 'Ujagar Singh', 'ujagar@gmail.com', '9828784536', '827ccb0eea8a706c4c34a16891f84e7b', 'jaipur', '2018-05-26 15:32:50'),
(3, 'Ravi Pancholi', 'driveronapp@gmail.com', '9462-99-8080', '$2a$10$6b3f4a346f1297fe6d0a0uRQygyRm1kElfk84HIT1wTWb4rAbie.G', 'F-16, Sumer Nagar, Behind Cheel Gaddi Restaurent, Patel Marg, Mansarowar, Jaipur', '2018-05-27 00:53:33'),
(4, 'ujagar singh', 'jaipur@gmail.com', '9825784536', '$2a$10$7ade1e2ff00d974776662u7eEK4NuhFAUYmB3GcPbnczOZRqzZiLW', 'jaipur', '2018-05-27 02:53:37');

-- --------------------------------------------------------

--
-- Table structure for table `versions`
--

CREATE TABLE `versions` (
  `id` int(5) NOT NULL,
  `android_ver` varchar(10) NOT NULL,
  `ios_ver` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `versions`
--

INSERT INTO `versions` (`id`, `android_ver`, `ios_ver`) VALUES
(1, '43', '13'),
(2, '25', '14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `app_income`
--
ALTER TABLE `app_income`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`memid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_data`
--
ALTER TABLE `user_data`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `versions`
--
ALTER TABLE `versions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_income`
--
ALTER TABLE `app_income`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10761;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=585;

--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `memid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_data`
--
ALTER TABLE `user_data`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `versions`
--
ALTER TABLE `versions`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
