<?php
/**
 * 
 * This class encapsulates cryptographic functions.
 * @author Sachin R K
 * @Date 30-04-2012
 * @copyright Mobiuso LLC.
 * 
 */

include_once "Configuration.php";

class  CryptoClass
{
	private $_salt ;
	private $_sha256key;
	private $_alogorithm;
   
   /**
	* 
	* Initialise the Salt and SHA256 Key
	*/
	public function __construct()
	{
		
	}
   
   /**
	* 
	* Used to Generate a Random SALT
	*/
	private function generateSalt()
	{
		//return mcrypt_create_iv(16,MCRYPT_DEV_RANDOM);
	}
    
   /**
	* 
	* Used to Get the algorithm used by encryption
	*/
	public function getAlogrithm()
	{
		return $this->_algorithm;
	}
	
   /**
	* 
	* Returns the Salt Value used.
	*/
	public function getSaltValue()
	{
		$this->_salt = "NA";
		return $this->_salt;
	}
   
	/**
	 * Encrypts the passed parameter in MD5 format.
	 */
	public function encryptMd5($value)
	{
		$this->_algorithm = "md5";
		return md5($value);
	}
	
	/**
	 * Encrypts the passed value in sh1 format.
	 */
	public function encryptSh1($value)
	{
		$this->_algorithm = "sh1";
		return sh1($value);
	}
	
	
   /**
	* 
	* Encrypts the value with randomly generated salt. 
	* So consumer of this class should first encrypt
	* the passed value and then call the function "getSaltValue"
	* to fetch the salt used in encryption.
	* @param $value
	*/
	public function encrypt($value)
	{
		//$this->_salt = "igc20051a389f7he";
		$this->_salt = $this->generateSalt();
		$this->_sha256key="\$5\$rounds=5000\$".$this->_salt."\$";
		$crypted = crypt($value,$this->_sha256key);
		$this->_algorithm = "sha256";
		return substr($crypted,strlen($this->_sha256key));
	}
	
	/**
	 * Encrypts the value with given salt.
	 */
	public function encryptWithGivenSalt($value,$salt)
	{
		$this->_sha256key = "\$5\$rounds=5000\$".$salt."\$";
		$crypted = crypt($value,$this->_sha256key);
		return substr($crypted,strlen($this->_sha256key));
	}
}
?>