-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 27, 2012 at 06:25 PM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `igcdevdb_v01`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
CREATE TABLE IF NOT EXISTS `alerts` (
  `alertID` int(11) NOT NULL AUTO_INCREMENT,
  `alert` text NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `contentType` varchar(10) NOT NULL COMMENT 'text or html',
  `creationDate` datetime NOT NULL,
  PRIMARY KEY (`alertID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `alerts`
--


-- --------------------------------------------------------

--
-- Table structure for table `authoringorganizations`
--

DROP TABLE IF EXISTS `authoringorganizations`;
CREATE TABLE IF NOT EXISTS `authoringorganizations` (
  `authoringOrgId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`authoringOrgId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `authoringorganizations`
--


-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

DROP TABLE IF EXISTS `bookmarks`;
CREATE TABLE IF NOT EXISTS `bookmarks` (
  `bookmarkId` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `pageId` varchar(45) DEFAULT NULL,
  `fileName` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `creationDate` datetime NOT NULL,
  `deviceId` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bookmarkId`),
  UNIQUE KEY `BookmarkId_UNIQUE` (`bookmarkId`),
  KEY `fk_tblBookmarks_tblUser1` (`userId`),
  KEY `fk_tblBookmarks_tblProduct1` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `bookmarks`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_appconfig`
--

DROP TABLE IF EXISTS `cc_appconfig`;
CREATE TABLE IF NOT EXISTS `cc_appconfig` (
  `applicationId` int(11) NOT NULL,
  `key` varchar(50) NOT NULL DEFAULT '' COMMENT 'Config Key: e.g. db connection string.\nvalue = "host= , db= ,user= , pwd ="',
  `value` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`key`,`applicationId`),
  KEY `fk_CC_AppConfig_CC_Application1` (`applicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cc_appconfig`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_appevents`
--

DROP TABLE IF EXISTS `cc_appevents`;
CREATE TABLE IF NOT EXISTS `cc_appevents` (
  `id` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL,
  `who` int(11) NOT NULL,
  `what` varchar(45) DEFAULT NULL,
  `when` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`applicationId`),
  KEY `fk_CC_AppEvents_CC_Application1` (`applicationId`),
  KEY `userId` (`who`),
  KEY `applicationId` (`applicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Will be used for tracking various event happening in the app';

--
-- Dumping data for table `cc_appevents`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_applications`
--

DROP TABLE IF EXISTS `cc_applications`;
CREATE TABLE IF NOT EXISTS `cc_applications` (
  `applicationId` int(11) NOT NULL AUTO_INCREMENT,
  `applicationName` varchar(256) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `appConnectionString` varchar(100) DEFAULT 'Application DB connection string',
  PRIMARY KEY (`applicationId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cc_applications`
--

INSERT INTO `cc_applications` (`applicationId`, `applicationName`, `description`, `appConnectionString`) VALUES
(1, 'IGC', 'Guideline Central Application', 'Application DB connection string');

-- --------------------------------------------------------

--
-- Table structure for table `cc_applog`
--

DROP TABLE IF EXISTS `cc_applog`;
CREATE TABLE IF NOT EXISTS `cc_applog` (
  `logRecordId` int(11) NOT NULL AUTO_INCREMENT,
  `applicationId` int(11) NOT NULL,
  `referrer` varchar(45) DEFAULT NULL COMMENT 'request URL',
  `referrerData` varchar(200) DEFAULT NULL COMMENT 'request context e.g. requester from field values.',
  `queryStringData` varchar(200) DEFAULT NULL COMMENT 'in case of web call we record the query string.',
  `type` varchar(8) DEFAULT 'info' COMMENT 'info, error , warning',
  `source` varchar(45) DEFAULT NULL COMMENT 'e.g. Class, Method, Client , Server',
  `message` varchar(200) DEFAULT NULL COMMENT 'info, warning or exception message',
  `stackTrace` varchar(300) DEFAULT NULL COMMENT 'applicable only in case of exception',
  `exceptionType` varchar(45) DEFAULT NULL COMMENT 'Type of exception e.g. IOException, SecurityException, NetworkException, SOAPException',
  `appLayer` varchar(45) DEFAULT NULL COMMENT 'Application layer in which issue has occurred. e.g. WS Layer, Data Access Layer etc..',
  `createdBy` varchar(45) DEFAULT NULL COMMENT 'user id',
  `createdOn` datetime DEFAULT NULL,
  `deviceId` varchar(45) DEFAULT NULL,
  `deviceOS` varchar(45) DEFAULT NULL,
  `apiVersion` varchar(8) DEFAULT NULL,
  `JSONRequest` varchar(300) DEFAULT NULL,
  `errorCode` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`logRecordId`,`applicationId`),
  KEY `fk_CC_AppLog_CC_Application1` (`applicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `cc_applog`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_authorizations`
--

DROP TABLE IF EXISTS `cc_authorizations`;
CREATE TABLE IF NOT EXISTS `cc_authorizations` (
  `authorizationId` int(11) NOT NULL AUTO_INCREMENT,
  `autherizationDescription` varchar(45) NOT NULL,
  `applicationId` int(11) NOT NULL,
  PRIMARY KEY (`authorizationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `cc_authorizations`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_membership`
--

DROP TABLE IF EXISTS `cc_membership`;
CREATE TABLE IF NOT EXISTS `cc_membership` (
  `userId` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL,
  `password` varchar(128) NOT NULL COMMENT 'Password (plaintext, hashed, or\nencrypted; base-64-encoded if hashed\nor encrypted)',
  `passwordFormat` int(11) NOT NULL DEFAULT '0' COMMENT 'Password format (0=Plaintext,\n1=Hashed, 2=Encrypted)',
  `passwordSalt` varchar(128) NOT NULL COMMENT 'Randomly generated 128-bit value\nused to salt password hashes; stored\nin base-64-encoded form',
  `passwordQuestion` varchar(128) NOT NULL,
  `passwordAnswer` varchar(45) NOT NULL,
  `lastLoginDate` datetime NOT NULL,
  `lastPasswordChangedDate` datetime DEFAULT NULL,
  `isApproved` int(11) DEFAULT '0' COMMENT '1=Approved, 0=Not approved',
  `isLocked` int(11) DEFAULT '0' COMMENT '1- Locked\n0- Not Locked',
  `lastLockedOutDate` datetime DEFAULT NULL,
  `failedPasswordAttempCount` int(11) DEFAULT NULL,
  `failedPasswordAttemptStart` datetime DEFAULT NULL,
  `faliedPasswordAnswerAttemptCount` int(11) DEFAULT NULL,
  `failedPasswordAnswerAttempStart` datetime DEFAULT NULL,
  `loginTimeout` int(11) DEFAULT '1' COMMENT 'Days',
  `creationDate` datetime NOT NULL,
  `modificationDate` datetime NOT NULL,
  `passwordAlgorithm` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userId`,`applicationId`),
  KEY `fk_CC_Membership_CC_Application1` (`applicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cc_membership`
--

INSERT INTO `cc_membership` (`userId`, `applicationId`, `password`, `passwordFormat`, `passwordSalt`, `passwordQuestion`, `passwordAnswer`, `lastLoginDate`, `lastPasswordChangedDate`, `isApproved`, `isLocked`, `lastLockedOutDate`, `failedPasswordAttempCount`, `failedPasswordAttemptStart`, `faliedPasswordAnswerAttemptCount`, `failedPasswordAnswerAttempStart`, `loginTimeout`, `creationDate`, `modificationDate`, `passwordAlgorithm`) VALUES
(8, 1, 'isrkadam', 0, '', 'q', 'a', '2012-05-27 21:31:19', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, '2012-05-27 21:15:13', '2012-05-27 21:15:13', 'md5'),
(11, 1, '15285722f9def45c091725aee9c387cb', 2, 'NA', 'Q', 'A', '2012-05-27 21:31:51', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, '2012-05-27 21:31:51', '2012-05-27 21:31:51', 'md5');

-- --------------------------------------------------------

--
-- Table structure for table `cc_messages`
--

DROP TABLE IF EXISTS `cc_messages`;
CREATE TABLE IF NOT EXISTS `cc_messages` (
  `applicationId` int(11) NOT NULL,
  `messageId` int(11) NOT NULL,
  `message` varchar(100) NOT NULL,
  PRIMARY KEY (`applicationId`,`messageId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cc_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_personalizationdetails`
--

DROP TABLE IF EXISTS `cc_personalizationdetails`;
CREATE TABLE IF NOT EXISTS `cc_personalizationdetails` (
  `personalizationId` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `deviceId` varchar(45) NOT NULL,
  `personalizationJSON` longtext NOT NULL,
  `modificationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`personalizationId`,`applicationId`,`userId`),
  KEY `fk_tblPersonalizationDetails_tblUser1` (`userId`),
  KEY `fk_CC_PersonalizationDetails_CC_Application1` (`applicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cc_personalizationdetails`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_roleauthorizations`
--

DROP TABLE IF EXISTS `cc_roleauthorizations`;
CREATE TABLE IF NOT EXISTS `cc_roleauthorizations` (
  `roleId` int(11) NOT NULL,
  `authorizationId` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`,`authorizationId`,`applicationId`),
  KEY `roleId` (`roleId`),
  KEY `authorizationId` (`authorizationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cc_roleauthorizations`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_roles`
--

DROP TABLE IF EXISTS `cc_roles`;
CREATE TABLE IF NOT EXISTS `cc_roles` (
  `roleId` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(45) NOT NULL,
  `applicationId` int(11) NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `cc_roles`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_statements`
--

DROP TABLE IF EXISTS `cc_statements`;
CREATE TABLE IF NOT EXISTS `cc_statements` (
  `applicationId` int(11) NOT NULL,
  `key` int(11) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`applicationId`),
  KEY `fk_CC_Statements_CC_Application1` (`applicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This table will be used to maintain legal statements for app';

--
-- Dumping data for table `cc_statements`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_userprofile`
--

DROP TABLE IF EXISTS `cc_userprofile`;
CREATE TABLE IF NOT EXISTS `cc_userprofile` (
  `userId` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `zipCode` varchar(45) DEFAULT NULL,
  `specialtyId` int(11) NOT NULL,
  `professionId` int(11) NOT NULL,
  `creationDate` datetime NOT NULL,
  `modificationDate` datetime NOT NULL,
  PRIMARY KEY (`userId`,`applicationId`),
  KEY `fk_UserProfile_Specialty1` (`specialtyId`),
  KEY `fk_UserProfile_Profession1` (`professionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cc_userprofile`
--

INSERT INTO `cc_userprofile` (`userId`, `applicationId`, `firstName`, `lastname`, `country`, `city`, `zipCode`, `specialtyId`, `professionId`, `creationDate`, `modificationDate`) VALUES
(8, 1, 'sachin', 'kadam', 'india', 'mumbai', '400063', 1, 1, '2012-05-27 21:15:13', '2012-05-27 21:15:13'),
(11, 1, 'mumbai', '', 'india', '', '400063', 1, 1, '2012-05-27 21:31:51', '2012-05-27 21:31:51');

-- --------------------------------------------------------

--
-- Table structure for table `cc_userrole`
--

DROP TABLE IF EXISTS `cc_userrole`;
CREATE TABLE IF NOT EXISTS `cc_userrole` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cc_userrole`
--


-- --------------------------------------------------------

--
-- Table structure for table `cc_users`
--

DROP TABLE IF EXISTS `cc_users`;
CREATE TABLE IF NOT EXISTS `cc_users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `applicationId` int(11) NOT NULL,
  `userName` varchar(100) NOT NULL,
  `email` varchar(45) NOT NULL,
  `creationDate` datetime NOT NULL,
  `modificationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`,`applicationId`),
  KEY `fk_CC_User_CC_Application1` (`applicationId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `cc_users`
--

INSERT INTO `cc_users` (`userId`, `applicationId`, `userName`, `email`, `creationDate`, `modificationDate`) VALUES
(8, 1, 'sachin kadam', 'isrkadam@gmail.com', '2012-05-27 21:15:13', '2012-05-27 21:15:13'),
(11, 1, 'mumbai ', 'sachin@mobiuso.com', '2012-05-27 21:31:51', '2012-05-27 21:31:51');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `CommentID` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `creationDate` datetime NOT NULL,
  `comment` text NOT NULL,
  `deviceId` varchar(45) NOT NULL,
  `IsActive` bit(1) DEFAULT NULL,
  `modificationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CommentID`),
  UNIQUE KEY `CommentID_UNIQUE` (`CommentID`),
  KEY `fk_Comments_CC_User1` (`userId`,`applicationId`),
  KEY `fk_Comments_Product1` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `messageId` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(45) NOT NULL,
  PRIMARY KEY (`messageId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE IF NOT EXISTS `notes` (
  `noteId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `text` text,
  `pageId` varchar(45) DEFAULT NULL COMMENT 'Page/Guideline specific notes',
  `creationDate` datetime NOT NULL,
  `deviceId` varchar(45) DEFAULT NULL,
  `RefNoteId` int(11) DEFAULT NULL,
  PRIMARY KEY (`noteId`),
  KEY `fk_tblNote_tblUser1` (`userId`),
  KEY `fk_tblNote_tblProduct1` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `notes`
--


-- --------------------------------------------------------

--
-- Table structure for table `paymentdetails`
--

DROP TABLE IF EXISTS `paymentdetails`;
CREATE TABLE IF NOT EXISTS `paymentdetails` (
  `paymentId` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` varchar(45) DEFAULT NULL COMMENT 'may not be required',
  `transactionReference` varchar(100) NOT NULL,
  `paymentMode` varchar(45) NOT NULL,
  `quantity` int(11) NOT NULL,
  `amount` double NOT NULL,
  `transactionDate` datetime NOT NULL,
  `gateway` varchar(45) DEFAULT NULL,
  `bank` varchar(45) DEFAULT NULL,
  `creditCardNo` varchar(45) DEFAULT NULL,
  `transactionStatus` varchar(10) NOT NULL,
  `deviceId` varchar(45) NOT NULL,
  `IP` varchar(15) NOT NULL,
  `subscriptionId` int(11) NOT NULL,
  `appleReciept` varchar(200) DEFAULT NULL COMMENT 'will hold the transaction receipts generated through in app purchase',
  `androidReceipt` varchar(200) DEFAULT NULL COMMENT 'will hold the transaction receipts generated through in app purchase',
  PRIMARY KEY (`paymentId`),
  KEY `subscriptionId` (`subscriptionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `paymentdetails`
--


-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT,
  `authoringOrganizationId` int(11) NOT NULL,
  `title` mediumtext NOT NULL,
  `isbn` varchar(45) NOT NULL,
  `publishedDate` date NOT NULL,
  `endorsedBy` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `abstract` text NOT NULL,
  `publisher` varchar(45) NOT NULL COMMENT 'In case of UGC publisher filed will have userId of the publishing user.',
  `packagename` varchar(45) NOT NULL COMMENT 'Name of package file that contains product content.',
  `authors` varchar(45) DEFAULT NULL COMMENT 'comma seperated list of authors',
  `version` varchar(8) DEFAULT NULL COMMENT 'Can be used for internal purpose.',
  `shortDescription` mediumtext,
  `longDescription` longtext,
  `edition` int(11) DEFAULT NULL,
  `size` int(11) NOT NULL COMMENT 'Size of a Product Package',
  `sizeUnit` varchar(3) NOT NULL COMMENT 'Size Unit Kb, Mb etc.',
  `type` varchar(45) DEFAULT 'Guideline' COMMENT 'Guideline\nBook\nCalculator\nChecklist\n\nfor now all the ''subscribable'' products will be "Guideline".  Later we could have some other types (like Checklists, PubMed, etc)\n\n',
  `icon` blob,
  `splash` blob,
  `iconName` varchar(45) DEFAULT NULL,
  `splashName` varchar(45) DEFAULT NULL,
  `nameId` varchar(45) DEFAULT NULL,
  `priority` varchar(45) DEFAULT NULL,
  `modificationDate` datetime DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`productId`),
  KEY `fk_tblProduct_tblAuthoringOrganization1` (`authoringOrganizationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `product`
--


-- --------------------------------------------------------

--
-- Table structure for table `productbysubcategory`
--

DROP TABLE IF EXISTS `productbysubcategory`;
CREATE TABLE IF NOT EXISTS `productbysubcategory` (
  `productId` int(11) NOT NULL,
  `subCategory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productbysubcategory`
--


-- --------------------------------------------------------

--
-- Table structure for table `productcategory`
--

DROP TABLE IF EXISTS `productcategory`;
CREATE TABLE IF NOT EXISTS `productcategory` (
  `productCategoryId` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(45) NOT NULL COMMENT 'UGC will be one of the category/sub category types.',
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `productcategory`
--


-- --------------------------------------------------------

--
-- Table structure for table `productsbycategory`
--

DROP TABLE IF EXISTS `productsbycategory`;
CREATE TABLE IF NOT EXISTS `productsbycategory` (
  `productId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  KEY `productId` (`productId`),
  KEY `categoryId` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Maintains the association between Product & Product Category';

--
-- Dumping data for table `productsbycategory`
--


-- --------------------------------------------------------

--
-- Table structure for table `productsbyprofession`
--

DROP TABLE IF EXISTS `productsbyprofession`;
CREATE TABLE IF NOT EXISTS `productsbyprofession` (
  `productId` int(11) NOT NULL,
  `professionId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productsbyprofession`
--


-- --------------------------------------------------------

--
-- Table structure for table `productsbyspecialty`
--

DROP TABLE IF EXISTS `productsbyspecialty`;
CREATE TABLE IF NOT EXISTS `productsbyspecialty` (
  `productId` int(11) NOT NULL,
  `specialtyId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productsbyspecialty`
--


-- --------------------------------------------------------

--
-- Table structure for table `profession`
--

DROP TABLE IF EXISTS `profession`;
CREATE TABLE IF NOT EXISTS `profession` (
  `professionId` int(11) NOT NULL AUTO_INCREMENT,
  `profession` varchar(45) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`professionId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `profession`
--

INSERT INTO `profession` (`professionId`, `profession`, `description`) VALUES
(1, 'Doctor', 'Medicine Doctor');

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
CREATE TABLE IF NOT EXISTS `promotions` (
  `promotionId` int(11) NOT NULL AUTO_INCREMENT,
  `promotionDetails` text NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `contentType` varchar(10) NOT NULL COMMENT 'text or html',
  `creationDate` datetime NOT NULL,
  PRIMARY KEY (`promotionId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `promotions`
--


-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE IF NOT EXISTS `ratings` (
  `userId` int(11) NOT NULL,
  `applicationId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL COMMENT 'Scale of 1 to 5',
  `ratingDateTime` datetime NOT NULL,
  `deviceId` varchar(45) DEFAULT NULL,
  `ratingId` int(11) NOT NULL AUTO_INCREMENT,
  `outOf` int(11) DEFAULT NULL,
  PRIMARY KEY (`ratingId`),
  KEY `fk_Rating_Product1` (`productId`),
  KEY `fk_Rating_CC_User1` (`userId`,`applicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ratings`
--


-- --------------------------------------------------------

--
-- Table structure for table `resourcedownloadhistory`
--

DROP TABLE IF EXISTS `resourcedownloadhistory`;
CREATE TABLE IF NOT EXISTS `resourcedownloadhistory` (
  `downloadHistoryId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `deviceUDID` varchar(45) NOT NULL,
  `downloadOn` datetime NOT NULL,
  `deviceModel` varchar(45) DEFAULT NULL,
  `deviceOS` varchar(20) DEFAULT NULL,
  `ipAddress` varchar(45) DEFAULT NULL,
  `macAddress` varchar(45) DEFAULT NULL,
  `downloadStatus` int(11) NOT NULL COMMENT '1- success\n2 - failed',
  PRIMARY KEY (`downloadHistoryId`),
  KEY `fk_tblResourceDownloadHistory_tblUser2` (`userId`),
  KEY `fk_tblResourceDownloadHistory_tblProduct1` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `resourcedownloadhistory`
--


-- --------------------------------------------------------

--
-- Table structure for table `specialty`
--

DROP TABLE IF EXISTS `specialty`;
CREATE TABLE IF NOT EXISTS `specialty` (
  `specialtyId` int(11) NOT NULL AUTO_INCREMENT,
  `specialty` varchar(45) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`specialtyId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `specialty`
--

INSERT INTO `specialty` (`specialtyId`, `specialty`, `description`) VALUES
(1, 'Orthopedic Surgen', 'Orthopedic Surgen');

-- --------------------------------------------------------

--
-- Table structure for table `subcategory`
--

DROP TABLE IF EXISTS `subcategory`;
CREATE TABLE IF NOT EXISTS `subcategory` (
  `subCategoryId` int(11) NOT NULL AUTO_INCREMENT,
  `subCategory` varchar(45) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`subCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `subcategory`
--


-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `subscriptionId` int(11) NOT NULL AUTO_INCREMENT,
  `previousSubscriptionId` int(11) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `creationDate` datetime NOT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `status` bit(1) DEFAULT b'0' COMMENT '0- Not valid\n1- In Force',
  `type` int(11) DEFAULT '1' COMMENT '1 - To Keep\n2 - Limited',
  PRIMARY KEY (`subscriptionId`),
  KEY `userId` (`userId`),
  KEY `productId` (`productId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `subscriptions`
--


-- --------------------------------------------------------

--
-- Table structure for table `userdevicetoken`
--

DROP TABLE IF EXISTS `userdevicetoken`;
CREATE TABLE IF NOT EXISTS `userdevicetoken` (
  `userId` int(11) NOT NULL,
  `deviceUDID` varchar(45) DEFAULT NULL,
  `deviceTokenId` varchar(45) DEFAULT NULL,
  `applicationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Maintains user Id, Device ID and Device token. This device t';

--
-- Dumping data for table `userdevicetoken`
--


--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `fk_tblBookmarks_tblProduct1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblBookmarks_tblUser1` FOREIGN KEY (`userId`) REFERENCES `cc_users` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_appconfig`
--
ALTER TABLE `cc_appconfig`
  ADD CONSTRAINT `fk_CC_AppConfig_CC_Application1` FOREIGN KEY (`applicationId`) REFERENCES `cc_applications` (`applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_appevents`
--
ALTER TABLE `cc_appevents`
  ADD CONSTRAINT `applicationId` FOREIGN KEY (`applicationId`) REFERENCES `cc_applications` (`applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `userId` FOREIGN KEY (`who`) REFERENCES `cc_users` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_applog`
--
ALTER TABLE `cc_applog`
  ADD CONSTRAINT `fk_CC_AppLog_CC_Application1` FOREIGN KEY (`applicationId`) REFERENCES `cc_applications` (`applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_membership`
--
ALTER TABLE `cc_membership`
  ADD CONSTRAINT `fk_CC_Membership_CC_Application1` FOREIGN KEY (`applicationId`) REFERENCES `cc_applications` (`applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblMembership_tblUser1` FOREIGN KEY (`userId`) REFERENCES `cc_users` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_personalizationdetails`
--
ALTER TABLE `cc_personalizationdetails`
  ADD CONSTRAINT `fk_CC_PersonalizationDetails_CC_Application1` FOREIGN KEY (`applicationId`) REFERENCES `cc_applications` (`applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblPersonalizationDetails_tblUser1` FOREIGN KEY (`userId`) REFERENCES `cc_users` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_roleauthorizations`
--
ALTER TABLE `cc_roleauthorizations`
  ADD CONSTRAINT `authorizationId` FOREIGN KEY (`authorizationId`) REFERENCES `cc_authorizations` (`authorizationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `roleId` FOREIGN KEY (`roleId`) REFERENCES `cc_roles` (`roleId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_statements`
--
ALTER TABLE `cc_statements`
  ADD CONSTRAINT `fk_CC_Statements_CC_Application1` FOREIGN KEY (`applicationId`) REFERENCES `cc_applications` (`applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_userprofile`
--
ALTER TABLE `cc_userprofile`
  ADD CONSTRAINT `fk_UserProfile_CC_Users1` FOREIGN KEY (`userId`, `applicationId`) REFERENCES `cc_users` (`userId`, `applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_UserProfile_Profession1` FOREIGN KEY (`professionId`) REFERENCES `profession` (`professionId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cc_users`
--
ALTER TABLE `cc_users`
  ADD CONSTRAINT `fk_CC_User_CC_Application1` FOREIGN KEY (`applicationId`) REFERENCES `cc_applications` (`applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_Comments_CC_User1` FOREIGN KEY (`userId`, `applicationId`) REFERENCES `cc_users` (`userId`, `applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Comments_Product1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `fk_tblNote_tblProduct1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblNote_tblUser1` FOREIGN KEY (`userId`) REFERENCES `cc_users` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_tblProduct_tblAuthoringOrganization1` FOREIGN KEY (`authoringOrganizationId`) REFERENCES `authoringorganizations` (`authoringOrgId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `productsbycategory`
--
ALTER TABLE `productsbycategory`
  ADD CONSTRAINT `categoryId` FOREIGN KEY (`categoryId`) REFERENCES `productcategory` (`productCategoryId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `productId` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_Rating_CC_User1` FOREIGN KEY (`userId`, `applicationId`) REFERENCES `cc_users` (`userId`, `applicationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Rating_Product1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `resourcedownloadhistory`
--
ALTER TABLE `resourcedownloadhistory`
  ADD CONSTRAINT `fk_tblResourceDownloadHistory_tblProduct1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblResourceDownloadHistory_tblUser2` FOREIGN KEY (`userId`) REFERENCES `cc_users` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `cc_approveMembership`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cc_approveMembership`(IN uid int,
                                                                IN appId int)
BEGIN

        UPDATE cc_membership
        SET isApproved = 1, modificationDate = now()
        WHERE userId = uid
        and applicationId = appId;  
 
END$$

DROP PROCEDURE IF EXISTS `cc_createLogRecord`$$
CREATE DEFINER=`sachin`@`localhost` PROCEDURE `cc_createLogRecord`(IN appId int(11),
                                                                 IN referrer varchar(45),
                                                                 IN referrerData varchar(200),
                                                                 IN queryStringData varchar(200),
                                                                 IN type varchar(15),
                                                                 IN source varchar(45),
                                                                 IN message varchar(200),
                                                                 IN stackTrace varchar(300),
                                                                 IN appLayer varchar(45),
                                                                 IN exceptionType varchar(45),
                                                                 IN uId int(11),
                                                                 IN deviceId varchar(45),
                                                                 IN deviceOs varchar(45),
                                                                 IN errorCode varchar(5),
                                                                 IN apiVersion varchar(8),
                                                                 IN jsonRequest varchar(300)
                                                                 )
BEGIN
     DECLARE logRecordId int(11); 
      
    INSERT INTO cc_applog
    (applicationId,
     referrer,
     referrerData,
     queryStringData,
     type,
     source,
     message,
     stackTrace,
     exceptionType,
     appLayer,
     createdBy,
     createdOn,
     deviceId,
     deviceOs,
     errorCode,
     apiVersion,
     JSONRequest
     
    )VALUES(
    appId,
    referrer,
    referrerData,
    queryStringData,
    type,
    source,
    message,
    stackTrace,
    exceptionType,
    appLayer,
    uId,
    now(),
    
    deviceId,
    deviceOs,
    errorCode,
    apiVersion,
    jsonRequest
    );
    
    SET logRecordId = LAST_INSERT_ID();
    SELECT logRecordId;

END$$

DROP PROCEDURE IF EXISTS `cc_createNewUser`$$
CREATE DEFINER=`sachin`@`localhost` PROCEDURE `cc_createNewUser`(In email varchar(45),
                                In password varchar(128),
                                passwordFormat int ,
                                passwordAlgorithm varchar(10),
                                passwordSalt varchar(128),
                                passwordQuestion varchar(128),
                                passwordAnswer varchar (45),
                                applicationId int,
                                firstName   varchar(45),
                                lastName    varchar(45),
                                country varchar(45),
                                city    varchar(45),
                                zipCode varchar(45),
                                specialtyId int,
                                professionId int)
BEGIN
    declare userId int;
    set userId = 0;
    start transaction;
    IF not exists(
                    select usr.userId
                    from cc_Users as usr
                    where lower(usr.email) = lower(email)
                    and usr.applicationId = applicationId
                  )
    THEN
        insert into cc_users
        (
            email,
            applicationId,
            userName,
            creationDate,
            modificationdate
        )
        values
        (
            email,
            applicationId,
            CONCAT_WS(' ',firstName,lastName),
            now(),
            now()
        );
        
        select usr.userId into userId
        from cc_Users as usr
        where lower(usr.email) = lower(email)
        and usr.applicationId = applicationId;
        
        insert into cc_membership
        (
            userId,
            applicationId,
            password,
            passwordFormat,
            passwordAlgorithm,
            passwordSalt,
            passwordQuestion,
            passwordAnswer,
            lastLoginDate,
            creationDate,
            modificationDate
        )
        values
        (
            userId,
            applicationId,
            password,
            passwordFormat,
            passwordAlgorithm,
            passwordSalt,
            passwordQuestion,
            passwordAnswer,
            now(),
            now(),
            now()
        );
        
        insert into cc_userprofile
        (
            userId,
            applicationId,
            firstName,
            lastName,
            country,
            city,
            zipCode,
            specialtyId,
            professionId,
            creationDate,
            modificationDate
        )
        values
        (
            userId,
            applicationId,
            firstName,
            lastName,
            country,
            city,
            zipCode,
            specialtyId,
            professionId,
            now(),
            now()
        );
        
        select userId
        from cc_Users as usr
        where lower(usr.email) = lower(email)
        and usr.applicationId = applicationId;
        
        commit;
        
    else
        select userId;
end if;

END$$

DROP PROCEDURE IF EXISTS `cc_createUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cc_createUser`(
                                In email varchar(45),
                                In password varchar(128),
                                passwordFormat int ,
                                passwordAlgorithm varchar(10),
                                passwordSalt varchar(128),
                                passwordQuestion varchar(128),
                                passwordAnswer varchar (45),
                                appId int,
                                firstName   varchar(45),
                                lastName    varchar(45),
                                country varchar(45),
                                city    varchar(45),
                                zipCode varchar(45),
                                specialtyId int,
                                professionId int
                                )
BEGIN


start transaction;

    
   

    if not exists( select usr.userId
    from cc_users usr
    where usr.email = email
    and usr.applicationId = appId)
    then

    select fn_cc_addUser(email,
                            appId,
                            firstName,
                            lastName);

    
    select fn_cc_createMembership(userId,
                                appId,
                                password,
                                passwordFormat,
                                passwordAlgorithm,
                                passwordSalt,
                                passwordQuestion,
                                passwordAnswer);


    select fn_cc_createProfile
                        (userId,
                        appId,
                        firstName,
                        lastName,
                        country,
                        city,
                        zipCode,
                        specialtyId,
                        professionId);
                        
    select userId 
    from cc_users usr
    where usr.email = email
    and usr.applicationId = appId;
    
    end if;
commit;
END$$

DROP PROCEDURE IF EXISTS `cc_getUserIdByEmail`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cc_getUserIdByEmail`(email varchar(45),
                                       applicationId int)
BEGIN

    select usrs.userId
    from cc_users usrs
    where lower(usrs.email) = lower(email)
    and usrs.applicationId = applicationId;

END$$

DROP PROCEDURE IF EXISTS `cc_getUserPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cc_getUserPassword`(email varchar(45),
                                     applicationId int)
BEGIN
    
    declare userId int;
    select usrs.userID into userId
    from cc_users usrs
    where lower(usrs.email) = lower(email)
    and usrs.applicationId = applicationId; 

    select userId,
           password,
           passwordFormat,
           passwordSalt,
           isApproved
    from cc_membership memb
    where memb.userId = userId
    and memb.applicationId = applicationId;
    
    update cc_membership
    SET lastLoginDate = now()
    WHERE userId = userId
    and applicationId = applicationId;
END$$

DROP PROCEDURE IF EXISTS `cc_updateUserPassword`$$
CREATE DEFINER=`sachin`@`localhost` PROCEDURE `cc_updateUserPassword`( uid int,
                                                                       appId int,
                                                                       newPwd varchar(128))
BEGIN
    
    UPDATE cc_membership
    SET password = newPwd,
    modificationDate = now()
    WHERE userId = uid
    and applicationId = appId; 
END$$

DROP PROCEDURE IF EXISTS `cc_updateUserProfile`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cc_updateUserProfile`(
                                                 IN uid int(11),
                                                 IN appId int(11),
                                                 IN firstName varchar(45),
                                                 IN lastName varchar(45),
                                                 IN country varchar(45),
                                                 IN city varchar(45),
                                                 IN zipCode int(11),
                                                 IN specialtyId int(11),
                                                 IN professionId int(11)
                                                 )
BEGIN

    -- Declare userId int;
    -- SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    -- if(userId != 0)
    -- then            
        UPDATE cc_userProfile 
        SET firstName = firstName,
        lastName = lastName,
        country = country,
        city = city,
        zipCode = zipCode,
        specialtyId = specialtyId,
        professionId = professionId,
        modificationDate = now()
        where userId = uid and applicationId = appId;
    -- end if;

END$$

DROP PROCEDURE IF EXISTS `createAlert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createAlert`(In alertText text
                            ,In startDate datetime
                            ,In endDate datetime)
BEGIN

    Insert into alerts
    (alert,
    startDate,
    endDate
    )
    values
    (alertText,
    startDate,
    endDate
    );

End$$

DROP PROCEDURE IF EXISTS `createBookmark_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createBookmark_`(In email varchar(45)
                                                            ,In pwd varchar(45)
                                                            ,In appId varchar(11)
                                                            ,In productId int(11)                                                            
                                                            ,In pageId varchar(45)
                                                            ,In fileName varchar(45)
                                                            ,In description varchar(45)
                                                            ,In deviceId varchar(45)
                                                            ,Out bookmarkId int(11))
BEGIN
   
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
        Insert into bookmarks
        (productId,
         userId,
         pageId,
         fileName,
         Description,
         creationDate,
         deviceId)
        values
        (productId,
         userId,
         pageId,
         fileName,
         description,
         now(),
         deviceId);

        set bookmarkId = LAST_INSERT_ID();
    end if;
--
     
END$$

DROP PROCEDURE IF EXISTS `createComment_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createComment_`(In email varchar(45)
                                    ,In pwd varchar(45)
                                    ,In appId int(11)
                                    ,In productId int(11)
                                    ,In commentText text
                                    ,In deviceId varchar(45)
                                    ,Out commentId int)
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));

    if(userId != 0)
    then
        Insert Into Comments 
        (userId
        ,applicationId
        ,productId
        ,creationDate
        ,comment
        ,deviceid
        ,IsActive)
        values
        (userId
        ,appId
        ,productId
        ,now()
        ,commentText
        ,deviceId
        ,1);

        set commentId = LAST_INSERT_ID();
    
    end if;

END$$

DROP PROCEDURE IF EXISTS `createDownloadHistory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createDownloadHistory`(IN email varchar(45),
                                                     IN pwd varchar(45),
                                                     IN appId int(11),
                                                     IN productId int(11),
                                                     IN deviceId int(11),
                                                     IN deveiceModel varchar(45),
                                                     IN deviceOS varchar(45),
                                                     IN ipAddress varchar(45),
                                                     IN macAddress varchar(45),
                                                     IN downloadStatus int(11),
                                                     OUT id int(11))
BEGIN
    
    Declare userID int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId !=0 )
    then
            INSERT INTO resourceDownloadHistory
            (userId,
             productId,
             deviceId,
             downloadOn,
             deviceModel,
             deviceOS,
             ipAddress,
             macAddress,
             downloadStatus)
             VALUES
             (userId,
              productId,
              deviceId,
              now(),
              deviceModel,
              deviceOS,
              ipAddress,
              macAddress,
              downloadStatus);
              
              SET id =LAST_INSERT_ID();
        
    end if;
END$$

DROP PROCEDURE IF EXISTS `createNote_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createNote_`(In email varchar(45)
                           ,In pwd varchar(45)
                           ,In appId int(11)
                           ,In productId int(11)
                           ,In noteText text
                           ,In pageId varchar(45)
                           ,In deviceId varchar(45)
                           ,Out noteId int(11))
BEGIN
    declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
        Insert Into Notes 
        (userId,
         productId,
         text,
         pageId,
         creationDate,
         deviceId)
        Values
        (userId,
         productId,
         noteText,
         pageId,
         now(),
         deviceId);

        set noteId = LAST_INSERT_ID();
    
    end if;    

END$$

DROP PROCEDURE IF EXISTS `createRating`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createRating`(IN email varchar(45),
                                            IN pwd varchar(45),
                                            IN appId int(11),
                                            IN productId int(11),
                                            IN rating int(11),
                                            In deviceId varchar(45),
                                            IN outOf int(11),
                                            OUT ratingId int(11))
BEGIN

    declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            INSERT INTO ratings
            (userId,
             applicationId,
             productId,
             rating,
             ratingDateTime,
             deviceid,
             outOf)
             VALUES
             (userId,
              appId,
              productId,
              rating,
              now(),
              deviceId,
              outOf);
            
            set ratingId = LAST_INSERT_ID();
    
    end if;    
END$$

DROP PROCEDURE IF EXISTS `createSubscription`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createSubscription`(In email varchar(45)
                                   ,In pwd varchar(45)
                                   ,In appId int(11)
                                   ,In prvSubscriptionId varchar(45)
                                   ,In productId int(11)
                                   ,In startDate datetime
                                   ,In endDate datetime
                                   ,In type varchar(45)
                                   ,Out subscriptionId int(11))
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));

    if(userId != 0)
    then
        Insert into Subscriptions
        (previousSubscriptionId
        ,userId
        ,productId
        ,creationDate
        ,startDate
        ,endDate
        ,status
        ,type)
        values
        (prvSubscriptionId
        ,userId
        ,productId
        ,now()
        ,startDate
        ,endDate
        ,1
        ,type);

        set subscriptionId = LAST_INSERT_ID();
    
    end if;
END$$

DROP PROCEDURE IF EXISTS `deleteBookmark`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBookmark`(In email varchar(45)
                                            ,In pwd varchar(45)
                                            ,In appId int(11)
                                            ,In bookmarkId int(11))
BEGIN
     
    Declare userId int(11);
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
        Delete from Bookmarks
        where BookmarkId = bookmarkId
        LIMIT 1;
    
    end if;
END$$

DROP PROCEDURE IF EXISTS `deleteComment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteComment`(In email varchar(45)
                                            ,In pwd varchar(45)
                                            ,In appId int(11)
                                            ,In commentId int(11))
BEGIN
    
    --
    Declare userId int(11);
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));

    if(userId != 0)
    then
        update Comments
        set IsActive = 0,modificationDate = now()
        where CommentId = commentId
        LIMIT 1;
    
    end if;
END$$

DROP PROCEDURE IF EXISTS `deleteNote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteNote`(In email varchar(45)
                                                        ,In pwd varchar(45)
                                                        ,In appId int(11)
                                                        ,In noteId int(11))
BEGIN

    Declare userId int(11);
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));

    if(userId != 0)
    then
        Delete from Notes 
        where noteId = noteId
        LIMIT 1;
    end if;    
    
END$$

DROP PROCEDURE IF EXISTS `getAllBookmarks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllBookmarks`(IN email varchar(45),
                                               IN pwd varchar(45),
                                               IN appId int(11))
BEGIN

    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT bk.productId,bk.userId,bk.filename,bk.description,bk.creationDate,
                   prd.title,usr.firstName,sp.specialty,pr.profession
            FROM bookmarks bk
            INNER JOIN product prd
            ON bk.productId = prd.productId
            INNER JOIN cc_userprofile usr
            ON bk.userId = usr.userId
            INNER JOIN specialty sp
            ON usr.specialtyId = sp.specialtyId
            INNER JOIN profession pr
            ON usr.professionId = pr.professionId
            ;
            
    end if;
END$$

DROP PROCEDURE IF EXISTS `getAllComments`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllComments`(IN email varchar(45),
                                              IN pwd varchar(45),
                                              IN appId int(11))
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT cc.productId,cc.userId,cc.comment,cc.creationDate,
                   prd.title,usr.firstName,sp.specialty,pr.profession
            FROM comments cc
            INNER JOIN product prd
            ON cc.productId = prd.productId
            INNER JOIN cc_userprofile usr
            ON cc.userId = usr.userId
            INNER JOIN specialty sp
            ON usr.specialtyId = sp.specialtyId
            INNER JOIN profession pr
            ON usr.professionId = pr.professionId
            where cc.IsActive = 1;
    
    end if;


END$$

DROP PROCEDURE IF EXISTS `getAllDownloadHistoryDelta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllDownloadHistoryDelta`(IN email varchar(45),
                                                            IN pwd varchar(45),
                                                            IN appId int(11),
                                                            IN lastSyncDate datetime
                                                            )
BEGIN
        
        declare userId int;
        SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
        
        if(userId != 0)
        then
                SELECT * 
                FROM resourcedownloadhistory
                WHERE downloadOn >= lastSyncDate;
                
        end if;

END$$

DROP PROCEDURE IF EXISTS `getAllNotes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllNotes`(IN email varchar(45),
                                           IN pwd varchar(45),
                                           IN appId int(11))
BEGIN

    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT *
            FROM notes;
            
    end if;

END$$

DROP PROCEDURE IF EXISTS `getAllProductSubscriptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllProductSubscriptions`( 
    IN email varchar (45),
    IN pwd varchar(45),
    IN appId int(11))
BEGIN

    Declare userId int;
    SET userId = (select fn_cc_authenticate(email,pwd,appId));

    if(userId != 0)
    then
        SELECT sub.*,prd.title as title
            FROM Subscriptions sub 
            INNER JOIN Product prd
            ON sub.productId = prd.productId;
    
    end if;

END$$

DROP PROCEDURE IF EXISTS `getAllProductSubscriptionsDelta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllProductSubscriptionsDelta`(IN email varchar(45)
                                                                     ,IN appId int(11)
                                                                     ,IN pwd varchar(45)
                                                                     ,IN lastSyncDate datetime
                                                                     )
BEGIN
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT *,(select prd.title from product prd 
            where prd.productID = sub.productId) as title
            FROM Subscriptions sub
            where sub.creationDate >= lastSyncDate;
            
    end if; 
END$$

DROP PROCEDURE IF EXISTS `getProductCatalog`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductCatalog`()
BEGIN
    SELECT * , 
    (select name 
    from authoringorganizations 
    where authoringOrgId = prd.authoringOrganizationId) as authoringOrganization
    FROM product prd;
END$$

DROP PROCEDURE IF EXISTS `getProductCatalogDelta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductCatalogDelta`(IN lastSyncDate datetime)
BEGIN    
    SELECT * , 
    (select authoringOrganization 
    from authoringorganizations 
    where authoringOrgId = prd.authoringOrganizationId) as authoringOrganization
    FROM product prd
    WHERE creationDate >= lastSyncDate OR modificationDate >= lastSyncDate;
END$$

DROP PROCEDURE IF EXISTS `getProductRating`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductRating`(IN email varchar(45),
                                                IN pwd varchar(45),
                                                IN appId int(11)
                                                )
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
   
    if(userId != 0)
    then
                SELECT prod.productId,prod.title,rt.rating,
                rt.outOf,rt.ratingDateTime,
                usr.userId,usr.firstName,usr.lastName
                FROM ratings rt
                INNER JOIN cc_userprofile usr
                ON rt.userId = usr.userId
                INNER JOIN product prod
                ON rt.productId = prod.productId;
                
    end if;
                        
END$$

DROP PROCEDURE IF EXISTS `getProductsByCategory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductsByCategory`()
BEGIN
        SELECT prod.productID,prod.title,
        cat.category,cat.description
        FROM product prod
        INNER JOIN productsbycategory pcat
        ON prod.productId = pcat.productId
        INNER JOIN productcategory cat
        ON pcat.categoryId = cat.productCategoryId
        GROUP BY cat.productCategoryId;
END$$

DROP PROCEDURE IF EXISTS `getProductsByProfession`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductsByProfession`()
BEGIN
   
        select prod.ProductID,prod.title,
        prof.profession,prof.description
        from Product prod
        inner join ProductsByProfession pprof
        on(prod.ProductId = pprof.productId)
        inner join Profession prof
        on(pprof.professionId = prof.professionId)
        group by prof.professionId;


END$$

DROP PROCEDURE IF EXISTS `getProductsBySpecialty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductsBySpecialty`()
BEGIN

        select prod.ProductID,prod.title,
        spec.specialty,spec.description
        from Product prod
        inner join ProductsBySpecialty pspec
        on(prod.ProductId = pspec.productId)
        inner join Specialty spec
        on(pspec.specialtyId = spec.specialtyID)
        group by spec.specialtyId;

END$$

DROP PROCEDURE IF EXISTS `getProductSubscriptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductSubscriptions`(IN email varchar(45)
                                                                          ,IN pwd varchar(45)
                                                                          ,IN appId int(11)
                                                                          ,IN productId int(11)
                                                                          )
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
        
        if(userId != 0)
        then
            SELECT * , (select prd.title from product prd
            where prd.productId = sub.productId) as title
            FROM subscriptions sub
            WHERE sub.productId = productId;
        end if;
END$$

DROP PROCEDURE IF EXISTS `getUserBookmarks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserBookmarks`(IN userId int(11))
BEGIN
    
    -- Declare userId int;
    -- SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    -- if(userId != 0)
    -- then
            SELECT *
            FROM bookmarks bk
            WHERE bk.userId = userId;
            
    -- end if;

END$$

DROP PROCEDURE IF EXISTS `getUserBookmarksDelta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserBookmarksDelta`(In userId int(11),
                                                       In lastSyncDate datetime)
BEGIN

    -- Declare userId int;
    -- SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));

    -- if(userId != 0)
    -- then
            SELECT *
            FROM bookmarks
            WHERE creationDate >= lastSyncDate and userId = userId;
            
    -- end if;
END$$

DROP PROCEDURE IF EXISTS `getUserBookmarksDelta_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserBookmarksDelta_`(IN email varchar(45),
                                                       IN pwd varchar(45),
                                                       IN appId int(11),
                                                       In lastSyncDate datetime)
BEGIN

    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));

    if(userId != 0)
    then
            SELECT *
            FROM bookmarks
            WHERE creationDate >= lastSyncDate;
            
    end if;
END$$

DROP PROCEDURE IF EXISTS `getUserBookmarks_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserBookmarks_`(IN email varchar(45),
                                                  IN pwd varchar(45),
                                                  IN appId int(11))
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT *
            FROM bookmarks bk
            WHERE bk.userId = userId;
            
    end if;

END$$

DROP PROCEDURE IF EXISTS `getUserComments`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserComments`(In userId int(11))
BEGIN

    -- Declare userId int;
    -- SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    -- If(userId != 0)
    -- then
            SELECT * 
            FROM comments
            WHERE userId = userId
            and IsActive = 1;
            
    -- end If;
END$$

DROP PROCEDURE IF EXISTS `getUserCommentsDelta_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserCommentsDelta_`(IN email varchar(45),
                                                      IN pwd varchar(45),
                                                      IN appId int(11),
                                                      IN commentDate datetime
                                                      )
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT * 
            FROM comments
            WHERE creationDate >= commentDate
            and userId = userId;
    end if;            
END$$

DROP PROCEDURE IF EXISTS `getUserComments_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserComments_`(IN email varchar(45)
                                             ,IN pwd varchar(45)
                                             ,IN appId int(11))
BEGIN

    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    If(userId != 0)
    then
            SELECT * 
            FROM comments
            WHERE userId = userId
            and IsActive = 1;
            
    end If;
END$$

DROP PROCEDURE IF EXISTS `getUserDownloadHistory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserDownloadHistory`(IN email varchar(45),
                                                  IN pwd varchar(45),
                                                  IN appId int(11)
                                                 )
BEGIN

    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT * 
            FROM resourceDownloadHistory
            WHERE userId = userId;
            
    end if;
    
END$$

DROP PROCEDURE IF EXISTS `getUserNotes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserNotes`(In userId int(11)
                                              )
BEGIN

    -- Declare userId int;
    -- SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    -- if(userId != 0)
    -- then
            SELECT * 
            FROM notes
            WHERE userId = userId;
            
    -- end if;

END$$

DROP PROCEDURE IF EXISTS `getUserNotesDelta`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserNotesDelta`(In userId int(11),
                                                   IN lastSyncDate datetime)
BEGIN
    
    -- Declare userId int;
    -- SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    -- if(userId != 0)
    -- then
            SELECT * 
            FROM notes
            WHERE userId = userId 
            and creationDate >= lastSyncDate;
            
    -- end if;
END$$

DROP PROCEDURE IF EXISTS `getUserNotesDelta_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserNotesDelta_`(IN email varchar(45),
                                                   IN pwd varchar(45),
                                                   IN appId int(11),
                                                   IN lastSyncDate datetime)
BEGIN
    
    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT * 
            FROM notes
            WHERE userId = userId 
            and creationDate >= lastSyncDate;
            
    end if;
END$$

DROP PROCEDURE IF EXISTS `getUserNotes_`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserNotes_`(IN email varchar(45),
                                              IN pwd varchar(45),
                                              IN appId varchar(11)
                                              )
BEGIN

    Declare userId int;
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0)
    then
            SELECT * 
            FROM notes
            WHERE userId = userId;
            
    end if;

END$$

DROP PROCEDURE IF EXISTS `getUserSubscriptions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserSubscriptions`(In email varchar(45),
                                                                         In pwd varchar (45),
                                                                         IN appId int(11)
                                                                         )
BEGIN
    
    Declare userId int; 
    SET userId = (select fn_cc_authenticate(email,pwd,appId));
    if(userId != 0)
    then
            SELECT sub.*, (select prd.title from product prd
            where prd.productId = sub.productId) as title
            FROM Subscriptions sub 
            WHERE sub.userId = userId;
    end if;
END$$

DROP PROCEDURE IF EXISTS `updateDownloadHistory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateDownloadHistory`(IN email varchar(45),
                                                     IN pwd varchar(45),
                                                     IN appId int(11),
                                                     IN downloadHistoryId int(11),
                                                     IN downloadStatus int(11))
BEGIN
    
    Declare userId int; 
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));
    
    if(userId != 0 )
    then
            UPDATE resourcedownloadhistory
            SET downloadOn = now(),
                downloadStatus = downloadStatus
            WHERE 
                downloadHistoryId = downloadHistoryId;
    
    end if;
END$$

DROP PROCEDURE IF EXISTS `updateNote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateNote`(In email varchar(45)
                            ,In pwd varchar(45)
                            ,In appId int(11)
                            ,In productId int(11)
                            ,In noteText text
                            ,In pageid varchar(45)
                            ,In deviceId int
                            ,out noteId int)
BEGIN        
    Declare userId int(11);
    SET userId = (SELECT fn_cc_authenticate(email,pwd,appId));

    if(userId != 0)
    then
        Insert into Notes
        (userId,
         productId,
         text,
         pageId,
         creationDate,
         deviceId
         )
        values
        (userId,
        productId,
        noteText,
        pageId,
        now(),
        deviceId
        );       
        set noteId = LAST_INSERT_ID();
    end if;                  
END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `fn_cc_addUser`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cc_addUser`(
                            email varchar(45),
                            applicationId int,
                            firstName varchar(45),
                            lastName  varchar(45)
                            ) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE userID int;
    set userId = 0;
    IF not exists(
                    select usr.userId
                    from cc_Users as usr
                    where lower(usr.email) = lower(email)
                    and usr.applicationId = applicationId
                  )
    THEN
        insert into cc_users
        (
            email,
            applicationId,
            userName,
            creationDate,
            modificationdate
        )
        values
        (
            email,
            applicationId,
            CONCAT_WS(' ',firstName,lastName),
            now(),
            now()
        );

        set userId = last_insert_id();
    END IF;
    
    return userId;
END$$

DROP FUNCTION IF EXISTS `fn_cc_authenticate`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cc_authenticate`(email varchar(45),
                                    pwd varchar(128),
                                    appId int(11)) RETURNS int(11)
    DETERMINISTIC
begin
    Declare userId int(11);

    set userId = (select usr.userId 
                  from CC_Users as usr 
                  where usr.email = email 
                  and usr.applicationId = appId);

    if not exists(
                    select userId 
                    from CC_Membership as mem
                    where mem.userId = userId 
                    and mem.password = pwd 
                    and mem.applicationId = appId)
    then
        set userId = 0; 
    end if;

return userId;
end$$

DROP FUNCTION IF EXISTS `fn_cc_createMembership`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cc_createMembership`(
                                       userId int,
                                       applicationId int, 
                                       password varchar(128),
                                       passwordFormat int,
                                       passwordAlgorithm varchar(10),
                                       passwordSalt varchar(128),
                                       passwordQuestion varchar(128),
                                       passwordAnswer varchar(45)
                                       ) RETURNS int(11)
    DETERMINISTIC
BEGIN
    
    insert into cc_membership
    (
        userId,
        applicationId,
        password,
        passwordFormat,
        passwordAlgorithm,
        passwordSalt,
        passwordQuestion,
        passwordAnswer,
        lastLoginDate,
        creationTime,
        modificationDate
    )
    values
    (
        userId,
        applicationId,
        password,
        passwordFormat,
        passwordAlgorithm,
        passwordSalt,
        passwordQuestion,
        passwordAnswer,
        "",
        now(),
        now()
    );
    
    return userId;
END$$

DROP FUNCTION IF EXISTS `fn_cc_createProfile`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cc_createProfile`(
                                            userId  int,
                                            applicationId  int,
                                            firstName   varchar(45),
                                            lastname    varchar(45),
                                            country varchar(45),
                                            city    varchar(45),
                                            zipCode varchar(45),
                                            specialtyId int,
                                            professionId int) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE userId int;
    set userId = 0;
    insert into cc_userprofile
    (
        userId,
        applicationId,
        firstName,
        lastName,
        country,
        city,
        zipCode,
        specialtyId,
        professionId,
        creationDate,
        modificationDate
    )
    values
    (
        userId,
        applicationId,
        firstName,
        lastName,
        country,
        city,
        zipCode,
        specialtyId,
        professionId,
        now(),
        now()
    );
    return userId;
    --
--
END$$

DROP FUNCTION IF EXISTS `fn_cc_createUser`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cc_createUser`(
                            email varchar(45),
                            applicationId int,
                            firstName varchar(45),
                            lastName  varchar(45)
                            ) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE userID int;
    set userId = 0;
    IF not exists(
                    select usr.userId
                    from cc_Users as usr
                    where lower(usr.email) = lower(email)
                    and usr.applicationId = applicationId
                  )
    THEN
        insert into cc_users
        (
            email,
            applicationId,
            userName,
            creationDate,
            modificationdate
        )
        values
        (
            email,
            applicationId,
            CONCAT_WS(' ',firstName,lastName),
            now(),
            now()
        );

        set userId = last_insert_id();
    END IF;
    
    return userId;
END$$

DELIMITER ;
