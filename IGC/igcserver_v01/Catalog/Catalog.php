<?php
/**
 * This class encapsulates catalog details.
 *
 * @author Ashutosh D
 * @date 21-05-2012
 * @copyright Mobiuso LLC
 */
class Catalog {
    
    private $_lastSyncDate;
    
    public function getLastSyncDate()
    {
        return $this->_lastSyncDate;
    }
    public function setLastSyncDate($lastSyncDate)
    {
        $this->_lastSyncDate = $lastSyncDate;
    }
}

?>
