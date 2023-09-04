-- zaaktualizowana struktura tabeli mru_groups wraz z grupami

CREATE TABLE `mru_groups` (
  `UID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `ShortName` text NOT NULL,
  `Color` int(11) NOT NULL DEFAULT -1,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `a` float NOT NULL,
  `Int` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Flags` text NOT NULL DEFAULT '0',
  `Ranks` text NOT NULL DEFAULT '-',
  `Leader` int(11) NOT NULL,
  `vLeader` text NOT NULL DEFAULT '0',
  `Money` int(11) NOT NULL,
  `Mats` int(11) NOT NULL,
  `Skins` text NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `mru_groups`
--

INSERT INTO `mru_groups` (`UID`, `Name`, `ShortName`, `Color`, `x`, `y`, `z`, `a`, `Int`, `VW`, `Flags`, `Ranks`, `Leader`, `vLeader`, `Money`, `Mats`, `Skins`) VALUES
(1, 'Los Santos Police Department', 'LSPD', 1570955007, 1578.69, -1635.21, 13.5645, 356.811, 0, 0, '6,14,13,28,21', 'Cadet,Police Officer I,Police Officer II,-,-,-,-,-,-,-,-', 0, '0', 0, 175, '311,300,66'),
(2, 'Federal Bureau of Investigation', 'FBoI', 1, 600.955, -1490.7, 15.0571, 199.069, 0, 0, '6,14,13', '-', 0, '0', 0, 0, '5'),
(3, 'National Guards', 'NG', 1, 2689.13, -2366.78, 13.6328, 176.21, 0, 0, '6,14,13', '-', 0, '0', 0, 0, '0'),
(4, 'Los Santos Rescue Center', 'LSRC', -1, 1177.45, -1327.74, 14.0711, 186.043, 0, 0, '7,14,13,21', '-,-,-,-,-,-,-,-,-,-,Lider', 0, '0', 0, 0, '311,301,256,50,31'),
(5, 'Camorra', 'C', 1, 2730.32, -2451.21, 17.5937, 289.463, 0, 0, '8,13', '-', 0, '0', 0, 0, '0'),
(6, 'Yakuza', 'Y', 1, 2801.39, -1088.04, 30.7217, 179.427, 0, 0, '8,13', '-', 0, '0', 0, 0, '0'),
(7, 'United States Secret Service', 'USSS', 1, 1508.77, -1470.02, 14.2133, 286.286, 0, 41, '13', '-', 0, '0', 0, 0, '0'),
(8, 'Hitman Agency', 'HA', 1, -49.6947, -276.316, 5.42969, 177.586, 0, 0, '8,13', '-', 1, '0', 0, 0, '0'),
(9, 'San News', 'SN', 1, 732.954, -1341.47, 14.4214, 284.765, 0, 0, '11,13', '-', 1, '0', 0, 0, '0'),
(10, 'Korporacja Transportowa', 'KT', 1, 2487.71, -2093.4, 18.7579, 21.8746, 0, 33, '9,13', '-', 1, '0', 0, 0, '0'),
(11, 'Los Santos Government', 'LSG', -1, 1436.77, -1829.74, 58.6723, 270.677, 0, 51, '10,13', '-,-,-,-,-,-,-,-,-,-,-', 1, '0', 25, 0, '0'),
(12, 'Grove Street Families', 'GSF', 1, 2495.35, -1686.99, 13.5151, 0.896565, 0, 0, '8,13', '-', 1, '0', 0, 0, '0'),
(13, 'Uninvited guests', 'Ug', 1, 2149.87, -1286.29, 24.1965, 333.553, 0, 0, '8,13', '-', 1, '0', 0, 0, '0'),
(14, 'Ballas', 'B', 1, 1933.42, -1122.11, 26.3131, 177.987, 0, 0, '8,13', '-', 1, '0', 0, 0, '0'),
(15, 'Undetected', 'U', 1, 1093.76, -1194.46, 18.0981, 178.455, 0, 0, '3,8,13', '-', 1, '0', 0, 0, '0'),
(16, 'Freelancerzy', 'F', 1, 2422.24, -1749.59, 13.5469, 267.71, 0, 0, '8,13', '-', 1, '0', 0, 0, '0'),
(17, 'LSFD', 'LSFD', 1, 1756.92, -1122.9, 227.806, 82.8949, 0, 22, '12,14,13', '-', 1, '0', 0, 0, '0'),
(18, 'Ibiza Club', 'IC', 1, 403.516, -1801.61, 7.82812, 1.31537, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(19, 'Vinyl Club', 'VC', 1, 816.221, -1386.19, 13.5996, 46.9039, 0, 0, '16', '-', 1, '0', 0, 0, '0'),
(20, 'Solarin Industries', 'SI', 1, 807.156, -602.547, 16.3359, 246.955, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(21, 'Ammunation Los Santos', 'ALS', 1, 1795.24, -1166.7, 23.39, 158.311, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(22, 'Supreme Court of San Andreas', 'SCoSA', 1, 1309.86, -1368.97, 13.5557, 182.345, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(23, 'Event Team', 'ET', 1, 2569.66, -1122.28, 65.2784, 112.787, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(24, 'National Balla Association', 'NBA', 1, 1898.54, -1720.2, 13.531, 46.7901, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(25, 'The Lost MC', 'TLMC', 1, 270.088, 1.62426, 2.43583, 97.1374, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(26, 'Ammunation Willowfield', 'AW', 1, 2400.38, -1980.53, 13.5469, 345.289, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(27, 'Ammunation Commerce', 'AC', 1, 1706.08, -1502.75, 13.3828, 288.493, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(28, 'Leo country bar', 'Lcb', 1, 2110, -1807.12, 13.6504, 85.7699, 0, 0, '1', '-,-,-,-,-,-,-,-,-,-,-', 2, '1,2', 0, 0, '0'),
(29, 'santos customs', 'c', 1, 1767.76, -1677.2, 14.4097, 87.7789, 0, 12, '0', '-', 1, '0', 0, 0, '0'),
(30, 'Pimp Your Ride Workshop', 'PYRW', 1, 1015.86, -1369.52, 13.3738, 45.3346, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(31, 'Islamic State of Iraq and Syria', 'ISoIaS', 1, -798.207, 1553.28, 27.1172, 99.7475, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(32, 'Pimp Your Ride Workshop', 'PYRW', 1, 2331.08, -1228.07, 22.5, 284.028, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(33, 'the playboy players', 'pp', 1, 2755.85, -1180.47, 69.3984, 359.361, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(34, 'Companeros Del Diablo', 'CDD', 1, 2217.6, -1167.97, 25.7266, 37.8389, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(35, 'Guerrilla Family gang uliczny', 'GFgu', 1, 2526.89, -2009.36, 13.554, 86.7296, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(36, 'Promienna 13\'', 'P13\'', 1, 2780.93, -1985.11, 13.5559, 159.252, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(37, 'Grove Street Families', 'GSF', 1, 2495.17, -1687.51, 13.5153, 352.916, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(38, 'Ku Klux Klan', 'KKK', 1, 1022.61, -308.836, 73.9931, 127.381, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(39, 'Camorra Family', 'CF', 1, 2806.34, -1087.44, 30.7337, 90.4364, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(40, 'islamic state of iraq and syria', 'soias', 1, 881.599, -21.9463, 63.207, 118.11, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(41, 'RUSSKAYA KOPMANIYA', 'RUSSKAYAKOPMANIYA', 1, 277.688, -1433.32, 13.8986, 27.8118, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(42, 'The Blackwoods Crew', 'TBC', 1, 1940.8, -2115.86, 13.6953, 273.124, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(43, 'Vagos Bandits', 'VB', 1, 1603.69, -1219.63, 17.4754, 248.456, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(44, 'Rix 77\\\' Carte', 'R77\\\'C', 1, 2047.06, -2046.66, 13.5469, 252.498, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(45, 'Promienna', 'P', 1, 2761.1, -1946.28, 13.5469, 246.13, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(46, 'Nieuzywane', 'N', 1, 1023.83, -307.679, 73.9931, 64.3531, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(47, 'Son\\\'s Of Nicodem', 'S\\\'ON', 1, 1491.79, -1140.99, 24.0781, 294.35, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(48, 'LS Auto Center', 'LSAC', 1, 1872.32, -1689.7, 13.5889, 35.8273, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(49, 'Vegas Club', 'VC', 1, 1846.51, -1743.74, 13.5469, 250.882, 0, 0, '0', '-', 1, '0', 0, 0, '0'),
(50, 'Khadahal Clan', 'KC', 1, 1983.31, -1580.19, 13.5507, 272.889, 0, 0, '0', '-', 1, '0', 0, 0, '0');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `mru_groups`
--
ALTER TABLE `mru_groups`
  ADD PRIMARY KEY (`UID`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `mru_groups`
--
ALTER TABLE `mru_groups`
  MODIFY `UID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
COMMIT;