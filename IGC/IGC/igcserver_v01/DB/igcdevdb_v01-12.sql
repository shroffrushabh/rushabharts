-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 06, 2012 at 06:27 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

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

-- --------------------------------------------------------

--
-- Table structure for table `productbysubcategory`
--

DROP TABLE IF EXISTS `productbysubcategory`;
CREATE TABLE IF NOT EXISTS `productbysubcategory` (
  `productId` int(11) NOT NULL,
  `subCategory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

-- --------------------------------------------------------

--
-- Table structure for table `productsbyprofession`
--

DROP TABLE IF EXISTS `productsbyprofession`;
CREATE TABLE IF NOT EXISTS `productsbyprofession` (
  `productId` int(11) NOT NULL,
  `professionId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `productsbyspecialty`
--

DROP TABLE IF EXISTS `productsbyspecialty`;
CREATE TABLE IF NOT EXISTS `productsbyspecialty` (
  `productId` int(11) NOT NULL,
  `specialtyId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
