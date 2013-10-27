<?php
/**
 * This class maintains various application configurations.
 * @author : Sachin R K
 * @date :30-04-2012
 * @copyright: Mobiuso LLC
 */
class Configuration
{
	/* Database host name or IP*/
	const HOST = "localhost";
	 
	/* Database user name*/
	const DB_USER = "rushabh";
	
	/* Database user password*/
	const DB_PWD = "rushabh";
	
	/* Database schema */
	const DB_SCHEMA = "igcdevdb_v01-6";
	
	/*Application Id*/
	const APP_ID = "1";	
	
	/* Mail From */
	const MAIL_FROM = "donotreply@igc.com";
	
	/* Mail CC */
	const MAIL_CC = "isrkadam@gmail.com";
	
	/* Mail BCC */
	const MAIL_BCC = "sachin@mobiuso.com";
	
	/* Membership Confirmation Mail */
	const MAIL_SUBJECT = "IGC Membership Confirmation";
	
	/* Membership mail body */
	const MAIL_BODY = "Thanks for registering to IGC. Please click on the link to confirm your mrmbership.";
	
	/* Membership ACtivation Link */
	const MEMBERSHIP_APPROVAL_LINK = "ActivateMembership.php";
	
	/* User Sandbox root folder */
	const SANDBOX_ROOT = "UserSandbox";
}

?>