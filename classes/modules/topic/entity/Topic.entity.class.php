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
 * Добавление новых полей в топик
 * Поля хранятся в специальном поле extra в виде сериализованного массива
 */
class PluginTopicsoundche_ModuleTopic_EntityTopic extends PluginTopicsoundche_Inherit_ModuleTopic_EntityTopic {

	public function getAudio() {
		return $this->getExtraValue('audio');
	}

	public function getSponsors() {
		return $this->getExtraValue('sponsors');
	}
	
	public function getTextversion() {
		return $this->getExtraValue('textversion');
	}
	
	public function getTextversionSource() {
		return $this->getExtraValue('textversionsource');
	}

	public function setAudio($data) {
		$this->setExtraValue('audio',$data);
	}

	public function setSponsors($data) {
		$this->setExtraValue('sponsors',$data);
	}
	
	public function setTextversion($data) {
		$this->setExtraValue('textversion',$data);
	}
	
	public function setTextversionSource($data) {
		$this->setExtraValue('textversionsource',$data);
	}

}
?>