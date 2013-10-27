<?php
/**
 * Connection Factory Class
 * @author : Sachin R K
 * @date :30-04-2012
 * @copyright: Mobiuso LLC
 */
include_once "Configuration.php";
include_once "MySQLConnection.php";
class ConnectionFactory
{
	public static function getMySQLConnection()
	{
		/*echo "ConnectionFactory->getMySQLConnection->configuration details : HOST: ".Configuration::HOST 
									." DB_USER: "
									.Configuration::DB_USER
									." DB_PWD: "
									.Configuration::DB_PWD
									." DB_SCHEMA: "
									.Configuration::DB_SCHEMA;*/
		
		$mySQLConnection = new MySQLConnection(Configuration::HOST,
												Configuration::DB_USER, 
												Configuration::DB_PWD, 
												Configuration::DB_SCHEMA);
		return $mySQLConnection;
	}
}
?>