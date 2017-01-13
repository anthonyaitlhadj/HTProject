-- phpMyAdmin SQL Dump
-- version 4.2.10
-- http://www.phpmyadmin.net
--
-- Client :  localhost:8889
-- Généré le :  Ven 13 Janvier 2017 à 23:02
-- Version du serveur :  5.5.38
-- Version de PHP :  5.6.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données :  `HT`
--

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE `messages` (
`message_id` int(11) NOT NULL,
  `sending_user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `receiving_user_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `messages`
--

INSERT INTO `messages` (`message_id`, `sending_user_id`, `message`, `receiving_user_id`) VALUES
(3, 6, 'Hello', 8),
(4, 6, 'Hello', 8);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
`user_id` int(11) NOT NULL,
  `lastname` varchar(40) NOT NULL,
  `firstname` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`user_id`, `lastname`, `firstname`, `username`, `email`, `password`) VALUES
(6, 'Kabasele', 'Quentin', 'qkab78', 'Quentin.kabasele@ynov.com', 'quentin'),
(8, 'Nyago', 'Antho', 'antho', 'nyago@gmail.com', 'test');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `messages`
--
ALTER TABLE `messages`
 ADD PRIMARY KEY (`message_id`), ADD KEY `sending_user_id` (`sending_user_id`,`receiving_user_id`), ADD KEY `receiving_user_id` (`receiving_user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`user_id`), ADD UNIQUE KEY `username` (`username`,`email`), ADD UNIQUE KEY `username_2` (`username`,`email`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `messages`
--
ALTER TABLE `messages`
MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiving_user_id`) REFERENCES `users` (`user_id`),
ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sending_user_id`) REFERENCES `users` (`user_id`);
