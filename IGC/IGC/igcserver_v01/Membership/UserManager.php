<?php
/**
 * @author : Sachin R K
 * @date :30-04-2012
 * @copyright: Mobiuso LLC
 */

include_once "../Utils/CryptoClass.php";
include_once "../Utils/PasswordFormats.php";
include_once "../Utils/MessageCollection.php";
include_once "../Utils/ConnectionFactory.php";
include_once "../Utils/Mail.php";
include_once "../CustomExceptions/IGCAppExceptions.php";
include_once "./UserDetails.php";

class UserManager
{	
	function __construct()
	{
		;
	}
	
	/**
	 * 
	 * Sends membership approval email to newly registered user
	 * @param $toEmail
	 * @param $userID
	 * @param $appId
	 * @return bool true if the mail was successfully accepted for delivery,
	 *         false otherwise. 
	 * 
	 */
	private function sendEmailForMembershipConfirmation($toEmail,
														$userID,
														$appId)
	{	
		$url = "http://".Configuration::HOST."/";
		$url = $url.Configuration::MEMBERSHIP_APPROVAL_LINK;
		$url = $url."?uid=";
		$url = $url.$userID;
		$url = $url."&";
		$url = $url."aid=";
		$url = $url.$appId;
		$url = addslashes($url);
		
		//echo "Membership Approval URL is : " .$url;
		
		$message = Configuration::MAIL_BODY." ".$url;
		//echo "Membership Approval Message is " .$message;
		
		Mail::sendMail(Configuration::MAIL_FROM,
							  $toEmail,
							  Configuration::MAIL_CC,
							  Configuration::MAIL_BCC,
							  Configuration::MAIL_SUBJECT,
							  Configuration::MAIL_BODY);
	}
	
	/**
	 * 
	 * Checks if user already exists.
	 * @param $userName
	 * @param $applicationId
	 * @return bool true if user exists else returns false.
	 */
	private function userExists($userName,
								  $applicationId)
	{
		$exists = false;
		$mySqlConnection = 0;
		try 
		{
			$applicationId != 0 ? $applicationId: $applicationId = Configuration::APP_ID; 
			$mySqlConnection = ConnectionFactory::getMySQLConnection();
			$result = $mySqlConnection->executeQuery("Call cc_getUserPassword(
																	'$userName',
																	'$applicationId'	
																	)");
			//echo "user exist result 1".var_dump($result);
			if (count($result)>0)
			{
				//echo "user exist result 2".var_dump($result);
				$exists = true;
			}
		}
		catch(Exception $exec)
		{
			$mySqlConnection->close();
			throw $exec;	
		}
		
		//echo "user exist returns";
		$mySqlConnection->close();
		return $exists;
	} 
	
	/**
	 * 
	 * Creates user with all the info provided also 
	 * creates corresponsing records in cc_membership 
	 * and cc_userprofile table.
	 * @param $objUserDetails
	 * @return  userId if successful. Throws appropriate 
	 *          if user already exists or for some reason user
	 *          could not be created.
	 */
	function createUser(UserDetails $objUserDetails)
	{
		$crypticPassword = 0;
		$passwordFormat = 0;
		$cryptAlgo = 0;
		$cryptoSalt = 0;
		$mySQLConnection = 0;			
				
		try
		{
			$applicationId = $objUserDetails->getApplicationId();
			$applicationId != 0 ? $applicationId: $applicationId = Configuration::APP_ID;
			
			$email = $objUserDetails->getEmail();
			if (!$this->userExists($email,$applicationId))
			{
				$userId = 0;
				$mySQLConnection = ConnectionFactory::getMySQLConnection();
				$objCrypto = new CryptoClass();
				$crypticPassword = $objCrypto->encryptMd5($objUserDetails->getPassword());
				$passwordFormat = PasswordFormats::$ENCRYPTED;
				$cryptAlgo = $objCrypto->getAlogrithm();
				$cryptSalt = addslashes($objCrypto->getSaltValue());
				
				//$cryptSalt = "somesalt";
				//$crypticPassword = "somepwd";
			
				$passwordQuestion = $objUserDetails->getPasswordQuestion();
				$passwordAnswer = $objUserDetails->getPasswordAnswer();
				$firstName = $objUserDetails->getFirstName();
				$lastName = $objUserDetails->getLastName();
				$country = $objUserDetails->getCountry();
				$city = $objUserDetails->getCity();
				$zipCode = $objUserDetails->getZipCode();
				$specialtyId = $objUserDetails->getSpecialtyId();
				$professionId = $objUserDetails->getProfessionId();
				
				//echo "Crypto Salt ".$cryptSalt;
				//echo "Cryptic PWD ".$crypticPassword; 
				
				$result = $mySQLConnection->executeQuery("CALL cc_createNewUser
												(
														'$email',
														'$crypticPassword',
														'$passwordFormat',
														'$cryptAlgo',
														'$cryptSalt',
														'$passwordQuestion',
														'$passwordAnswer',
														'$applicationId',
														'$firstName',
														'$lastName',
														'$country',
														'$city',
														'$zipCode',
														'$specialtyId',
														'$professionId'
												)"
											);
				if(count($result) > 0)
				{
					/* 
					 * User creation successful
					 * Send membership confirmation email 
					 */
					/*$this->sendEmailForMembershipConfirmation($email,
															$userId,
															$applicationId);*/
					$userId = $result[0]['userId'];
					if ($userId > 0)
					{
						$mySQLConnection->close();
						return $result;
						//return $userId;
					}
					else
					{
						/* Failed to create user */
						$mySQLConnection->close();
						$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(101),101);
						throw $objIGCAppExec;
						//return 0;
					}
				}
				else
				{
					/* Failed to create user */
					$mySQLConnection->close();
					$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(101),101);
					throw $objIGCAppExec;
					//return 0;
				}
			}
			else
			{
				/* User with email id already exists */
				//echo "User with email id already exists";
				$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(100),100);
				throw $objIGCAppExec;
				//return -1;
			}
		}
		catch (IGCAppException $IGCExec)
		{
			//$mySQLConnection->close();
			throw $IGCExec;
		}
		catch(Exception $exec)
		{
			//$mySQLConnection->close();
			throw $exec;
		}
		$mySQLConnection->close();
	}
	
	/**
	 * 
	 * Validates user based on email,password & application Id
	 * encrypts the password passed as parameter with the salt 
	 * maintened in db and compares with password maintained in db. 
	 * if both passwords match the user is valid.
	 * 
	 * @param $applicationId
	 * @param $userName
	 * @param $password
	 * 
	 * @return user Details if successful. Throws appropriate exception
	 * in case of invalid user name or passowrd OR the user membership
	 * is not approved.
     */
	function validateUser($applicationId,
							$userName,
							$password)
	{
		$mySQLConnection;
		try
		{
			$applicationId != 0 ? $applicationId: $applicationId = Configuration::APP_ID; 
			$mySQLConnection = ConnectionFactory::getMySQLConnection();
			
			$result = $mySQLConnection->executeQuery("Call cc_getUserPasswordNProfile(
					'$userName',
					'$applicationId'
			)");
			
			/* $result = $mySQLConnection->executeQuery("Call cc_getUserPassword(
																'$userName',
																'$applicationId'	
																)"); */
			if(count($result)>0)
			{
				$fetchedPassword = $result[0]['password'];
				$fetchedSalt = $result[0]['passwordSalt'];
				$isApproved = $result[0]['isApproved'];
			
				if ($isApproved == 1)
				{
					$objCrypto = new CryptoClass();
					
					$encryptedPassword = $objCrypto->encryptMd5($password);
					
					//echo "UserManager->ValidateUser->encryptedPassword : ".$encryptedPassword;
					//echo "UserManager->ValidateUser->fetchedPassword : ".$fetchedPassword;
					//var_dump($encryptedPassword);
					//var_dump($fetchedPassword);
					if ($encryptedPassword == $fetchedPassword)
					{ 
						/* 
						 * Valid User , return userId
						 */
						$result[0]['password'] = "######";
						$result[0]['passwordSalt'] = "######";
						$mySqlConnection->close();
						return $result;
					}
					else
					{
						/* 
						 * Invalid User name or password 
						 */
						$mySQLConnection->close();
						$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(103),103);
						throw $objIGCAppExec;
						//return 0;
					}
				}
				else
				{
					/*
					 * Registration incomplete.Confirmation from user is pending.
					 */
					$mySQLConnection->close();
					$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(102),102);
					throw $objIGCAppExec;
					//return -1;
				}
			}
			else
			{
				/* Invalid User name or password */
				$mySQLConnection->close();
				$objIGCAppExec = new IGCAppException(ErrorMessageCollection::getMessage(103),103);
				throw $objIGCAppExec;
				//return 0;
			}
		}
		catch (IGCAppException $IGCExec)
		{
			//$mySQLConnection->close();
			throw $IGCExec;
		}
		catch(Exception $exec)
		{
			//$mySQLConnection->close();
			throw $exec;
		}
		$mySQLConnection->close();
	}
	
	/**
	 * 
	 * Approve user membership.Once the user registers to 
	 * IGC a link will be sent on his email id for registration 
	 * approval/confirmation. The link will include userId of the 
	 * newly created user in the query string.Once user clicks on 
	 * a link this function will be invoked. Only approved user can
	 * do a purchase of resource.
	 * 
	 * @param $userId
	 * @param $applicationId
	 * @return bool true indicates opertion is successful
	 *         false indicates failure.
	 */
	function activateMembership($userId,
								$applicationId)
	{
		$afftectedRows = 0;
		$mySQLConnection = 0;
		try 
		{
			$mySqlConnection = ConnectionFactory::getMySQLConnection();
			$afftectedRows = $mySqlConnection->executeNonQuery("Call cc_approveMembership(
																'$userId',
																'$applicationId'	
																)");
			if ($afftectedRows > 0)
			{
				$mySQLConnection->close();
				return true;
			}
			else
			{
				$mySQLConnection->close();
				return false;
			}
		}
		catch(Exception $exec)
		{
			$mySQLConnection->close();
			throw $exec;
		}
		$mySQLConnection->close();				
	}
	
	/**
	 * This function updates the user profile.
	 * Update is performed only for valid users.
	 * @param $objUserDetails
	 * @return count of affected rows. Throws appropriate exception
	 * in case of invalid user name or passowrd OR the user membership
	 * is not approved.
	 */
	public function updateUserProfile(UserDetails $objUserDetails)
	{
		$mySQLConnection = 0;
		$affectedRows = 0;
		$tempResult;
		try
		{
			$userId = 0;
			$applicationId = $objUserDetails->getApplicationId();
			$applicationId != 0 ? $applicationId: $applicationId = Configuration::APP_ID;
			 
			$result = $this->validateUser($objUserDetails->getEmail(),
                                               $objUserDetails->getPassword(),
                                               $applicationId); 

	        $userId = $result[0]['userId'];
	        //$email = (is_null($objUserDetails->getEmail())?"":$objUserDetails->getEmail());
	        //$password = (is_null($objUserDetails->getPassword()) ? " " : $objUserDetails->getPassword());
	        $firstName = (is_null($objUserDetails->getFirstName()) ? " " : $objUserDetails->getFirstName());
	        $lastName = (is_null($objUserDetails->getLastName()) ? " " : $objUserDetails->getLastName());
	        $city = (is_null($objUserDetails->getCity()) ? " " : $objUserDetails->getCity());
	        $country = (is_null($objUserDetails->getCountry()) ? " " : $objUserDetails->getCountry());
	        $zipCode = (is_null($objUserDetails->getZipCode()) ? " " : $objUserDetails->getZipCode());
	        $specialtyId = (is_null($objUserDetails->getSpecialtyId()) ? " " : $objUserDetails->getSpecialtyId());
	        $professionId = (is_null($objUserDetails->getProfessionId()) ? " " : $objUserDetails->getProfessionId());
            
			if($result[0]['userId'] > 0)
			{
				$mySQLConnection = ConnectionFactory::getMySQLConnection();
				$affectedRows = $mySQLConnection->executeNonQuery("CALL cc_updateUserProfile
												( '$applicationId',
		                                              '$userId',
		                                              '$firstName',
		                                              '$lastName',
		                                              '$country',
		                                              '$city',
		                                              '$zipCode',
		                                              '$specialtyId',
		                                              '$professionId'
												)");
				$mySQLConnection->close();
				$tempResult['affectedRows']= $affectedRows;
				return $tempResult;
			}
			else
			{
				/* Invalid User name or password */
				$mySQLConnection->close();
				throw new IGCAppExceptions(ErrorMessageCollection::getMessage(103),103);
			}
		}
		catch(IGCAppExceptions $IGCExec)
        {
        	//$mySQLConnection->close();
            throw $IGCExec;
        }
		catch(Exception $exec)
		{
			//$mySQLConnection->close();
			throw $exec;
		}
		$mySQLConnection->close();
		$tempResult['affectedRows']= $affectedRows;
		return $tempResult;
	}
	
	/**
	 * 
	 * This function updates the user password.
	 * Update is performed only for valid users.
	 * @param $applicationId
	 * @param $userName
	 * @param $password
	 * @param $newPassword
	 * @return count of affected rows. Throws appropriate exception
	 * in case of invalid user name or passowrd OR the user membership
	 * is not approved.
	 */
	public function changePassword($applicationId,
								$userName,
								$password,
								$newPassword)
	{
		$mySQLConnection = 0;
		$affectedRows = 0;
		$tempResult;
		$crypticPassword;
		try
		{
			$userId = 0;
			$applicationId != 0 ? $applicationId: $applicationId = Configuration::APP_ID;
				
			$result = $this->validateUser($userName,
	                                      $password,
	                                      $applicationId);
	        $userId = $result[0]['userId']; 
			if($result[0]['userId'] > 0)
			{
				$objCrypto = new CryptoClass();
				$crypticPassword = $objCrypto->encryptMd5($newPassword);	
				$mySQLConnection = ConnectionFactory::getMySQLConnection();
				$affectedRows = $mySQLConnection->executeNonQuery("CALL cc_updateUserPassword
												( 
	                                              '$userId',
	                                              '$applicationId',
	                                              '$crypticPassword'
												)");
				$mySQLConnection->close();
				$tempResult['affectedRows']= $affectedRows;
				return $tempResult;
			}
			else
			{
				//$mySQLConnection->close();
				throw new IGCAppExceptions(ErrorMessageCollection::getMessage(103),103);
			}
		}
		catch(IGCAppExceptions $IGCExec)
		{
			//$mySQLConnection->close();
			throw $IGCExec;
		}
		catch(Exception $exec)
		{
			//$mySQLConnection->close();
			throw $exec;
		}
		//$mySQLConnection->close();
		//$tempResult['affectedRows']= $affectedRows;
		//return $tempResult;
	}
}

?>