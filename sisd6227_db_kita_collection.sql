-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 26, 2023 at 09:24 AM
-- Server version: 10.2.44-MariaDB-cll-lve
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sisd6227_db_kita_collection`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `username` varchar(16) NOT NULL,
  `password` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`username`, `password`) VALUES
('adm', 'f5bb0c8de146c67b44babbf4e6584cc0');

-- --------------------------------------------------------

--
-- Table structure for table `favorit`
--

CREATE TABLE `favorit` (
  `id_favorit` int(5) NOT NULL,
  `id_shoes` int(5) NOT NULL,
  `id_user` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favorit`
--

INSERT INTO `favorit` (`id_favorit`, `id_shoes`, `id_user`) VALUES
(37, 46, 17),
(43, 46, 4),
(45, 44, 17);

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id_keranjang` int(3) NOT NULL,
  `id_user` int(5) NOT NULL,
  `id_shoes` int(5) NOT NULL,
  `quantity` int(5) NOT NULL,
  `size` varchar(10) NOT NULL,
  `color` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`id_keranjang`, `id_user`, `id_shoes`, `quantity`, `size`, `color`) VALUES
(48, 18, 46, 1, ' 41 ', 'Grey'),
(54, 18, 45, 1, '38 ', 'navy'),
(55, 18, 44, 1, '38', 'White'),
(57, 16, 45, 1, '  42', 'navy'),
(68, 4, 49, 1, ' 41', 'orange'),
(69, 4, 48, 1, ' 40', 'Yellow'),
(70, 4, 49, 1, ' 40', 'orange');

-- --------------------------------------------------------

--
-- Table structure for table `shoes`
--

CREATE TABLE `shoes` (
  `id_shoes` int(5) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `label` text NOT NULL,
  `price` double NOT NULL,
  `colors` text NOT NULL,
  `description` text NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shoes`
--

INSERT INTO `shoes` (`id_shoes`, `nama_barang`, `label`, `price`, `colors`, `description`, `image`) VALUES
(44, 'Nike Air Force 1	', 'Nike', 550000, 'White', 'Nike Air Force 1 adalah sepatu basket Nike pertama yang menggunakan Air Sole Unit pada desainnya yang terletak di dalam soal bagian belakang.', '63b983ab71a0d.jpg'),
(45, 'Converse All Star Premium', 'Converse', 331500, 'navy', 'PREMIUM QUALITY Sepatu Converse All Star ', '63b3e332c16d5.jpg'),
(46, 'Adidas Alphabounce Instinct ', 'Adidas', 500000, 'Grey', 'Adidas Alphabounce adalah sepatu olahraga buatan Jerman yang nyaman digunakan, terutama untuk berlari.', '63b3e4422707b.jpg'),
(47, 'Slip on Adidas', 'Adidas', 150000, 'Red', 'Sandal slip on Adidas adalah sandal buatan Jerman yang nyaman digunakan.', '63b3e57e25280.jpg'),
(48, 'Fipper Classic', 'Fipper', 130000, 'Yellow', 'Sandal Fipper Classic adalah sandal buatan Fipper yang nyaman digunakan.', '63b97ffee2a9a.jpg'),
(49, 'Spiderman PVC', 'Spiderman', 30000, 'orange', 'sendal terbaik', '63bd7df2b71cb.png'),
(50, 'Nike ZoomX Vaporfly Next 2 Sneakers', 'Nike', 600000, 'Violet', 'Nike ZoomX', '63e110026e890.jpg'),
(51, 'Nike Air Jordan 1 Mid Ice Blue', 'Nike', 850000, 'Blue', 'Nike Air Jordan 1', '63e110ea681e3.jpg'),
(52, 'Birkenstock Franca Oiled Leather Regular', 'Birkenstock', 200000, 'Black', 'Birkenstock', '63e1125916d59.jpg'),
(53, 'Gucci Women Rubber', 'Gucci', 300000, 'White', 'Gucci', '63e11341ea255.jpg'),
(54, 'Puma 381172-08', 'Puma', 250000, 'Pink', 'Puma', '63e113fd1cb4f.jpg'),
(55, 'Loubi Flip Flat', 'Loubi', 80000, 'White', 'Loubi', '63e1147e4129b.jpg'),
(56, 'Nike X Billie Eilish Air Force 1', 'Nike', 900000, 'Black', ' Nike', '63e1153abf6f4.jpg'),
(58, 'Nike Testing', 'Nike', 300000, 'Black', 'Mike', '63e1ecc7ea5d8.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id_transactions` int(5) NOT NULL,
  `id_user` int(5) NOT NULL,
  `list_shop` text NOT NULL,
  `ekspedisi` varchar(50) NOT NULL,
  `pembayaran` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `total` double NOT NULL,
  `bukti` text NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp(),
  `arrived` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id_transactions`, `id_user`, `list_shop`, `ekspedisi`, `pembayaran`, `alamat`, `total`, `bukti`, `tanggal`, `arrived`) VALUES
(52, 4, '{\"id_shoes\":45,\"image\":\"63b3e332c16d5.jpg\",\"name\":\"Converse All Star Premium\",\"color\":\"navy\",\"size\":\"  40 \",\"quantity\":1,\"item_total\":331500.0}||{\"id_shoes\":49,\"image\":\"63bd7df2b71cb.png\",\"name\":\"Spiderman PVC\",\"color\":\"orange\",\"size\":\"42 \",\"quantity\":1,\"item_total\":30000.0}', 'JNE', 'Transfer Bank', 'asdasdasdasd', 361500, 'image_picker160230186.png', '2023-01-14 15:44:00', 'Arrived'),
(53, 4, '{\"id_shoes\":48,\"image\":\"63b97ffee2a9a.jpg\",\"name\":\"Fipper Classic\",\"color\":\"Yellow\",\"size\":\"38\",\"quantity\":1,\"item_total\":130000.0}', 'JNE', 'Transfer Bank', 'aa', 130000, 'image_picker1750417742.png', '2023-01-14 15:47:16', 'Arrived'),
(54, 4, '{\"id_shoes\":48,\"image\":\"63b97ffee2a9a.jpg\",\"name\":\"Fipper Classic\",\"color\":\"Yellow\",\"size\":\" 40\",\"quantity\":1,\"item_total\":130000.0}||{\"id_shoes\":49,\"image\":\"63bd7df2b71cb.png\",\"name\":\"Spiderman PVC\",\"color\":\"orange\",\"size\":\" 41\",\"quantity\":1,\"item_total\":30000.0}', 'JNE', 'Transfer Bank', 'dddd', 160000, 'image_picker1386102747.png', '2023-01-14 15:56:02', 'Arrived'),
(55, 4, '{\"id_shoes\":48,\"image\":\"63b97ffee2a9a.jpg\",\"name\":\"Fipper Classic\",\"color\":\"Yellow\",\"size\":\" 40\",\"quantity\":1,\"item_total\":130000.0}', 'Kita Ekspedisi       99999', 'Transfer Bank', '', 130000, 'image_picker1821991569.jpg', '2023-01-25 18:56:22', 'Arrived'),
(56, 6, '{\"id_shoes\":45,\"image\":\"63b3e332c16d5.jpg\",\"name\":\"Converse All Star Premium\",\"color\":\"navy\",\"size\":\"38 \",\"quantity\":1,\"item_total\":331500.0}', 'JNE', 'Transfer Bank', 'sekur', 331500, 'image_picker3855729919354887649.jpg', '2023-02-03 02:43:01', 'Arrived'),
(57, 6, '{\"id_shoes\":44,\"image\":\"63b983ab71a0d.jpg\",\"name\":\"Nike Air Force 1	\",\"color\":\"White\",\"size\":\"38\",\"quantity\":1,\"item_total\":550000.0}', 'JNE', 'Transfer Bank', 'skr', 550000, 'image_picker6625014247335054692.jpg', '2023-02-03 02:46:42', ''),
(58, 6, '{\"id_shoes\":49,\"image\":\"63bd7df2b71cb.png\",\"name\":\"Spiderman PVC\",\"color\":\"orange\",\"size\":\" 40\",\"quantity\":1,\"item_total\":30000.0}', 'Kita Ekspedisi       99999', 'Transfer Bank', 'Sambas', 30000, 'image_picker292538856.jpg', '2023-02-04 13:56:27', ''),
(59, 6, '{\"id_shoes\":49,\"image\":\"63bd7df2b71cb.png\",\"name\":\"Spiderman PVC\",\"color\":\"orange\",\"size\":\" 40\",\"quantity\":1,\"item_total\":30000.0}', 'Kita Ekspedisi       99999', 'Transfer Bank', 'sekura', 30000, 'image_picker828559019.png', '2023-02-04 13:57:44', ''),
(60, 6, '{\"id_shoes\":47,\"image\":\"63b3e57e25280.jpg\",\"name\":\"Slip on Adidas\",\"color\":\"Red\",\"size\":\"37\",\"quantity\":1,\"item_total\":150000.0}||{\"id_shoes\":49,\"image\":\"63bd7df2b71cb.png\",\"name\":\"Spiderman PVC\",\"color\":\"orange\",\"size\":\" 40\",\"quantity\":1,\"item_total\":30000.0}', 'Kita Ekspedisi       99999', 'Transfer Bank', 'asda', 180000, 'image_picker982082019.jpg', '2023-02-04 13:58:15', ''),
(61, 6, '{\"id_shoes\":47,\"image\":\"63b3e57e25280.jpg\",\"name\":\"Slip on Adidas\",\"color\":\"Red\",\"size\":\"37\",\"quantity\":1,\"item_total\":150000.0}||{\"id_shoes\":49,\"image\":\"63bd7df2b71cb.png\",\"name\":\"Spiderman PVC\",\"color\":\"orange\",\"size\":\" 40\",\"quantity\":1,\"item_total\":30000.0}', 'Kita Ekspedisi       99999', 'Transfer Bank', 'asda', 180000, 'image_picker982082019.jpg', '2023-02-04 13:58:15', 'Arrived'),
(62, 6, '{\"id_shoes\":47,\"image\":\"63b3e57e25280.jpg\",\"name\":\"Slip on Adidas\",\"color\":\"Red\",\"size\":\"37\",\"quantity\":1,\"item_total\":150000.0}', 'Kita Ekspedisi       99999', 'Transfer Bank', 'sds', 150000, 'image_picker958902620.png', '2023-02-04 14:01:53', 'Arrived'),
(63, 17, '{\"id_shoes\":47,\"image\":\"63b3e57e25280.jpg\",\"name\":\"Slip on Adidas\",\"color\":\"Red\",\"size\":\" 38\",\"quantity\":1,\"item_total\":150000.0}', 'Kita Ekspedisi       99999', 'Transfer Bank', '', 150000, 'image_picker2237343486109684115.jpg', '2023-02-04 14:14:06', 'Arrived'),
(64, 6, '{\"id_shoes\":48,\"image\":\"63b97ffee2a9a.jpg\",\"name\":\"Fipper Classic\",\"color\":\"Yellow\",\"size\":\" 42\",\"quantity\":1,\"item_total\":130000.0}', 'Kita Ekspedisi       Rp 17.000,00', 'Transfer Bank', 'sdasa', 130000, 'image_picker1071055044.jpg', '2023-02-04 14:36:47', 'Diproses'),
(65, 6, '{\"id_shoes\":47,\"image\":\"63b3e57e25280.jpg\",\"name\":\"Slip on Adidas\",\"color\":\"Red\",\"size\":\" 39\",\"quantity\":1,\"item_total\":150000.0}', 'Kita Ekspedisi       Rp 17.000,00', 'Transfer Bank', 'asdasd', 150000, 'image_picker2006739634.png', '2023-02-04 14:52:35', 'Diproses'),
(66, 17, '{\"id_shoes\":46,\"image\":\"63b3e4422707b.jpg\",\"name\":\"Adidas Alphabounce Instinct \",\"color\":\"Grey\",\"size\":\" 42\",\"quantity\":1,\"item_total\":500000.0}', 'Kita Ekspedisi       Rp 17.000,00', 'Transfer Bank', 'jhjjj jjj', 500000, 'image_picker5004200732712890837.jpg', '2023-02-04 15:08:57', 'Dikirim'),
(67, 6, '{\"id_shoes\":50,\"image\":\"63e110026e890.jpg\",\"name\":\"Nike ZoomX Vaporfly Next 2 Sneakers\",\"color\":\"Violet\",\"size\":\" 41 \",\"quantity\":1,\"item_total\":600000.0}', 'Kita Ekspedisi       Rp 17.000,00', 'Transfer Bank', 'Sekura Testomg', 600000, 'image_picker1312215731.png', '2023-02-07 06:18:49', 'Arrived'),
(68, 6, '{\"id_shoes\":45,\"image\":\"63b3e332c16d5.jpg\",\"name\":\"Converse All Star Premium\",\"color\":\"navy\",\"size\":\"38 \",\"quantity\":1,\"item_total\":331500.0}', 'Kita Ekspedisi       Rp 17.000,00', 'Transfer Bank', 'Testing', 331500, 'image_picker2045999759.png', '2023-02-07 07:27:26', 'Arrived');

-- --------------------------------------------------------

--
-- Table structure for table `ukuran`
--

CREATE TABLE `ukuran` (
  `id_shoes` int(5) NOT NULL,
  `sizes` text CHARACTER SET utf8mb4 NOT NULL,
  `terbeli` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ukuran`
--

INSERT INTO `ukuran` (`id_shoes`, `sizes`, `terbeli`) VALUES
(44, '38', 0),
(44, ' 39', 0),
(44, ' 40', 0),
(45, '38 ', 1),
(45, ' 40', 0),
(45, ' 42', 0),
(46, '40', 0),
(46, ' 41', 0),
(46, ' 42', 0),
(47, '37', 0),
(47, ' 38', 0),
(47, ' 39', 0),
(48, '38', 0),
(48, ' 40', 0),
(48, ' 42', 0),
(49, '42', 0),
(49, ' 41', 0),
(49, ' 40', 0),
(50, '42 ', 0),
(50, ' 41 ', 1),
(50, ' 40', 0),
(51, '38 ', 0),
(51, '   39 ', 0),
(51, '   40 ', 0),
(51, '   41 ', 0),
(51, '   42', 0),
(52, '35 ', 0),
(52, ' 36 ', 0),
(52, ' 37 ', 0),
(52, ' 38 ', 0),
(52, ' 39 ', 0),
(52, ' 40 ', 0),
(52, ' 41', 0),
(53, '35 ', 0),
(53, ' 36 ', 0),
(53, ' 37 ', 0),
(53, ' 38 ', 0),
(53, ' 39 ', 0),
(53, ' 40 ', 0),
(53, ' 41', 0),
(54, '35 ', 0),
(54, ' 36 ', 0),
(54, ' 37 ', 0),
(54, ' 38 ', 0),
(54, ' 39 ', 0),
(54, ' 40 ', 0),
(54, ' 41', 0),
(55, '32', 0),
(55, ' 33 ', 0),
(55, ' 34 ', 0),
(55, ' 35 ', 0),
(55, ' 36 ', 0),
(55, ' 37 ', 0),
(55, ' 38 ', 0),
(55, ' 39', 0),
(56, '35 ', 0),
(56, ' 36 ', 0),
(56, ' 37 ', 0),
(56, ' 38 ', 0),
(56, ' 39 ', 0),
(56, ' 40 ', 0),
(56, ' 41', 0),
(57, '35 ', 0),
(57, ' 36 ', 0),
(57, ' 37 ', 0),
(57, ' 38 ', 0),
(57, ' 39 ', 0),
(57, ' 40 ', 0),
(57, ' 41', 0),
(58, '32', 0),
(58, ' 33 ', 0),
(58, ' 34 ', 0),
(58, ' 35 ', 0),
(58, ' 36 ', 0),
(58, ' 37 ', 0),
(58, ' 38 ', 0),
(58, ' 39', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `name`, `email`, `password`, `phone`) VALUES
(4, 'erwin', 'erwin@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', '081212345671'),
(5, 'Ernest', 'ernest@gmail.com', '81b073de9370ea873f548e31b8adc081', '081212345672'),
(6, 'Yosep', 'yosep@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', '081212345673'),
(8, 'leony', 'leony@gmail.com', 'f89d1b385ab7e82a42709ca64fca6190', '081212345678'),
(14, 'Musketer', 'musketer@gmail.com', '4297f44b13955235245b2497399d7a93', '081212345674'),
(16, 'vleo', 'vleo@gmail.com', 'bb7e1e0424583c7bc9acc379941d022d', '081212345633'),
(17, 'Stefanie Q', 'StefQ@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', '0824125423123'),
(18, 'Gita Cahyani', 'Gitacahyani@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', '081231234232'),
(21, 'Michel', 'michel@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', '085427128312'),
(22, 'Valeska', 'valeska@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', '081251231211'),
(23, 'testing', 'testing@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', '081254213125');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `favorit`
--
ALTER TABLE `favorit`
  ADD PRIMARY KEY (`id_favorit`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id_keranjang`);

--
-- Indexes for table `shoes`
--
ALTER TABLE `shoes`
  ADD PRIMARY KEY (`id_shoes`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id_transactions`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `favorit`
--
ALTER TABLE `favorit`
  MODIFY `id_favorit` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id_keranjang` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `shoes`
--
ALTER TABLE `shoes`
  MODIFY `id_shoes` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id_transactions` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
