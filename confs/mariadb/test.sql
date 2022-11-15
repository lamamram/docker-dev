CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS `pays`;
CREATE TABLE `pays` (
  `iso2` char(2) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iso2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `pays` VALUES ('AE','Emirats Arabes Unis'),('AT','Autriche'),('AU','Australie'),('BE','Belgique'),('BS','Bahamas'),('CA','Canada'),('CH','Chine'),('CY','Chypre'),('CZ','République tchèque'),('DE','Allemagne'),('DK','Danemark'),('ES','Espagne'),('FR','France'),('GB','Royaume Uni'),('GP','Guadeloupe'),('HK','Hong Kong'),('IE','Irlande'),('IL','Israël'),('IT','Italie'),('JP','Japon'),('KR','République de Corée'),('KY','Iles Caïmans'),('LI','Liechtenstein'),('LU','Luxembourg'),('MA','Maroc'),('MC','Monaco'),('MQ','Martinique'),('MU','Maurice'),('NL','Pays-Bas'),('NO','Norvège'),('PM','Saint-Pierre et Miquelon'),('RE','Réunion'),('SE','Suède'),('SG','Singapour'),('US','Etats Unis');
