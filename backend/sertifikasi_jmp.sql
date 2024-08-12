-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2024 at 05:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sertifikasi_jmp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `roti_id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telepon` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  `gpsLat` decimal(10,7) DEFAULT NULL,
  `gpsLng` decimal(10,7) DEFAULT NULL,
  `waktu_pembelian` timestamp NOT NULL DEFAULT current_timestamp(),
  `jumlah_pesanan` int(11) NOT NULL DEFAULT 1,
  `total_harga` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `roti_id`, `nama`, `email`, `no_telepon`, `alamat`, `gpsLat`, `gpsLng`, `waktu_pembelian`, `jumlah_pesanan`, `total_harga`) VALUES
(48, 1, 'Alma Nazhifa ', 'nazhifaalma@gmail.com ', '089652869400', 'Kota Semarang ', -6.9677314, 110.4695042, '2024-08-11 12:39:15', 2, '50000.00'),
(49, 4, 'Sarah K.', 'ksarah@gmail.com', '08524179633', 'Bandung ', -6.9676800, 110.4695567, '2024-08-11 12:39:59', 1, '22000.00'),
(50, 3, 'Santy D.', 'santy@gmail.com', '08521463700', 'Jepara', -6.9677248, 110.4694911, '2024-08-11 13:07:13', 1, '35000.00'),
(51, 2, 'Naswa A.', 'nasyaq123@gmail.com', '089645260100', 'Sumatera ', -6.9677500, 110.4695450, '2024-08-11 13:08:40', 2, '60000.00'),
(52, 5, 'Kiki Salsabila', 'lalakajid@gmail.com', '085216949085', 'Bandung', -6.9677279, 110.4694979, '2024-08-11 13:17:23', 3, '75000.00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `imageUrl` varchar(255) NOT NULL,
  `name` varchar(25) NOT NULL,
  `price` varchar(225) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `imageUrl`, `name`, `price`, `description`) VALUES
(1, 'https://media.istockphoto.com/id/1130692246/id/foto/brownies-cokelat-buatan-sendiri-ditembak-dari-atas.jpg?s=1024x1024&w=is&k=20&c=rDBH_TnUX-PWlQKPA_mXEkUcBDcAwJP9J3vuEwBnUCE=', 'Brownies Cokelat', '25000', 'Kue cokelat yang lezat dengan tekstur lembut dan rasa cokelat pekat.'),
(2, 'https://media.istockphoto.com/id/904540928/id/foto/macaroon-multi-warna-dalam-bidikan-pelat-biru-di-atas-meja-biru.jpg?s=1024x1024&w=is&k=20&c=6fMNkdwzfDi1X9tWnnHy9ZVBvakky80HjyjsCPDNhUc=', 'Macaron', '30000', 'Kue kecil bertekstur renyah di luar, lembut di dalam, dengan berbagai rasa dan warna, diisi dengan krim, ganache, atau selai.'),
(3, 'https://media.istockphoto.com/id/1141404927/id/foto/kelezatan-turki-yang-lezat-dengan-kacang-kacangan.jpg?s=1024x1024&w=is&k=20&c=oaKsvbvI2sLOEcb-x6DCLjcIxPS2yanshK9hq_xoCus=', 'Baguette', '35000', 'Roti panjang dari Prancis dengan kulit renyah dan bagian dalam yang lembut.'),
(4, 'https://media.istockphoto.com/id/544333618/id/foto/mozzarella-dan-sandwich-tomat.jpg?s=612x612&w=0&k=20&c=nAJuNuHzEf1vkk4xQ40ht7zV5xn6gJM7Kp1R9zVDES8=', 'Foccacia', '22000', 'Roti datar Italia yang dibumbui dengan minyak zaitun, herba, dan terkadang ditambahkan sayuran atau keju. Lembut dan penuh rasa, cocok sebagai pembuka atau hidangan sampingan.'),
(5, 'https://media.istockphoto.com/id/174783901/id/foto/cheescake-dengan-stroberi.jpg?s=612x612&w=0&k=20&c=AqkEuwRR9qxG5KAudhcbDQAQXpSLwFEYVCkmSJJ5G_A=', 'Cheesecake', '25000', 'Makanan penutup yang creamy terbuat dari keju krim pada dasar kue graham cracker. Tersedia dalam berbagai rasa seperti klasik, stroberi, atau cokelat.'),
(6, 'https://media.istockphoto.com/id/1226968711/id/foto/roti-kue-pon-lemon-berkaca-kaca-dengan-biji-poppy.jpg?s=612x612&w=0&k=20&c=rxccTkwacsqujnz1kaISDYLEgKsKPL5KRCDe7laS1WQ=', ' Lemon Drizzle ', '20000', 'Kue ringan dan segar yang diberi rasa lemon dan dilapisi dengan glasir lemon manis. Menyegarkan dan sempurna untuk teh sore.'),
(7, 'https://media.istockphoto.com/id/485832764/id/foto/kue-beludru-merah.jpg?s=612x612&w=0&k=20&c=3IPcAhFu4WOuA7cTkQJ-l9qvN6ICs3uR4cLY82RWyi4=', 'Red Velvet', '15000', ' Kue merah mencolok dengan sentuhan kakao, sering kali dilapisi dengan frosting keju krim. Dikenal karena warnanya yang unik dan rasa yang kaya.');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(100) NOT NULL,
  `username` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `created_at`, `update_at`) VALUES
(2, 'lala', 'lala', '2024-08-10 16:02:56', '2024-08-10 16:02:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
