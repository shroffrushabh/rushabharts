<?php
/**
 * This class encapsulates note details.
 *
 * @author Ashutosh D
 * @date 19-05-2012
 * @copyright Mobiuso LLC
 */

class Note
{	
	private $_productId;
	private $_pageId;
	private $_deviceId;
	private $_noteText;
	private $_noteId;
	private $_userId;
	
	public function setUserId($userId)
	{
		$this->_userId = $userId;		
	}
	
	public function getUserId()
	{
		return $this->_userId;
	} 
	
	public function setProductId($productId)
	{
		$this->_productId = $productId;
	}	
	public function getProductId()
	{
		return $this->_productId;
	}

	public function setPageId($pageId)
	{
		$this->_pageId = $pageId;
	}	
	public function getPageId()
	{
		return $this->_pageId;
	}
	
	public function setDeviceId($deviceId)
	{
		$this->_deviceId = $deviceId;
	}	
	public function getDeviceId()
	{
		return $this->_deviceId;
	}
	
	public function setNoteText($noteText)
	{
		$this->_noteText = $noteText;
	}	
	public function getNoteText()
	{
		return $this->_noteText;
	}
	
	public function setNoteId($noteId)
	{
		$this->_noteId = $noteId;
	}	
	public function getNoteId()
	{
		return $this->_noteId;
	}
}
?>