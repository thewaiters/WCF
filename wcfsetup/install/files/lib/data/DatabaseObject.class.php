<?php
namespace wcf\data;
use wcf\system\WCF;

/**
 * Abstract class for all data holder classes.
 *
 * @author	Marcel Werk
 * @copyright	2001-2011 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.woltlab.wcf
 * @subpackage	data
 * @category 	Community Framework
 */
abstract class DatabaseObject implements StorableObject {
	/**
	 * database table for this object
	 * @var string
	 */
	protected static $databaseTableName = '';
	
	/**
	 * indicates if database table index is an identity column
	 * @var boolean 
	 */	
	protected static $databaseTableIndexIsIdentity = true;
	
	/**
	 * name of the primary index column
	 * @var string
	 */
	protected static $databaseTableIndexName = '';
	
	/**
	 * sort field
	 * @var mixed
	 */
	protected static $sortBy = null;
	
	/**
	 * sort order
	 * @var mixed
	 */
	protected static $sortOrder = null;
	
	/**
	 * object data
	 * @var array
	 */
	protected $data = null;
	
	/**
	 * Creates a new instance of the DatabaseObject class.
	 * Stores object data.
	 *  
	 * @param	mixed			$id
	 * @param	array			$row
	 * @param	DatabaseObject		$object
	 */
	public function __construct($id, array $row = null, DatabaseObject $object = null) {
		if ($id !== null) {
			$sql = "SELECT	*
				FROM	".static::getDatabaseTableName()."
				WHERE	".static::getDatabaseTableIndexName()." = ?";
			$statement = WCF::getDB()->prepareStatement($sql);
			$statement->execute(array($id));
			$row = $statement->fetchArray();
			
			// enforce data type 'array'
			if ($row === false) $row = array();
		}
		else if ($object !== null) {
			$row = $object->data;
		}
		
		$this->handleData($row);
	}
	
	/**
	 * Stores the data of a database row.
	 * 
	 * @param	array		$data
	 */
	protected function handleData($data) {
		// provide a logical false value for - assumed numeric - primary index
		if (!isset($data[static::getDatabaseTableIndexName()])) {
			$data[static::getDatabaseTableIndexName()] = 0;
		}
		
		$this->data = $data;
	}

	/**
	 * @see StorableObject::__get()
	 */
	public function __get($name) {
		if (isset($this->data[$name])) {
			return $this->data[$name];
		}
		else {
			return null;
		}
	}
	
	/**
	 * @see StorableObject::__isset()
	 */
	public function __isset($name) {
		return isset($this->data[$name]);
	}
	
	/**
	 * @see StorableObject::getDatabaseTableName()
	 */
	public static function getDatabaseTableName() {
		return 'wcf'.WCF_N.'_'.static::$databaseTableName;
	}
	
	/**
	 * @see	StorableObject::getDatabaseTableAlias()
	 */
	public static function getDatabaseTableAlias() {
		return static::$databaseTableName;
	}
	
	/**
	 * @see	StorableObject::getDatabaseTableIndexIsIdentity()
	 */	
	public static function getDatabaseTableIndexIsIdentity() {
		return static::$databaseTableIndexIsIdentity;
	}
	
	/**
	 * @see StorableObject::getDatabaseTableIndexName()
	 */
	public static function getDatabaseTableIndexName() {
		return static::$databaseTableIndexName;
	}
	
	/**
	 * Sorts a list of database objects.
	 *
	 * @param	array<DatabaseObject>	$objects
	 * @param	mixed			$sortBy
	 * @param	string			$sortOrder
	 * @return	boolean
	 */
	public static function sort(&$objects, $sortBy, $sortOrder = 'ASC') {
		static::$sortBy = (!is_array($sortBy) ? array($sortBy) : $sortBy);
		static::$sortOrder = (!is_array($sortOrder) ? array($sortOrder) : $sortOrder);
		return uasort($objects, array('static', 'compareObjects'));
	}
	
	/**
	 * Compares to database objects.
	 *
	 * @param	DatabaseObject		$objectA
	 * @param	DatabaseObject		$objectB
	 * @return	float
	 */
	protected static function compareObjects($objectA, $objectB) {
		foreach (static::$sortBy as $key => $sortBy) {
			$sortOrder = (isset(static::$sortOrder[$key]) ? static::$sortOrder[$key] : 'ASC');
			if (is_numeric($objectA->$sortBy) && is_numeric($objectB->$sortBy)) {
				if ($objectA->$sortBy > $objectB->$sortBy) {
					return ($sortOrder == 'ASC' ? 1 : 0);
				}
				else if ($objectA->$sortBy < $objectB->$sortBy) {
					return ($sortOrder == 'ASC' ? 0 : 1);
				}
			}
			else {
				if ($sortOrder == 'ASC') {
					$result =  strcoll($objectA->$sortBy, $objectB->$sortBy);
				}
				else {
					$result = strcoll($objectB->$sortBy, $objectA->$sortBy);
				}
				
				if ($result != 0.0) {
					return $result;
				}
			}
		}
		
		return 0;
	}
}
?>