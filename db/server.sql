-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Wrz 05, 2023 at 12:32 AM
-- Wersja serwera: 8.0.34-0ubuntu0.22.04.1
-- Wersja PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `old`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ibiza`
--

CREATE TABLE `ibiza` (
  `id` int NOT NULL,
  `hajs` int DEFAULT NULL,
  `opis` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ibizadrinki`
--

CREATE TABLE `ibizadrinki` (
  `id` int NOT NULL,
  `cena` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_aktorzy`
--

CREATE TABLE `mru_aktorzy` (
  `uid` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `skin` smallint UNSIGNED NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `vw` smallint UNSIGNED NOT NULL,
  `angle` float NOT NULL,
  `anim` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_anims`
--

CREATE TABLE `mru_anims` (
  `uid` smallint UNSIGNED NOT NULL,
  `cmd` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `lib` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `speed` float NOT NULL,
  `loop/sa` tinyint NOT NULL,
  `lockx` tinyint NOT NULL,
  `locky` tinyint NOT NULL,
  `freeze` tinyint NOT NULL,
  `time` smallint NOT NULL,
  `action` tinyint UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_attached`
--

CREATE TABLE `mru_attached` (
  `UID` int NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `sx` float NOT NULL,
  `sy` float NOT NULL,
  `sz` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_bany`
--

CREATE TABLE `mru_bany` (
  `UID` int NOT NULL,
  `IP` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL DEFAULT 'nieznane',
  `dostal_uid` int NOT NULL DEFAULT '0',
  `dostal` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL DEFAULT 'brak',
  `nadal_uid` int NOT NULL DEFAULT '0',
  `nadal` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'SYSTEM DEFAULT',
  `czas` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `typ` int NOT NULL DEFAULT '0',
  `powod` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'Brak'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_bilboard`
--

CREATE TABLE `mru_bilboard` (
  `uid` int NOT NULL,
  `posx` float NOT NULL DEFAULT '0',
  `posy` float NOT NULL DEFAULT '0',
  `posz` float NOT NULL DEFAULT '0',
  `rotx` float NOT NULL DEFAULT '0',
  `roty` float NOT NULL DEFAULT '0',
  `rotz` float NOT NULL DEFAULT '0',
  `text` varchar(256) NOT NULL DEFAULT 'Do wynajêcia',
  `time` int NOT NULL DEFAULT '-1',
  `cost` int NOT NULL DEFAULT '0',
  `rentuid` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_bramy`
--

CREATE TABLE `mru_bramy` (
  `UID` int NOT NULL,
  `model` int NOT NULL,
  `object_x` float NOT NULL,
  `object_y` float NOT NULL,
  `object_z` float NOT NULL,
  `object_rx` float NOT NULL,
  `object_ry` float NOT NULL,
  `object_rz` float NOT NULL,
  `object_x2` float NOT NULL,
  `object_y2` float NOT NULL,
  `object_z2` float NOT NULL,
  `object_rx2` float NOT NULL,
  `object_ry2` float NOT NULL,
  `object_rz2` float NOT NULL,
  `speed` float NOT NULL,
  `range` float NOT NULL,
  `perm_type` int NOT NULL,
  `perm_id` int NOT NULL,
  `object_vw` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_business`
--

CREATE TABLE `mru_business` (
  `ID` int NOT NULL,
  `ownerUID` int NOT NULL,
  `ownerName` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `Name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `enX` float NOT NULL,
  `enY` float NOT NULL,
  `enZ` float NOT NULL,
  `exX` float NOT NULL,
  `exY` float NOT NULL,
  `exZ` float NOT NULL,
  `exVW` int NOT NULL,
  `exINT` int NOT NULL,
  `pLocal` int NOT NULL,
  `Money` int NOT NULL,
  `Cost` int NOT NULL,
  `Location` varchar(64) NOT NULL,
  `MoneyPocket` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_cars`
--

CREATE TABLE `mru_cars` (
  `UID` int NOT NULL,
  `ownertype` int NOT NULL DEFAULT '0' COMMENT 'INVALID 0 | FRACTION 1 | FAMILY 2 | PLAYER 3 | JOB 4 | SPECIAL 5 | PUBLIC  6 |',
  `owner` int NOT NULL DEFAULT '0',
  `model` int NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `angle` float NOT NULL DEFAULT '0',
  `hp` float NOT NULL DEFAULT '1000',
  `tires` int NOT NULL DEFAULT '0',
  `color1` int NOT NULL DEFAULT '0',
  `color2` int NOT NULL DEFAULT '0',
  `nitro` int NOT NULL DEFAULT '0',
  `hydraulika` tinyint(1) NOT NULL DEFAULT '0',
  `felgi` int NOT NULL DEFAULT '0',
  `malunek` int NOT NULL DEFAULT '3',
  `spoiler` int NOT NULL DEFAULT '0',
  `bumper1` int NOT NULL DEFAULT '0',
  `bumper2` int NOT NULL DEFAULT '0',
  `keys` int NOT NULL DEFAULT '0',
  `neon` int NOT NULL DEFAULT '0',
  `ranga` int NOT NULL DEFAULT '0',
  `int` int NOT NULL DEFAULT '-1',
  `vw` int NOT NULL DEFAULT '-1',
  `Rejestracja` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL DEFAULT '',
  `sideskirt` int NOT NULL DEFAULT '0',
  `hood` int NOT NULL DEFAULT '0',
  `exhaust` int NOT NULL DEFAULT '0',
  `vent` int NOT NULL DEFAULT '0',
  `lamps` int NOT NULL DEFAULT '0',
  `roof` int NOT NULL DEFAULT '0',
  `siren` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_ceny_pojazdy`
--

CREATE TABLE `mru_ceny_pojazdy` (
  `uid` int NOT NULL,
  `nazwa_ceny` text CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `cena` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_config`
--

CREATE TABLE `mru_config` (
  `san1` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `san2` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `gangzone` int NOT NULL,
  `gangtimedelay` int NOT NULL,
  `login_audio` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `stanowe_key` int NOT NULL,
  `trucker_magazyn` int NOT NULL,
  `wosp` int NOT NULL,
  `changelog` text CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_discord`
--

CREATE TABLE `mru_discord` (
  `id` int NOT NULL,
  `type` tinyint NOT NULL DEFAULT '0',
  `org_id` tinyint NOT NULL DEFAULT '0',
  `channel_id` varchar(64) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_diseases`
--

CREATE TABLE `mru_diseases` (
  `uid` int NOT NULL,
  `disease` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_frakcje`
--

CREATE TABLE `mru_frakcje` (
  `UID` int NOT NULL DEFAULT '0',
  `Name` varchar(64) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `a` float NOT NULL DEFAULT '0',
  `Int` int NOT NULL DEFAULT '0',
  `VW` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_graffiti`
--

CREATE TABLE `mru_graffiti` (
  `id` int NOT NULL,
  `ownerName` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `text` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `kolor` smallint NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `xy` float NOT NULL,
  `yy` float NOT NULL,
  `zy` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_groups`
--

CREATE TABLE `mru_groups` (
  `UID` int NOT NULL,
  `Name` text NOT NULL,
  `ShortName` text NOT NULL,
  `Color` int NOT NULL DEFAULT '-1',
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `a` float NOT NULL,
  `Int` int NOT NULL,
  `VW` int NOT NULL,
  `Flags` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Ranks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Leader` int NOT NULL DEFAULT '0',
  `vLeader` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Money` int NOT NULL DEFAULT '0',
  `Mats` int NOT NULL DEFAULT '0',
  `Skins` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `MaxDuty` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_items`
--

CREATE TABLE `mru_items` (
  `UID` int NOT NULL,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `X` float NOT NULL DEFAULT '0',
  `Y` float NOT NULL DEFAULT '0',
  `Z` float NOT NULL DEFAULT '0',
  `vw` int NOT NULL DEFAULT '0',
  `int` int NOT NULL DEFAULT '0',
  `dropped` int NOT NULL DEFAULT '0',
  `owner_type` int NOT NULL DEFAULT '1',
  `owner` int NOT NULL DEFAULT '0',
  `item_type` int NOT NULL DEFAULT '0',
  `value1` int NOT NULL DEFAULT '0',
  `value2` int NOT NULL DEFAULT '0',
  `used` int NOT NULL DEFAULT '0',
  `quantity` int NOT NULL DEFAULT '1',
  `server_id` int NOT NULL DEFAULT '0',
  `secretValue` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_kary`
--

CREATE TABLE `mru_kary` (
  `penalty_id` int NOT NULL,
  `player_uid` int NOT NULL,
  `player_gid` int NOT NULL,
  `player_ip` varchar(32) NOT NULL DEFAULT 'nieznane',
  `admin_uid` int NOT NULL,
  `admin_gid` int NOT NULL,
  `time` int NOT NULL,
  `type` int NOT NULL,
  `value` int NOT NULL,
  `reason` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_kary_bany`
--

CREATE TABLE `mru_kary_bany` (
  `ban_id` int NOT NULL,
  `ip` varchar(32) NOT NULL,
  `player_global_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_konta`
--

CREATE TABLE `mru_konta` (
  `UID` int UNSIGNED NOT NULL,
  `Nick` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `Key` varchar(129) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `Salt` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL DEFAULT '',
  `Level` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `Admin` smallint UNSIGNED NOT NULL DEFAULT '0',
  `DonateRank` tinyint NOT NULL DEFAULT '0',
  `UpgradePoints` smallint UNSIGNED NOT NULL DEFAULT '0',
  `ConnectedTime` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Registered` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Sex` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Age` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Origin` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `CK` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Muted` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Respect` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Money` int NOT NULL DEFAULT '0',
  `Bank` int NOT NULL DEFAULT '0',
  `Crimes` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Kills` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Deaths` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Arrested` smallint UNSIGNED NOT NULL DEFAULT '0',
  `WantedDeaths` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Phonebook` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `LottoNr` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Fishes` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `BiggestFish` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Job` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Paycheck` int NOT NULL DEFAULT '0',
  `HeadValue` int NOT NULL DEFAULT '0',
  `BlokadaPisania` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Jailed` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `AJreason` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL DEFAULT 'Brak (stary system)',
  `JailTime` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Materials` int UNSIGNED NOT NULL DEFAULT '0',
  `Drugs` int UNSIGNED NOT NULL DEFAULT '0',
  `Lider` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Member` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `FMember` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Rank` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Char` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Skin` smallint UNSIGNED NOT NULL DEFAULT '0',
  `JobSkin` int NOT NULL DEFAULT '0',
  `ContractTime` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `DetSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `SexSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `BoxSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `LawSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `MechSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `JackSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `CarSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `NewsSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `DrugsSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `CookSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `FishSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `GunSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `TruckSkill` smallint UNSIGNED NOT NULL DEFAULT '0',
  `PizzaboySkill` smallint NOT NULL DEFAULT '0',
  `pSHealth` float NOT NULL DEFAULT '0',
  `pHealth` float NOT NULL DEFAULT '0',
  `VW` int NOT NULL DEFAULT '0',
  `Int` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Compensation` int NOT NULL DEFAULT '0',
  `Local` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Team` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Model` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Dom` int NOT NULL DEFAULT '0',
  `Bizz` int NOT NULL DEFAULT '255',
  `BizzMember` int NOT NULL DEFAULT '-1',
  `Wynajem` int NOT NULL DEFAULT '0',
  `Pos_x` float NOT NULL DEFAULT '0',
  `Pos_y` float NOT NULL DEFAULT '0',
  `Pos_z` float NOT NULL DEFAULT '0',
  `CarLic` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `FlyLic` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `BoatLic` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `FishLic` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `GunLic` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun0` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun1` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun2` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun3` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun4` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun5` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun6` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun7` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun8` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun9` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun10` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun11` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Gun12` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo0` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo1` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo2` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo3` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo4` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo5` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo6` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo7` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo8` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo9` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo10` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo11` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Ammo12` smallint UNSIGNED NOT NULL DEFAULT '0',
  `CarTime` int NOT NULL DEFAULT '0',
  `PayDay` int NOT NULL DEFAULT '0',
  `PayDayHad` int NOT NULL DEFAULT '0',
  `CDPlayer` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Wins` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Loses` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `AlcoholPerk` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `DrugPerk` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `MiserPerk` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `PainPerk` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `TraderPerk` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Tutorial` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Mission` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Warnings` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Block` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Fuel` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Married` int NOT NULL DEFAULT '0',
  `MarriedTo` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL DEFAULT 'Nikt',
  `CBRADIO` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `PoziomPoszukiwania` int NOT NULL DEFAULT '0',
  `Dowod` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `PodszywanieSie` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `ZmienilNick` tinyint UNSIGNED NOT NULL DEFAULT '2',
  `PodgladWiadomosci` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `StylWalki` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `PAdmin` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `ZaufanyGracz` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `Uniform` int NOT NULL DEFAULT '0',
  `CruiseController` tinyint(1) NOT NULL DEFAULT '0',
  `FixKit` tinyint NOT NULL DEFAULT '0',
  `Auto1` int NOT NULL DEFAULT '0',
  `Auto2` int NOT NULL DEFAULT '0',
  `Auto3` int NOT NULL DEFAULT '0',
  `Auto4` int NOT NULL DEFAULT '0',
  `Lodz` int NOT NULL DEFAULT '0',
  `Samolot` int NOT NULL DEFAULT '0',
  `Garaz` int NOT NULL DEFAULT '0',
  `KluczykiDoAuta` int NOT NULL DEFAULT '0',
  `Spawn` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `BW` smallint UNSIGNED NOT NULL DEFAULT '0',
  `Czystka` smallint UNSIGNED NOT NULL DEFAULT '0',
  `CarSlots` tinyint UNSIGNED NOT NULL DEFAULT '4',
  `Immunity` int NOT NULL DEFAULT '0',
  `Hat` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `FW` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `connected` tinyint NOT NULL DEFAULT '0',
  `Injury` smallint NOT NULL DEFAULT '0',
  `HealthPacks` smallint NOT NULL DEFAULT '0',
  `Hunger` float NOT NULL DEFAULT '0',
  `Thirst` float NOT NULL DEFAULT '0',
  `motelEvict` int NOT NULL DEFAULT '0',
  `online` int NOT NULL DEFAULT '0',
  `fishCooldown` int NOT NULL DEFAULT '0',
  `DutyTime` int NOT NULL DEFAULT '0',
  `DutyCheck` int NOT NULL DEFAULT '0',
  `BlokadaBroni` int NOT NULL DEFAULT '0',
  `betatester` int NOT NULL DEFAULT '0',
  `lastver` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL DEFAULT 'v0.0.0',
  `temp` int NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `uid_forum` int DEFAULT NULL,
  `pOsiagniecia1` int DEFAULT NULL,
  `Mikolaj` int NOT NULL DEFAULT '0',
  `pOsiagniecia2` int DEFAULT NULL,
  `pOsiagniecia3` int DEFAULT NULL,
  `pOsiagniecia4` int DEFAULT NULL,
  `pOsiagniecia5` int DEFAULT NULL,
  `pPlayerEXP` int DEFAULT NULL,
  `ChangeNumber` int NOT NULL DEFAULT '0',
  `DeagleSkill` int NOT NULL DEFAULT '0',
  `ColtSkill` int NOT NULL DEFAULT '0',
  `SilencedSkill` int NOT NULL DEFAULT '0',
  `ShotgunSkill` int NOT NULL DEFAULT '0',
  `M4Skill` int NOT NULL DEFAULT '0',
  `AKSkill` int NOT NULL DEFAULT '0',
  `Grupa1` int NOT NULL DEFAULT '0',
  `Grupa2` int NOT NULL DEFAULT '0',
  `Grupa3` int NOT NULL DEFAULT '0',
  `Grupa1Rank` int NOT NULL DEFAULT '0',
  `Grupa2Rank` int NOT NULL DEFAULT '0',
  `Grupa3Rank` int NOT NULL DEFAULT '0',
  `Grupa1Skin` int NOT NULL DEFAULT '0',
  `Grupa2Skin` int NOT NULL DEFAULT '0',
  `Grupa3Skin` int NOT NULL DEFAULT '0',
  `GrupaSpawn` int NOT NULL DEFAULT '0',
  `Convert` int NOT NULL DEFAULT '0',
  `LastHP` float NOT NULL DEFAULT '50',
  `LastArmour` float NOT NULL DEFAULT '0',
  `NocOczyszczeniaKit` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_kontakty`
--

CREATE TABLE `mru_kontakty` (
  `UID` int NOT NULL,
  `Owner` int NOT NULL,
  `Number` int NOT NULL,
  `Name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_last_logons`
--

CREATE TABLE `mru_last_logons` (
  `Nick` varchar(21) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_liderzy`
--

CREATE TABLE `mru_liderzy` (
  `NICK` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `UID` int NOT NULL,
  `FracID` int NOT NULL DEFAULT '0',
  `LiderValue` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_logowania`
--

CREATE TABLE `mru_logowania` (
  `UID` bigint NOT NULL,
  `PID` int NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IP` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `gpci` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_logs_settings`
--

CREATE TABLE `mru_logs_settings` (
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` bit(8) NOT NULL DEFAULT b'0',
  `style` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dark',
  `online` int NOT NULL DEFAULT '0',
  `betterlogs` tinyint(1) NOT NULL DEFAULT '1',
  `rawlogs` tinyint(1) NOT NULL DEFAULT '0',
  `paging` tinyint(1) NOT NULL DEFAULT '1',
  `token` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_logs_settings_chat`
--

CREATE TABLE `mru_logs_settings_chat` (
  `ID` int NOT NULL,
  `date` timestamp NOT NULL,
  `name` varchar(64) NOT NULL,
  `text` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1250;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_mmat`
--

CREATE TABLE `mru_mmat` (
  `objectid` int NOT NULL,
  `materialindex` int NOT NULL,
  `modelid` int NOT NULL,
  `txdname` text NOT NULL,
  `texturename` text NOT NULL,
  `materialcolor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_motele`
--

CREATE TABLE `mru_motele` (
  `UID` smallint NOT NULL,
  `Name` varchar(64) NOT NULL DEFAULT 'Motel',
  `Rooms` smallint NOT NULL DEFAULT '-1',
  `Occupied` smallint NOT NULL DEFAULT '0',
  `Price` int NOT NULL DEFAULT '0',
  `PosX` float NOT NULL DEFAULT '0',
  `PosY` float NOT NULL DEFAULT '0',
  `PosZ` float NOT NULL DEFAULT '0',
  `VW` int NOT NULL DEFAULT '0',
  `Interior` int NOT NULL DEFAULT '0',
  `InX` float NOT NULL DEFAULT '0',
  `InY` float NOT NULL DEFAULT '0',
  `InZ` float NOT NULL DEFAULT '0',
  `InVW` int NOT NULL DEFAULT '0',
  `InInterior` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_motele_rooms`
--

CREATE TABLE `mru_motele_rooms` (
  `UID` int NOT NULL,
  `MotelUID` smallint NOT NULL DEFAULT '0',
  `RoomNum` smallint NOT NULL DEFAULT '0',
  `Interior` smallint NOT NULL DEFAULT '0',
  `OwnerUID` int NOT NULL DEFAULT '0',
  `Doors` smallint NOT NULL DEFAULT '0',
  `LastOnline` varchar(32) NOT NULL DEFAULT '0.0.0000',
  `PayOffline` int NOT NULL DEFAULT '0',
  `Access` varchar(256) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_napady`
--

CREATE TABLE `mru_napady` (
  `UID` int NOT NULL,
  `Name` text NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL DEFAULT '0',
  `RY` float NOT NULL DEFAULT '0',
  `RZ` float NOT NULL DEFAULT '0',
  `VW` int NOT NULL,
  `INT` int NOT NULL,
  `Cash` int NOT NULL DEFAULT '5000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_nazwyrang`
--

CREATE TABLE `mru_nazwyrang` (
  `ID` int NOT NULL,
  `typ` int NOT NULL COMMENT '1 - frakcja 2 - rodzina',
  `rangi` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL COMMENT 'Skompresowane nazwy rang'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_obiekty`
--

CREATE TABLE `mru_obiekty` (
  `UID` int NOT NULL,
  `model` int NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `vw` int NOT NULL DEFAULT '0',
  `o_int` int NOT NULL DEFAULT '0',
  `ownertype` int NOT NULL COMMENT '1 = admin',
  `owner` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_opisy`
--

CREATE TABLE `mru_opisy` (
  `UID` int NOT NULL,
  `typ` int NOT NULL,
  `owner` int NOT NULL,
  `desc` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_org`
--

CREATE TABLE `mru_org` (
  `ID` int NOT NULL,
  `UID` int NOT NULL,
  `Type` int NOT NULL,
  `Name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `Motd` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci DEFAULT '0',
  `Color` int UNSIGNED NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `a` float NOT NULL DEFAULT '0',
  `Int` int NOT NULL DEFAULT '0',
  `VW` int NOT NULL DEFAULT '0',
  `flags` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_personalization`
--

CREATE TABLE `mru_personalization` (
  `UID` int NOT NULL,
  `KontoBankowe` tinyint(1) NOT NULL DEFAULT '0',
  `Ogloszenia` tinyint(1) NOT NULL DEFAULT '0',
  `LicznikPojazdu` tinyint(1) NOT NULL DEFAULT '0',
  `OgloszeniaFrakcji` tinyint(1) NOT NULL DEFAULT '0',
  `OgloszeniaRodzin` tinyint(1) NOT NULL DEFAULT '0',
  `OldNick` tinyint(1) NOT NULL DEFAULT '0',
  `CBRadio` tinyint(1) NOT NULL DEFAULT '0',
  `Report` tinyint(1) DEFAULT '0',
  `DeathWarning` tinyint(1) NOT NULL DEFAULT '0',
  `KaryTXD` tinyint(1) NOT NULL DEFAULT '0',
  `NewNick` tinyint(1) NOT NULL DEFAULT '0',
  `newbie` tinyint(1) NOT NULL DEFAULT '0',
  `BronieScroll` tinyint(1) NOT NULL DEFAULT '0',
  `AnimacjaMowienia` tinyint(1) NOT NULL DEFAULT '0',
  `JoinLeave` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_playeritems`
--

CREATE TABLE `mru_playeritems` (
  `id` int NOT NULL,
  `UID` int NOT NULL,
  `model` int NOT NULL,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `rx` float NOT NULL DEFAULT '0',
  `ry` float NOT NULL DEFAULT '0',
  `rz` float NOT NULL DEFAULT '0',
  `sx` float NOT NULL DEFAULT '1',
  `sy` float NOT NULL DEFAULT '1',
  `sz` float NOT NULL DEFAULT '1',
  `bone` int NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_premium`
--

CREATE TABLE `mru_premium` (
  `p_charUID` int NOT NULL,
  `p_MC` int NOT NULL DEFAULT '0',
  `p_startDate` datetime DEFAULT NULL,
  `p_endDate` datetime DEFAULT NULL,
  `p_LastCheck` datetime DEFAULT NULL,
  `p_activeKp` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_premium_skins`
--

CREATE TABLE `mru_premium_skins` (
  `s_charUID` int NOT NULL,
  `s_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_products`
--

CREATE TABLE `mru_products` (
  `UID` int NOT NULL,
  `orgID` int NOT NULL DEFAULT '0',
  `product_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  `value1` int NOT NULL DEFAULT '0',
  `value2` int NOT NULL DEFAULT '0',
  `item_type` int NOT NULL,
  `quant` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_rodziny`
--

CREATE TABLE `mru_rodziny` (
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL,
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_ryby`
--

CREATE TABLE `mru_ryby` (
  `Player` int NOT NULL,
  `Fish1` varchar(20) NOT NULL DEFAULT 'None',
  `Fish2` varchar(20) NOT NULL DEFAULT 'None',
  `Fish3` varchar(20) NOT NULL DEFAULT 'None',
  `Fish4` varchar(20) NOT NULL DEFAULT 'None',
  `Fish5` varchar(20) NOT NULL DEFAULT 'None',
  `Weight1` int NOT NULL DEFAULT '0',
  `Weight2` int NOT NULL DEFAULT '0',
  `Weight3` int NOT NULL DEFAULT '0',
  `Weight4` int NOT NULL DEFAULT '0',
  `Weight5` int NOT NULL DEFAULT '0',
  `Fid1` int NOT NULL DEFAULT '0',
  `Fid2` int NOT NULL DEFAULT '0',
  `Fid3` int NOT NULL DEFAULT '0',
  `Fid4` int NOT NULL DEFAULT '0',
  `Fid5` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_sejfy`
--

CREATE TABLE `mru_sejfy` (
  `ID` int NOT NULL,
  `typ` int NOT NULL,
  `kasa` int NOT NULL,
  `matsy` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_serverinfo`
--

CREATE TABLE `mru_serverinfo` (
  `aktywne` int NOT NULL,
  `info` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_skins`
--

CREATE TABLE `mru_skins` (
  `typ` int NOT NULL,
  `id` int NOT NULL,
  `skins` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_strefy`
--

CREATE TABLE `mru_strefy` (
  `id` int NOT NULL,
  `gang` int NOT NULL,
  `expire` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_strefylimit`
--

CREATE TABLE `mru_strefylimit` (
  `gang` int NOT NULL,
  `data` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_tattoo`
--

CREATE TABLE `mru_tattoo` (
  `UID` int NOT NULL,
  `ID` int NOT NULL,
  `offsetX` float NOT NULL,
  `offsetY` float NOT NULL,
  `offsetZ` float NOT NULL,
  `rX` float NOT NULL,
  `rY` float NOT NULL,
  `rZ` float NOT NULL,
  `bone` int NOT NULL,
  `owner` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mru_uprawnienia`
--

CREATE TABLE `mru_uprawnienia` (
  `UID` int NOT NULL,
  `FLAGS` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_polish_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `ibiza`
--
ALTER TABLE `ibiza`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `ibizadrinki`
--
ALTER TABLE `ibizadrinki`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `mru_aktorzy`
--
ALTER TABLE `mru_aktorzy`
  ADD PRIMARY KEY (`uid`);

--
-- Indeksy dla tabeli `mru_anims`
--
ALTER TABLE `mru_anims`
  ADD PRIMARY KEY (`uid`);

--
-- Indeksy dla tabeli `mru_attached`
--
ALTER TABLE `mru_attached`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_bany`
--
ALTER TABLE `mru_bany`
  ADD PRIMARY KEY (`UID`),
  ADD KEY `dostal_uid` (`dostal_uid`),
  ADD KEY `IP` (`IP`);

--
-- Indeksy dla tabeli `mru_bilboard`
--
ALTER TABLE `mru_bilboard`
  ADD PRIMARY KEY (`uid`);

--
-- Indeksy dla tabeli `mru_bramy`
--
ALTER TABLE `mru_bramy`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_business`
--
ALTER TABLE `mru_business`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ownerUID` (`ownerUID`);

--
-- Indeksy dla tabeli `mru_cars`
--
ALTER TABLE `mru_cars`
  ADD PRIMARY KEY (`UID`),
  ADD KEY `owner` (`owner`),
  ADD KEY `ownertype` (`ownertype`);

--
-- Indeksy dla tabeli `mru_ceny_pojazdy`
--
ALTER TABLE `mru_ceny_pojazdy`
  ADD PRIMARY KEY (`uid`);

--
-- Indeksy dla tabeli `mru_discord`
--
ALTER TABLE `mru_discord`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `mru_diseases`
--
ALTER TABLE `mru_diseases`
  ADD PRIMARY KEY (`uid`,`disease`);

--
-- Indeksy dla tabeli `mru_frakcje`
--
ALTER TABLE `mru_frakcje`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_graffiti`
--
ALTER TABLE `mru_graffiti`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `mru_groups`
--
ALTER TABLE `mru_groups`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_items`
--
ALTER TABLE `mru_items`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_kary`
--
ALTER TABLE `mru_kary`
  ADD PRIMARY KEY (`penalty_id`);

--
-- Indeksy dla tabeli `mru_kary_bany`
--
ALTER TABLE `mru_kary_bany`
  ADD PRIMARY KEY (`ban_id`);

--
-- Indeksy dla tabeli `mru_konta`
--
ALTER TABLE `mru_konta`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `Nick` (`Nick`);

--
-- Indeksy dla tabeli `mru_kontakty`
--
ALTER TABLE `mru_kontakty`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_last_logons`
--
ALTER TABLE `mru_last_logons`
  ADD PRIMARY KEY (`Nick`);

--
-- Indeksy dla tabeli `mru_liderzy`
--
ALTER TABLE `mru_liderzy`
  ADD PRIMARY KEY (`UID`),
  ADD KEY `FracID` (`FracID`);

--
-- Indeksy dla tabeli `mru_logowania`
--
ALTER TABLE `mru_logowania`
  ADD PRIMARY KEY (`UID`),
  ADD KEY `PID` (`PID`);

--
-- Indeksy dla tabeli `mru_logs_settings`
--
ALTER TABLE `mru_logs_settings`
  ADD PRIMARY KEY (`name`);

--
-- Indeksy dla tabeli `mru_logs_settings_chat`
--
ALTER TABLE `mru_logs_settings_chat`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `mru_mmat`
--
ALTER TABLE `mru_mmat`
  ADD PRIMARY KEY (`objectid`);

--
-- Indeksy dla tabeli `mru_motele`
--
ALTER TABLE `mru_motele`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_motele_rooms`
--
ALTER TABLE `mru_motele_rooms`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_napady`
--
ALTER TABLE `mru_napady`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_nazwyrang`
--
ALTER TABLE `mru_nazwyrang`
  ADD PRIMARY KEY (`ID`,`typ`),
  ADD KEY `ID` (`ID`);

--
-- Indeksy dla tabeli `mru_obiekty`
--
ALTER TABLE `mru_obiekty`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_opisy`
--
ALTER TABLE `mru_opisy`
  ADD PRIMARY KEY (`UID`),
  ADD KEY `owner` (`owner`);

--
-- Indeksy dla tabeli `mru_org`
--
ALTER TABLE `mru_org`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UID` (`UID`);

--
-- Indeksy dla tabeli `mru_personalization`
--
ALTER TABLE `mru_personalization`
  ADD PRIMARY KEY (`UID`),
  ADD KEY `UID` (`UID`);

--
-- Indeksy dla tabeli `mru_playeritems`
--
ALTER TABLE `mru_playeritems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UID` (`UID`);

--
-- Indeksy dla tabeli `mru_premium`
--
ALTER TABLE `mru_premium`
  ADD PRIMARY KEY (`p_charUID`);

--
-- Indeksy dla tabeli `mru_premium_skins`
--
ALTER TABLE `mru_premium_skins`
  ADD PRIMARY KEY (`s_charUID`,`s_ID`);

--
-- Indeksy dla tabeli `mru_products`
--
ALTER TABLE `mru_products`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_rodziny`
--
ALTER TABLE `mru_rodziny`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `mru_ryby`
--
ALTER TABLE `mru_ryby`
  ADD PRIMARY KEY (`Player`);

--
-- Indeksy dla tabeli `mru_sejfy`
--
ALTER TABLE `mru_sejfy`
  ADD PRIMARY KEY (`ID`,`typ`),
  ADD KEY `ID` (`ID`);

--
-- Indeksy dla tabeli `mru_skins`
--
ALTER TABLE `mru_skins`
  ADD PRIMARY KEY (`typ`,`id`),
  ADD KEY `id` (`id`);

--
-- Indeksy dla tabeli `mru_strefy`
--
ALTER TABLE `mru_strefy`
  ADD KEY `id` (`id`);

--
-- Indeksy dla tabeli `mru_strefylimit`
--
ALTER TABLE `mru_strefylimit`
  ADD KEY `gang` (`gang`);

--
-- Indeksy dla tabeli `mru_tattoo`
--
ALTER TABLE `mru_tattoo`
  ADD PRIMARY KEY (`UID`);

--
-- Indeksy dla tabeli `mru_uprawnienia`
--
ALTER TABLE `mru_uprawnienia`
  ADD PRIMARY KEY (`UID`),
  ADD KEY `UID` (`UID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mru_anims`
--
ALTER TABLE `mru_anims`
  MODIFY `uid` smallint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_bany`
--
ALTER TABLE `mru_bany`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_bilboard`
--
ALTER TABLE `mru_bilboard`
  MODIFY `uid` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_bramy`
--
ALTER TABLE `mru_bramy`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_business`
--
ALTER TABLE `mru_business`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_cars`
--
ALTER TABLE `mru_cars`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_ceny_pojazdy`
--
ALTER TABLE `mru_ceny_pojazdy`
  MODIFY `uid` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_discord`
--
ALTER TABLE `mru_discord`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_groups`
--
ALTER TABLE `mru_groups`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_items`
--
ALTER TABLE `mru_items`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_kary`
--
ALTER TABLE `mru_kary`
  MODIFY `penalty_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_kary_bany`
--
ALTER TABLE `mru_kary_bany`
  MODIFY `ban_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_konta`
--
ALTER TABLE `mru_konta`
  MODIFY `UID` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_kontakty`
--
ALTER TABLE `mru_kontakty`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_logowania`
--
ALTER TABLE `mru_logowania`
  MODIFY `UID` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_logs_settings_chat`
--
ALTER TABLE `mru_logs_settings_chat`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_motele`
--
ALTER TABLE `mru_motele`
  MODIFY `UID` smallint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_motele_rooms`
--
ALTER TABLE `mru_motele_rooms`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_napady`
--
ALTER TABLE `mru_napady`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_obiekty`
--
ALTER TABLE `mru_obiekty`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_opisy`
--
ALTER TABLE `mru_opisy`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_org`
--
ALTER TABLE `mru_org`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_playeritems`
--
ALTER TABLE `mru_playeritems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_products`
--
ALTER TABLE `mru_products`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mru_tattoo`
--
ALTER TABLE `mru_tattoo`
  MODIFY `UID` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
