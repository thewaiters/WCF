<?php
namespace wcf\data\search;
use wcf\data\DatabaseObjectEditor;

/**
 * Provides functions to edit searches.
 * 
 * @author	Alexander Ebert
 * @copyright	2001-2010 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.woltlab.wcf
 * @subpackage	data.search
 * @category 	Community Framework
 */
class SearchEditor extends DatabaseObjectEditor {
	/**
	 * @see	DatabaseObjectEditor::$baseClass
	 */
	protected static $baseClass = 'wcf\data\search\Search';
}
?>