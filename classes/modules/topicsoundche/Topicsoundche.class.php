<?php

class PluginTopicsoundche_ModuleTopicsoundche extends Module {
	protected $oMapper;

	public function Init() {
		$this->oMapper=Engine::GetMapper(__CLASS__);
	}
	
	public function UploadAudioBySubmit($oTopic,$aFile) {
    	if(!is_array($aFile) || !isset($aFile['tmp_name'])) {
			return false;
		}

		/**
		 * Сохраняем во временный файл
		 */
		$sFileTmp=Config::Get('sys.cache.dir').func_generator();
    	if (!move_uploaded_file($aFile['tmp_name'],$sFileTmp)) {
			return false;
		}
		return $this->UploadAudio($oTopic,$sFileTmp);
    }
	
    /**
     * return path to uploaded image
     * Enter description here ...
     * @param unknown_type $oTopic
     * @param unknown_type $sFileTmp
     */
    protected function UploadAudio($oTopic,$sFileTmp) {
    	/**
		 * Генерируем имя файла и каталога
		 */
		$sDirSave = Config::Get('path.uploads.root').'/podcast/preview/'.preg_replace('~(.{2})~U', "\\1/", str_pad($oTopic->getId(), 8, "0", STR_PAD_LEFT));
		$topic_date_add = explode(' ',$oTopic->_getDataOne('topic_date_add')); 
		$sFileName=$sDirSave.$topic_date_add['0'].'.mp3';
		$sDirSave=rtrim($sDirSave,'/');
		
		//полный серверный путь к папке для хранения подкаста
		$sFileDestFullPath=rtrim(Config::Get('path.root.server'),"/").'/'.trim($sFileName,"/");
		
		//создаем папку для хранения файла подкаста
		$this->Image_CreateDirectory($sDirSave);
		
		//Перемещаем файл на постоянное место жительства
		rename($sFileTmp, $sFileDestFullPath);
		
		return $this->Image_GetWebPath($sFileName);
		
		
		
    }
    
	public function DeleteTopic($oTopic) {
		
	}
	

}
?>
