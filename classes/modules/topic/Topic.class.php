<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

/**
 * Добавляем в функционал в модуль "Topic"
 *
 */
class PluginTopicsoundche_ModuleTopic extends PluginTopicsoundche_Inherit_ModuleTopic {

	public function Init() {
		$this->aTopicTypes[] = 'soundche';
		parent::init();
	}
	
	/**
	 * Дополнительная обработка удаления топика
	 *
	 * @param ModuleTopic_EntityTopic|int $oTopicId
	 * @return bool
	 */
	public function DeleteTopic($oTopicId) {
		if ($oTopicId instanceof ModuleTopic_EntityTopic) {
			$oTopic=$oTopicId;
		} else {
			$oTopic=$this->GetTopicById($oTopicId);
		}

		if ($oTopic) {
			$this->PluginTopicsoundche_Topicsoundche_DeleteTopic($oTopic);
		}

		return parent::DeleteTopic($oTopicId);
	}

}
?>