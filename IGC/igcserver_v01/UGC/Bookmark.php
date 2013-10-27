<?php
/**
 * This class encapsulates bookmark details.
 * @author : Ashutosh D
 * @date :19-05-2012
 * @copyright: Mobiuso LLC
 */
class Bookmark
{
	private $_productId;
	private $_userId;
	private $_pageId;
	private $_fileName;
	private $_description;
	private $_deviceId;
	
	public function setProductId($productId)
	{
		$this->_productId = $productId;
	}	
	public function getProductId()
	{
		return $this->_productId;
	}

	public function setUserId($userId)
	{
		$this->_userId = $userId;
	} 	
	public function getUserId()
	{
		return $this->userId;
	}
	
	public function setPageId($pageId)
	{
		$this->_pageId = $pageId;
	}	
	public function getPageId()
	{
		return $this->_pageId;
	}

	public function setFileName($fileName)
	{
		$this->_fileName = $fileName;
	}	
	public function getFileName()
	{
		return $this->_fileName;
	}

	public function setDescription($description)
	{
		$this->_description = $description;
	}	
	public function getDescription()
	{
		return $this->_description;
	}

	public function setDeviceId($deviceId)
	{
		$this->_deviceId = $deviceId;
	}	
	public function getDeviceId()
	{
		return $this->_deviceId;
	}
	
}?>