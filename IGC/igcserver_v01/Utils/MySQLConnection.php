<?php
/**
 * This class encapsulates functions to connect
 * MySQL db , execute query & get query results.
 * @author Sachin R K
 * @date 30-04-2012
 * @copyright Mobiuso LLC
 */
class MySQLConnection
{	
	private $_connection;
	private $_host;
	private $_username;
	private $_password;
	private $_schema;
	private $_result;
	
	
   /**
	* 
	* <p>Constucts the connection string & initialize the connection.</p>
	* @param $host 
	* @param $username
	* @param $password
	* @param $schema
	*/
	public  function __construct($host,
								$username,
								$password,
								$schema)
	{
		$this->_host=$host;
		$this->_username=$username;
		$this->_password=$password;
		$this->_schema=$schema;
		$this->connect();
	}
	
   /**
	* Opens a new persistent connection.
	*/
	private function connect()
	{
		
		$this->_connection = new mysqli($this->_host,
							 $this->_username,
							 $this->_password,
							 $this->_schema);
		if ($this->_connection->connect_errno) 
		{
    		//echo "MySQLConnection->connect->Failed to connect to MySQL - " . $this->_connection->connect_error;
    		throw new Exception("Failed to connect to MySQL Database.",$this->_connection->connect_error);
		}
	}
	
   /**
	* 
	* Closes the created connection
	*/
	public function close()
	{
		$this->_connection->close();
	}

   /**
	* 
	* Executes the provided statement. Returns
	* the resultset.
	* 
	* @param query string
	*/
	public function executeQuery($stmt)
	{
		//echo "MySQLConnection->executeQuery->Query Text - ".$stmt;
		$selectedRows = array();
		$result = $this->_connection->query($stmt);
		//echo "MySQLConnection->executeQuery->result dump - ".var_dump($result);
		if($result)
		{
			if(!is_null($result))
			{	
				//echo "MySQLConnection->executeQuery->Valid Result - ";
				//echo "MySQLConnection->executeQuery->Number of rows returned - " . mysqli_num_rows($result);
					
				$i = 0;
				//Cycle through results
	     		while ($row = $result->fetch_assoc())
	     		{
	         		$selectedRows[$i] = $row;
	         		$i++;
	         		//echo "MySQLConnection->executeQuery->Dump of result row - ".$i." - ".var_dump($row);
	         		//echo "MySQLConnection->executeQuery->Dump of selectedRows array - ".var_dump($selectedRows);
	     		}
	     		/*
	     		 * Free result set
	     		 */
	     		$result->close();
	     		/*
	     		 * Close the connection 
	     		 */
	     		//$this->close();
	     		return $selectedRows;
			}
			else 
			{
				//$this->close();
				return $selectedRows;
			}
		}
		else
		{
			//$this->close();
			return $selectedRows;
		}
	}

	/*
	 * Executes the provided statement. Returns
	 * the status. 
	 * Returns 'false' if failure else returns true.
	 * 
	 * @param query string
	 */
	public function executeNonQuery($stmt)
	{
			$afftectedRows = 0;
			$result = $this->_connection->query($stmt);
			$afftectedRows = mysqli_affected_rows($this->_connection);
			if($result)
			{
				/*
     		     * Free result set
     		     */
     			$result->close();
				//$this->close();
				return $afftectedRows;
     		}
     		/*else 
     		{
    			//$this->close();
     			//echo "MySQLConnection->executeQuery->Failed to execute query - " . $this->_connection->error;
				//throw new Exception("Failed to execute query.",$this->_connection->error);
     		}*/
     		return $afftectedRows;
	}
}
?>