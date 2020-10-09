-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2020 at 04:58 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school_office`
--

-- --------------------------------------------------------

--
-- Table structure for table `acc_ledger_entry`
--

CREATE TABLE `acc_ledger_entry` (
  `id` int(11) NOT NULL,
  `school_id` int(4) NOT NULL,
  `vchr_ref_id` int(11) NOT NULL,
  `ledger_id` int(5) DEFAULT NULL,
  `ledger_type` varchar(1) DEFAULT NULL COMMENT 'student = S, Employee = E, Other = O, Capital & Owner = C',
  `ledger_folio` varchar(10) NOT NULL,
  `op_balance` int(15) NOT NULL,
  `op_type` varchar(2) NOT NULL,
  `tr_amount` int(15) NOT NULL,
  `tr_type` varchar(2) NOT NULL,
  `cl_balance` int(15) NOT NULL,
  `cl_type` varchar(2) NOT NULL,
  `session_year_id` varchar(3) NOT NULL COMMENT 'current session id	',
  `server_date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `group_code` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acc_ledger_entry`
--

INSERT INTO `acc_ledger_entry` (`id`, `school_id`, `vchr_ref_id`, `ledger_id`, `ledger_type`, `ledger_folio`, `op_balance`, `op_type`, `tr_amount`, `tr_type`, `cl_balance`, `cl_type`, `session_year_id`, `server_date_time`, `group_code`) VALUES
(1166, 4, 762, 106, 'S', '106_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:44:57', '1003'),
(1167, 4, 762, 20, 'O', '20_O_4', 0, 'CR', 5, 'CR', 5, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1168, 4, 762, 17, 'O', '17_O_4', 0, 'CR', 45, 'CR', 45, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1169, 4, 762, 16, 'O', '16_O_4', 0, 'CR', 454, 'CR', 454, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1170, 4, 762, 19, 'O', '19_O_4', 0, 'CR', 54, 'CR', 54, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1171, 4, 762, 15, 'O', '15_O_4', 0, 'CR', 54, 'CR', 54, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1172, 4, 763, 81, 'S', '81_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:44:57', '1003'),
(1173, 4, 763, 20, 'O', '20_O_4', 5, 'CR', 5, 'CR', 10, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1174, 4, 763, 17, 'O', '17_O_4', 45, 'CR', 45, 'CR', 90, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1175, 4, 763, 16, 'O', '16_O_4', 454, 'CR', 454, 'CR', 908, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1176, 4, 763, 19, 'O', '19_O_4', 54, 'CR', 54, 'CR', 108, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1177, 4, 763, 15, 'O', '15_O_4', 54, 'CR', 54, 'CR', 108, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1178, 4, 764, 71, 'S', '71_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:44:57', '1003'),
(1179, 4, 764, 20, 'O', '20_O_4', 10, 'CR', 5, 'CR', 15, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1180, 4, 764, 17, 'O', '17_O_4', 90, 'CR', 45, 'CR', 135, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1181, 4, 764, 16, 'O', '16_O_4', 908, 'CR', 454, 'CR', 1362, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1182, 4, 764, 19, 'O', '19_O_4', 108, 'CR', 54, 'CR', 162, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1183, 4, 764, 15, 'O', '15_O_4', 108, 'CR', 54, 'CR', 162, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1184, 4, 765, 88, 'S', '88_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:44:57', '1003'),
(1185, 4, 765, 20, 'O', '20_O_4', 15, 'CR', 5, 'CR', 20, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1186, 4, 765, 17, 'O', '17_O_4', 135, 'CR', 45, 'CR', 180, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1187, 4, 765, 16, 'O', '16_O_4', 1362, 'CR', 454, 'CR', 1816, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1188, 4, 765, 19, 'O', '19_O_4', 162, 'CR', 54, 'CR', 216, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1189, 4, 765, 15, 'O', '15_O_4', 162, 'CR', 54, 'CR', 216, 'CR', '1', '2020-10-09 02:44:57', '1002'),
(1190, 4, 766, 106, 'S', '106_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:51:30', '1003'),
(1191, 4, 766, 20, 'O', '20_O_4', 0, 'CR', 5, 'CR', 5, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1192, 4, 766, 17, 'O', '17_O_4', 0, 'CR', 45, 'CR', 45, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1193, 4, 766, 16, 'O', '16_O_4', 0, 'CR', 454, 'CR', 454, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1194, 4, 766, 19, 'O', '19_O_4', 0, 'CR', 54, 'CR', 54, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1195, 4, 766, 15, 'O', '15_O_4', 0, 'CR', 54, 'CR', 54, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1196, 4, 767, 81, 'S', '81_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:51:30', '1003'),
(1197, 4, 767, 20, 'O', '20_O_4', 5, 'CR', 5, 'CR', 10, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1198, 4, 767, 17, 'O', '17_O_4', 45, 'CR', 45, 'CR', 90, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1199, 4, 767, 16, 'O', '16_O_4', 454, 'CR', 454, 'CR', 908, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1200, 4, 767, 19, 'O', '19_O_4', 54, 'CR', 54, 'CR', 108, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1201, 4, 767, 15, 'O', '15_O_4', 54, 'CR', 54, 'CR', 108, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1202, 4, 768, 71, 'S', '71_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:51:30', '1003'),
(1203, 4, 768, 20, 'O', '20_O_4', 10, 'CR', 5, 'CR', 15, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1204, 4, 768, 17, 'O', '17_O_4', 90, 'CR', 45, 'CR', 135, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1205, 4, 768, 16, 'O', '16_O_4', 908, 'CR', 454, 'CR', 1362, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1206, 4, 768, 19, 'O', '19_O_4', 108, 'CR', 54, 'CR', 162, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1207, 4, 768, 15, 'O', '15_O_4', 108, 'CR', 54, 'CR', 162, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1208, 4, 769, 88, 'S', '88_S_4', 0, 'CR', 612, 'DR', 612, 'DR', '1', '2020-10-09 02:51:30', '1003'),
(1209, 4, 769, 20, 'O', '20_O_4', 15, 'CR', 5, 'CR', 20, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1210, 4, 769, 17, 'O', '17_O_4', 135, 'CR', 45, 'CR', 180, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1211, 4, 769, 16, 'O', '16_O_4', 1362, 'CR', 454, 'CR', 1816, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1212, 4, 769, 19, 'O', '19_O_4', 162, 'CR', 54, 'CR', 216, 'CR', '1', '2020-10-09 02:51:30', '1002'),
(1213, 4, 769, 15, 'O', '15_O_4', 162, 'CR', 54, 'CR', 216, 'CR', '1', '2020-10-09 02:51:30', '1002');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acc_ledger_entry`
--
ALTER TABLE `acc_ledger_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sch_id` (`vchr_ref_id`),
  ADD KEY `school_id` (`school_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acc_ledger_entry`
--
ALTER TABLE `acc_ledger_entry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1262;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acc_ledger_entry`
--
ALTER TABLE `acc_ledger_entry`
  ADD CONSTRAINT `acc_ledger_entry_ibfk_1` FOREIGN KEY (`vchr_ref_id`) REFERENCES `acc_voucher_ref` (`id`),
  ADD CONSTRAINT `acc_ledger_entry_ibfk_2` FOREIGN KEY (`school_id`) REFERENCES `school_info` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;




[
  {
    "school_id": "4",
    "vchr_ref_id": "758",
    "ledger_id": "106",
    "ledger_type": "S",
    "group_code": "1003",
    "op_balance": 0,
    "op_type": "CR",
    "tr_amount": 612,
    "tr_type": "DR",
    "cl_balance": 612,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "758",
    "ledger_id": "20",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 612,
    "op_type": "DR",
    "tr_amount": "5",
    "tr_type": "CR",
    "cl_balance": 617,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "758",
    "ledger_id": "17",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 617,
    "op_type": "DR",
    "tr_amount": "45",
    "tr_type": "CR",
    "cl_balance": 572,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "758",
    "ledger_id": "16",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 572,
    "op_type": "DR",
    "tr_amount": "454",
    "tr_type": "CR",
    "cl_balance": 118,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "758",
    "ledger_id": "19",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 118,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 64,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "758",
    "ledger_id": "15",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 64,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 10,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "759",
    "ledger_id": "81",
    "ledger_type": "S",
    "group_code": "1003",
    "op_balance": 10,
    "op_type": "DR",
    "tr_amount": 612,
    "tr_type": "DR",
    "cl_balance": 622,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "759",
    "ledger_id": "20",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 622,
    "op_type": "DR",
    "tr_amount": "5",
    "tr_type": "CR",
    "cl_balance": 617,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "759",
    "ledger_id": "17",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 617,
    "op_type": "DR",
    "tr_amount": "45",
    "tr_type": "CR",
    "cl_balance": 572,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "759",
    "ledger_id": "16",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 572,
    "op_type": "DR",
    "tr_amount": "454",
    "tr_type": "CR",
    "cl_balance": 118,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "759",
    "ledger_id": "19",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 118,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 64,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "759",
    "ledger_id": "15",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 64,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 10,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "760",
    "ledger_id": "71",
    "ledger_type": "S",
    "group_code": "1003",
    "op_balance": 10,
    "op_type": "DR",
    "tr_amount": 612,
    "tr_type": "DR",
    "cl_balance": 622,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "760",
    "ledger_id": "20",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 622,
    "op_type": "DR",
    "tr_amount": "5",
    "tr_type": "CR",
    "cl_balance": 617,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "760",
    "ledger_id": "17",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 617,
    "op_type": "DR",
    "tr_amount": "45",
    "tr_type": "CR",
    "cl_balance": 572,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "760",
    "ledger_id": "16",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 572,
    "op_type": "DR",
    "tr_amount": "454",
    "tr_type": "CR",
    "cl_balance": 118,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "760",
    "ledger_id": "19",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 118,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 64,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "760",
    "ledger_id": "15",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 64,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 10,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "761",
    "ledger_id": "88",
    "ledger_type": "S",
    "group_code": "1003",
    "op_balance": 10,
    "op_type": "DR",
    "tr_amount": 612,
    "tr_type": "DR",
    "cl_balance": 622,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "761",
    "ledger_id": "20",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 622,
    "op_type": "DR",
    "tr_amount": "5",
    "tr_type": "CR",
    "cl_balance": 617,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "761",
    "ledger_id": "17",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 617,
    "op_type": "DR",
    "tr_amount": "45",
    "tr_type": "CR",
    "cl_balance": 572,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "761",
    "ledger_id": "16",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 572,
    "op_type": "DR",
    "tr_amount": "454",
    "tr_type": "CR",
    "cl_balance": 118,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "761",
    "ledger_id": "19",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 118,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 64,
    "cl_type": "DR",
    "session_year_id": "1"
  },
  {
    "school_id": "4",
    "vchr_ref_id": "761",
    "ledger_id": "15",
    "ledger_type": "O",
    "group_code": "1002",
    "op_balance": 64,
    "op_type": "DR",
    "tr_amount": "54",
    "tr_type": "CR",
    "cl_balance": 10,
    "cl_type": "DR",
    "session_year_id": "1"
  }
]