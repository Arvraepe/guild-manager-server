-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 27, 2014 at 10:39 PM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `guild_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `building`
--
-- Creation: Oct 25, 2014 at 11:25 PM
-- Last update: Oct 25, 2014 at 11:28 PM
--

DROP TABLE IF EXISTS `building`;
CREATE TABLE IF NOT EXISTS `building` (
  `uuid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `building`
--

INSERT INTO `building` (`uuid`, `name`, `capacity`) VALUES
('95CB4BB0-5C8D-11E4-8ED6-0800200C9A66', 'Guild hall', 100),
('B8D7C4D0-5C8D-11E4-8ED6-0800200C9A66', 'Guild barracks', 40),
('C6004C90-5C8D-11E4-8ED6-0800200C9A66', 'Guild armory', 15);

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--
-- Creation: Oct 25, 2014 at 10:50 PM
-- Last update: Oct 25, 2014 at 11:10 PM
--

DROP TABLE IF EXISTS `contract`;
CREATE TABLE IF NOT EXISTS `contract` (
  `uuid` varchar(255) NOT NULL,
  `requestor` varchar(255) NOT NULL,
  `duration` int(11) NOT NULL,
  `reward` int(11) NOT NULL,
  `difficulty` int(11) NOT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  `message` mediumtext NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contract`
--

INSERT INTO `contract` (`uuid`, `requestor`, `duration`, `reward`, `difficulty`, `state`, `message`) VALUES
('3C7752E0-5C8B-11E4-8ED6-0800200C9A66', 'Requestor', 5, 1300, 1, 0, 'Test contract 1'),
('58029010-5C8B-11E4-8ED6-0800200C9A66', 'Requestor', 2, 1000, 1, 1, 'Test contract 2');

-- --------------------------------------------------------

--
-- Table structure for table `contract_cost`
--
-- Creation: Oct 26, 2014 at 10:55 AM
-- Last update: Oct 26, 2014 at 10:55 AM
--

DROP TABLE IF EXISTS `contract_cost`;
CREATE TABLE IF NOT EXISTS `contract_cost` (
  `contract_uuid` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`contract_uuid`,`rank`,`amount`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contract_cost`
--


-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--
-- Creation: Oct 26, 2014 at 12:41 PM
-- Last update: Oct 26, 2014 at 12:41 PM
--

DROP TABLE IF EXISTS `equipment`;
CREATE TABLE IF NOT EXISTS `equipment` (
  `uuid` varchar(255) NOT NULL,
  `hp` int(11) NOT NULL,
  `damage` int(11) NOT NULL,
  `defence` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unique` tinyint(1) NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `icon` varchar(255) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `equipment`
--


-- --------------------------------------------------------

--
-- Table structure for table `guild`
--
-- Creation: Oct 23, 2014 at 03:46 PM
-- Last update: Oct 23, 2014 at 05:09 PM
--

DROP TABLE IF EXISTS `guild`;
CREATE TABLE IF NOT EXISTS `guild` (
  `uuid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guild`
--

INSERT INTO `guild` (`uuid`, `name`) VALUES
('A1A58040-5AC6-11E4-8ED6-0800200C9A66', 'Guild 1');

-- --------------------------------------------------------

--
-- Table structure for table `guild_building`
--
-- Creation: Oct 25, 2014 at 11:31 PM
-- Last update: Oct 25, 2014 at 11:31 PM
--

DROP TABLE IF EXISTS `guild_building`;
CREATE TABLE IF NOT EXISTS `guild_building` (
  `guild_uuid` varchar(255) NOT NULL,
  `building_uuid` varchar(255) NOT NULL,
  PRIMARY KEY (`guild_uuid`,`building_uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guild_building`
--

INSERT INTO `guild_building` (`guild_uuid`, `building_uuid`) VALUES
('A1A58040-5AC6-11E4-8ED6-0800200C9A66', '95CB4BB0-5C8D-11E4-8ED6-0800200C9A66');

-- --------------------------------------------------------

--
-- Table structure for table `guild_contract`
--
-- Creation: Oct 25, 2014 at 10:51 PM
-- Last update: Oct 25, 2014 at 11:18 PM
--

DROP TABLE IF EXISTS `guild_contract`;
CREATE TABLE IF NOT EXISTS `guild_contract` (
  `guild_uuid` varchar(255) NOT NULL,
  `contract_uuid` varchar(255) NOT NULL,
  PRIMARY KEY (`guild_uuid`,`contract_uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guild_contract`
--

INSERT INTO `guild_contract` (`guild_uuid`, `contract_uuid`) VALUES
('A1A58040-5AC6-11E4-8ED6-0800200C9A66', '58029010-5C8B-11E4-8ED6-0800200C9A66');

-- --------------------------------------------------------

--
-- Table structure for table `guild_equipment`
--
-- Creation: Oct 26, 2014 at 10:50 AM
-- Last update: Oct 26, 2014 at 10:50 AM
--

DROP TABLE IF EXISTS `guild_equipment`;
CREATE TABLE IF NOT EXISTS `guild_equipment` (
  `guild_uuid` varchar(255) NOT NULL,
  `equipment_id` varchar(255) NOT NULL,
  PRIMARY KEY (`guild_uuid`,`equipment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guild_equipment`
--


-- --------------------------------------------------------

--
-- Table structure for table `guild_hero`
--
-- Creation: Oct 23, 2014 at 03:46 PM
-- Last update: Oct 25, 2014 at 09:18 PM
--

DROP TABLE IF EXISTS `guild_hero`;
CREATE TABLE IF NOT EXISTS `guild_hero` (
  `guild_uuid` varchar(255) NOT NULL,
  `hero_uuid` varchar(255) NOT NULL,
  PRIMARY KEY (`guild_uuid`,`hero_uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guild_hero`
--

INSERT INTO `guild_hero` (`guild_uuid`, `hero_uuid`) VALUES
('A1A58040-5AC6-11E4-8ED6-0800200C9A66', '7518E360-5AC5-11E4-8ED6-0800200C9A66');

-- --------------------------------------------------------

--
-- Table structure for table `hero`
--
-- Creation: Oct 23, 2014 at 03:44 PM
-- Last update: Oct 23, 2014 at 05:03 PM
--

DROP TABLE IF EXISTS `hero`;
CREATE TABLE IF NOT EXISTS `hero` (
  `uuid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hp` int(11) NOT NULL,
  `damage` int(11) NOT NULL,
  `experience` int(11) NOT NULL,
  `talent` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `defence` int(11) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hero`
--

INSERT INTO `hero` (`uuid`, `name`, `hp`, `damage`, `experience`, `talent`, `rank`, `age`, `defence`) VALUES
('7518E360-5AC5-11E4-8ED6-0800200C9A66', 'Test hero 1', 100, 10, 0, 4, 1, 21, 35),
('A4E18DE0-5AC5-11E4-8ED6-0800200C9A66', 'Test hero 2', 240, 35, 1432, 3, 3, 35, 85);

-- --------------------------------------------------------

--
-- Table structure for table `hero_equipment`
--
-- Creation: Oct 26, 2014 at 10:52 AM
-- Last update: Oct 26, 2014 at 10:52 AM
--

DROP TABLE IF EXISTS `hero_equipment`;
CREATE TABLE IF NOT EXISTS `hero_equipment` (
  `hero_uuid` varchar(255) NOT NULL,
  `equip_slot` int(11) NOT NULL,
  `equipment_id` varchar(255) NOT NULL,
  PRIMARY KEY (`hero_uuid`,`equip_slot`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hero_equipment`
--

