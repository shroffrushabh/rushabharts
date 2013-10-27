<?php
/*
 * @author : Sachin R K
 * @date :30-04-2012
 * @copyright: Mobiuso LLC
 */

/*
 *  This class encapsulates Catalog details.
 */
class CatalogDetails
{
	private $_productId;
	private $_authoringOrganization;
	private $_title;	
	private $_isbn;
	private $_publishedDate;
	private $_endorsedBy;
	private $_abstract;
	private $_shortDescription;
	private $_size;
	private $_type;
	private $_nameID;
	private $_packageName;
	
	/**
	 * 
	 * Constructor
	 * @param $applicationId - Id the Application
	 * @param $username - email id of the User
	 */
	public function __construct()
	{		
		
	}
	
	public function getProductId()
	{
		return $this->_productId;
	}		
		
	public function setProductId($productId)
	{
		$this->_productId = $productId;
	} 
	/**
	 * 
	 * Encrypted password for that user.
	 */
	public function getAuthoringOrganization()
	{
		return $this->_authoringOrganization;
	}
	
	public function setAuthoringOrganization($authoringOrganization)
	{
		$this->_authoringOrganization = $authoringOrganization;
	} 
	
	public function getTitle()
	{
		return $this->_title;
	}

	public function setTitle($title)
	{
		$this->_title = $title;
	}
	
	public function getisbn()
	{
		return $this->_isbn;
	}

	public function setisbn($isbn)
	{
		$this->_isbn = $isbn;
	}
	
	public function getPublishedDate()
	{
		return $this->_publishedDate;
	}

	public function setPublishedDate($publishedDate) 
	{
		$this->_publishedDate = $publishedDate;
	}
	
	public function getEndorsedBy()
	{
		return $this->_endorsedBy;
	}
	
	public function setEndorsedBy($endorsedBy)
	{
		$this->_endorsedBy = $endorsedBy;
	}
	
	public function getAbstract()
	{
		return $this->_abstract;
	}
	
	public function setAbstract($abstract)
	{
		$this->_abstract = $abstract;
	}

	public function getShortDescription()
	{
		return $this->_shortDescription;
	}
	
	public function setShortDescription($shortDescription)
	{
		$this->_shortDescription = $shortDescription;
	}
	
	public function getSize()
	{
		return $this->_size;
	}
	
	public function setSize($size)
	{
		return $this->_size = $size;
	}
		
	public function getType()
	{
		return $this->_type;
	}
	
	public function setType($type)
	{
		return $this->_type = $type;
	}
	
	public function getNameID()
	{
		return $this->_nameID;
	}
	
	public function setNameID($nameID)
	{
		$this->_nameID = $nameID; 
	}
	
	public function getpackageName()
	{
		return $this->_packageName;
	}
	
	public function setpackageName($packageName)
	{
		return $this->_packageName = $packageName; 
	}
	
}
?>
