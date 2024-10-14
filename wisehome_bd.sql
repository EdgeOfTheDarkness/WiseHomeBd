-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Окт 14 2024 г., 19:48
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `wisehome_bd`
--

-- --------------------------------------------------------

--
-- Структура таблицы `devices`
--

CREATE TABLE `devices` (
  `id` int(7) NOT NULL,
  `nazvanie` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `room_id` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `devices`
--

INSERT INTO `devices` (`id`, `nazvanie`, `type`, `status`, `room_id`) VALUES
(1, 'temp_datchik', 'datchik temperaturi', 1, 1),
(2, 'umnaya_lampa', 'umnaya lampa', 0, 2),
(3, 'robot_pilesos', 'robot pilesos', 0, 3),
(4, 'termostat', 'termostat', 1, 1),
(5, 'kamera_vid', 'kamera', 1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `events`
--

CREATE TABLE `events` (
  `id` int(7) NOT NULL,
  `device_id` int(100) UNSIGNED NOT NULL,
  `event_type` enum('on','off','settings_change') NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `events`
--

INSERT INTO `events` (`id`, `device_id`, `event_type`, `description`, `timestamp`) VALUES
(1, 2, 'on', 'Умная лампа включена', '2024-10-09 10:30:57'),
(2, 4, 'settings_change', 'Установлена температура 20°C', '2024-10-09 10:32:17'),
(3, 5, 'on', '	Камера активирована', '2024-10-09 10:32:17'),
(4, 3, 'off', 'Робот-пылесос выключен', '2024-10-09 10:33:56'),
(5, 1, 'settings_change', 'Установлена температура 22°C', '2024-10-09 10:33:56');

-- --------------------------------------------------------

--
-- Структура таблицы `rooms`
--

CREATE TABLE `rooms` (
  `id` int(7) NOT NULL,
  `nazvanie` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `rooms`
--

INSERT INTO `rooms` (`id`, `nazvanie`, `type`) VALUES
(1, 'kitchen', 'kitchen'),
(2, 'gostinaya', 'gostinaya'),
(3, 'spalnaya', 'spalnaya'),
(4, 'vannaya', 'vannaya'),
(5, 'kabinet', 'kabinet');

-- --------------------------------------------------------

--
-- Структура таблицы `sensorreadings`
--

CREATE TABLE `sensorreadings` (
  `id` int(7) NOT NULL,
  `device_id` int(100) NOT NULL,
  `value` float(65,0) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `sensorreadings`
--

INSERT INTO `sensorreadings` (`id`, `device_id`, `value`, `timestamp`) VALUES
(1, 1, 19, '2024-10-09 10:27:36'),
(2, 1, 29, '2024-10-09 10:27:36'),
(3, 1, 24, '2024-10-09 10:28:58'),
(4, 4, 23, '2024-10-09 10:28:58'),
(5, 4, 22, '2024-10-09 10:29:08');

-- --------------------------------------------------------

--
-- Структура таблицы `settings`
--

CREATE TABLE `settings` (
  `id` int(7) NOT NULL,
  `user_id` int(100) NOT NULL,
  `param_name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `settings`
--

INSERT INTO `settings` (`id`, `user_id`, `param_name`, `value`) VALUES
(1, 1, 'theme', 'dark'),
(2, 2, 'language', 'en'),
(3, 3, 'notifications', 'enable'),
(4, 4, 'theme ', 'light'),
(5, 5, 'language', 'ru');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(7) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES
(1, 'Nikolay', 'nikolay@gmail.com', '5467', 'user'),
(2, 'Vladimir', 'Vladimir@mail.ru', '741258', 'admin'),
(3, 'Oleksey', 'oleks@rambler.ru', '369qwer', 'user'),
(4, 'Maria', 'maria@example.com', '5874qwrr', 'user'),
(5, 'Dmitriy', 'dmitriy@example.com', '65478treqwe', 'user');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Индексы таблицы `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sensorreadings`
--
ALTER TABLE `sensorreadings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sensorreadings_ibfk_3` (`device_id`);

--
-- Индексы таблицы `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `events`
--
ALTER TABLE `events`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `sensorreadings`
--
ALTER TABLE `sensorreadings`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `devices`
--
ALTER TABLE `devices`
  ADD CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  ADD CONSTRAINT `devices_ibfk_2` FOREIGN KEY (`id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `sensorreadings`
--
ALTER TABLE `sensorreadings`
  ADD CONSTRAINT `sensorreadings_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  ADD CONSTRAINT `sensorreadings_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `events` (`id`);

--
-- Ограничения внешнего ключа таблицы `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
