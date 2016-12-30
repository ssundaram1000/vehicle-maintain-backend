DROP TABLE IF EXISTS model_checkList, checkList, model, inventory;

CREATE TABLE `model` (
  `modelLineCode` varchar(64) CHARACTER SET utf8 NOT NULL,
  `modelDesc` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`modelLineCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `checkList` (
  `checkListId` varchar(64) CHARACTER SET utf8 NOT NULL,
  `checkListDesc` varchar(255) CHARACTER SET utf8 NOT NULL,
  `frequency` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`checkListId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `model_checkList` (
  `modelLineCode` varchar(64) CHARACTER SET utf8 NOT NULL,
  `checkListId` varchar(64) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`modelLineCode`,`checkListId`),
  KEY `fk_modelLineCodeIdx` (`modelLineCode`),
  KEY `fk_checkListIdIdx` (`checkListId`),
  CONSTRAINT `fk_checkListId` FOREIGN KEY (`checkListId`) REFERENCES `checkList` (`checkListId`),
  CONSTRAINT `fk_modelLineCode` FOREIGN KEY (`modelLineCode`) REFERENCES `model` (`modelLineCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `inventory` (
  `vin` varchar(64) CHARACTER SET utf8 NOT NULL,
  `modelYear` varchar(4) DEFAULT NULL,
  `baseName` varchar(45) DEFAULT NULL,
  `modelLineCode` varchar(64) CHARACTER SET utf8 NOT NULL,
  `color` varchar(64) CHARACTER SET utf8 NOT NULL,
  `swatchURL` varchar(255) DEFAULT NULL,
  `dealerNum` varchar(20) NOT NULL DEFAULT '100',
  `dateReceived` datetime NOT NULL,
  PRIMARY KEY (`vin`),
  KEY `fk_modelLineCodeIdx` (`modelLineCode`),
  CONSTRAINT `fk_one` FOREIGN KEY (`modelLineCode`) REFERENCES `model` (`modelLineCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE `inventoryActions` (
  `vin` varchar(64) NOT NULL,
  `checkListId` varchar(64) CHARACTER SET utf8 NOT NULL,
  `completedDate` datetime NOT NULL,
  PRIMARY KEY (`vin`,`checkListId`,`completedDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;





















