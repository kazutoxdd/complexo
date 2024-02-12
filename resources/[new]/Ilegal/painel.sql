DROP TABLE IF EXISTS `summerz_ports`;
CREATE TABLE IF NOT EXISTS `summerz_ports` (
  `portId` int NOT NULL AUTO_INCREMENT,
  `identity` varchar(50) NOT NULL DEFAULT '0',
  `serial` varchar(50) DEFAULT NULL,
  `portType` varchar(50) DEFAULT NULL,
  `exam` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `nuser_id` int DEFAULT NULL,
  PRIMARY KEY (`portId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;