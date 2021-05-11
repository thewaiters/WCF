<?php

namespace wcf\data\object\type;

use wcf\data\DatabaseObjectList;

/**
 * Represents a list of object types.
 *
 * @author  Alexander Ebert
 * @copyright   2001-2019 WoltLab GmbH
 * @license GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package WoltLabSuite\Core\Data\Object\Type\Definition
 *
 * @method  ObjectType      current()
 * @method  ObjectType[]        getObjects()
 * @method  ObjectType|null     getSingleObject()
 * @method  ObjectType|null     seach($objectID)
 * @property    ObjectType[] $objects
 */
class ObjectTypeList extends DatabaseObjectList
{
    /**
     * @inheritDoc
     */
    public $className = ObjectType::class;
}
