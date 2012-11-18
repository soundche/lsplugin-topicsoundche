{include file='header.tpl'}

<form action="" method="POST">
	
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />
	<label for="topic_name">{$aLang.plugin.topicsoundche.topic_name_notice}</label>
	<input type="text" name="topic_name" id="topic_name" value="{$config['myvar']}" /><br />
	{$aLang.plugin.topicsoundche.submit_notice}<br />
	<input type="submit" name="submit_config" value="{$aLang.plugin.topicsoundche.submit_admin}">
</form>

{include file='footer.tpl'}