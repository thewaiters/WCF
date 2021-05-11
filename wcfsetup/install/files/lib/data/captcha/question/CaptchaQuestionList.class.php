<?php

namespace wcf\data\captcha\question;

use wcf\data\DatabaseObjectList;

/**
 * Represents a list of captcha questions.
 *
 * @author  Matthias Schmidt
 * @copyright   2001-2019 WoltLab GmbH
 * @license GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package WoltLabSuite\Core\Data\Captcha\Question
 *
 * @method  CaptchaQuestion     current()
 * @method  CaptchaQuestion[]   getObjects()
 * @method  CaptchaQuestion|null    getSingleObject()
 * @method  CaptchaQuestion|null    seach($objectID)
 * @property    CaptchaQuestion[] $objects
 */
class CaptchaQuestionList extends DatabaseObjectList
{
}
