<?php
/**
 * Конфиг
 */

$config = array();

// Переопределить имеющуюся переменную в конфиге:
// Переопределение роутера на наш новый Action - добавляем свой урл  http://domain.com/topicsoundche
// Config::Set('router.page.topicsoundche', 'PluginTopicsoundche_ActionTopicsoundche');
Config::Set('router.page.soundche', 'PluginTopicsoundche_ActionTopicsoundche');
// Добавить новую переменную:
// $config['per_page'] = 15;
// Эта переменная будет доступна в плагине как Config::Get('plugin.topicsoundche.per_page')
/**
 * Настройки
 */
$config['title_podcast']   = 'SOUNDЧе'; 

return $config;
