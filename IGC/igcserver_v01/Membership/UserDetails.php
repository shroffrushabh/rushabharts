<?php
/*
 * @author : Sachin R K
 * @date :30-04-2012
 * @copyright: Mobiuso LLC
 */


/*
 *  This class encapsulates user details.
 */
class UserDetails
{
	private $_email;
	private $_password;
	private $_passwordFormat;
	private $_passwordSalt;
	private $_passwordQuestion;
	private $_passwordAnswer;	
	private $_firstName;
	private $_lastName;
	private $_country;
	private $_city;
	private $_zipCode;
	private $_specialtyId;
	private $_professionId;
	private $_applicationId;
	
	/**
	 * 
	 * Constructor
	 * @param $applicationId - Id the Application
	 * @param $username - email id of the User
	 */
	public function __construct()
	{		
		
	}
	
	public function getEmail()
	{
		return $this->_email;
	}		
		
	public function setEmail($emailId)
	{
		$this->_email = $emailId;
	} 
	/**
	 * 
	 * Encrypted password for that user.
	 */
	public function getPassword()
	{
		return $this->_password;
	}
	
	public function setPassword($password)
	{
		$this->_password = $password;
	} 
	
	public function getPasswordFormat()
	{
		return $this->_passwordFormat;
	}

	public function setPasswordFormat($passwordFormat)
	{
		$this->_passwordFormat = $passwordFormat;
	}
	
	public function getPasswordSalt()
	{
		return $this->_passwordSalt;
	}

	public function setPasswordSalt($passwordSalt)
	{
		$this->_passwordSalt = $passwordSalt;
	}
	
	public function getPasswordQuestion()
	{
		return $this->_passwordQuestion;
	}

	public function setPasswordQuestion($passwordQuestion) 
	{
		$this->_passwordQuestion = $passwordQuestion;
	}
	
	public function getPasswordAnswer()
	{
		return $this->_passwordAnswer;
	}
	
	public function setPasswordAnswer($passwordAnswer)
	{
		$this->_passwordAnswer = $passwordAnswer;
	}
	
	public function getFirstName()
	{
		return $this->_firstName;
	}
	
	public function setFirstName($firstName)
	{
		$this->_firstName = $firstName;
	}

	public function getLastName()
	{
		return $this->_lastName;
	}
	
	public function setLastName($lastName)
	{
		$this->_lastName = $lastName;
	}
	
	public function getCountry()
	{
		return $this->_country;
	}
	
	public function setCountry($country)
	{
		return $this->_country = $country;
	}
		
	public function getCity()
	{
		return $this->_city;
	}
	
	public function setCity($city)
	{
		return $this->_city = $city;
	}
	
	public function getZipCode()
	{
		return $this->_zipCode;
	}
	
	public function setZipCode($zipCode)
	{
		$this->_zipCode = $zipCode; 
	}
	
	public function getSpecialtyId()
	{
		return $this->_specialtyId;
	}
	
	public function setSpecialtyId($specialtyId)
	{
		return $this->_specialtyId = $specialtyId; 
	}
	
	public function getProfessionId()
	{
		return $this->_professionId;
	}

	public function setProfessionId($professionId)
	{
		return $this->_professionId = $professionId;
	}
	
	public function getApplicationId()
	{
		return $this->_applicationId;
	}
	
	public function setApplicationId($applicationId)
	{
		$this->_applicationId = $applicationId;
	}
	
}
?>
