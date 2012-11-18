{include file='topic_part_header.tpl'}
   
   
<div class="topic-content text">
	{hook run='topic_content_begin' topic=$oTopic bTopicList=$bTopicList}
	
	<img src="{$oTopic->getPreviewImageWebPath('100crop')}" align="left" />{if $bTopicList}
		{$oTopic->getTextShort()}
		
		{if $oTopic->getTextShort()!=$oTopic->getText()}
			<br/>
			<a href="{$oTopic->getUrl()}#cut" title="{$aLang.topic_read_more}">
				{if $oTopic->getCutText()}
					{$oTopic->getCutText()}
				{else}
					{$aLang.topic_read_more} &rarr;
				{/if}
			</a>
		{/if}
	{else}
		{$oTopic->getText()}
			<div class="sponsors">
			<h3>{$aLang.plugin.topicsoundche.our_sponsors}</h3>
			{$oTopic->getSponsors()}
			</div>
		

{assign var=iPhotosCount value=$oTopic->getPhotosetCount()}
{if !$bTopicList}
	<script type="text/javascript" src="{cfg name='path.root.engine_lib'}/external/prettyPhoto/js/prettyPhoto.js"></script>	
	<link rel='stylesheet' type='text/css' href="{cfg name='path.root.engine_lib'}/external/prettyPhoto/css/prettyPhoto.css" />
	<script type="text/javascript">
		jQuery(document).ready(function($) {	
			$('.photoset-image').prettyPhoto({
				social_tools:'',
				show_title: false,
				slideshow:false,
				deeplinking: false
			});
		});
	</script>
	
	
	<div class="topic-photo-images">
		<h2>{$oTopic->getPhotosetCount()} {$oTopic->getPhotosetCount()|declension:$aLang.topic_photoset_count_images}</h2>
		<a name="photoset"></a>
		
		<ul id="topic-photo-images">
			{assign var=aPhotos value=$oTopic->getPhotosetPhotos(0, $oConfig->get('module.topic.photoset.per_page'))}
			{if count($aPhotos)}                                
				{foreach from=$aPhotos item=oPhoto}
					<li><a class="photoset-image" href="{$oPhoto->getWebPath(1000)}" rel="[photoset]"  title="{$oPhoto->getDescription()}"><img src="{$oPhoto->getWebPath('50crop')}" alt="{$oPhoto->getDescription()}" /></a></li>                                    
					{assign var=iLastPhotoId value=$oPhoto->getId()}
				{/foreach}
			{/if}
			<script type="text/javascript">
				ls.photoset.idLast='{$iLastPhotoId}';
			</script>
		</ul>
		
		{if count($aPhotos)<$oTopic->getPhotosetCount()}
			<a href="javascript:ls.photoset.getMore({$oTopic->getId()})" id="topic-photo-more" class="topic-photo-more">{$aLang.topic_photoset_show_more} &darr;</a>
		{/if}
	</div>
	<object id="audioplayer344" type="application/x-shockwave-flash" data="http://soundche.ck.ua/plugins/topicsoundche/templates/skin/default/css/uppod.swf" width="639" height="25"><param name="bgcolor" value="#ffffff" /><param name="allowScriptAccess" value="always" /><param name="movie" value="http://soundche.ck.ua/plugins/topicsoundche/templates/skin/default/css/uppod.swf" /><param name="flashvars" value="comment={$oTopic->getTitle()}&amp;st=http://soundche.ck.ua/plugins/topicsoundche/templates/skin/default/css/audio140-305.txt&amp;file={$oConfig->GetValue('path.root.web')}{$oTopic->getAudio()}" /></object>
	<a href="{$oConfig->GetValue('path.root.web')}{$oTopic->getAudio()}" title="{$aLang.plugin.topicsoundche.how_to_download_audio}">{$aLang.plugin.topicsoundche.download_audio_podcast}</a>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			$('#click_to_see_textversion').click(function() {
				$(this).next('.textversion').toggle();
				return false;
			}).next().hide();
		});
	</script>
	<div>
		<a id="click_to_see_textversion" href="javascript:void(0)">{$aLang.plugin.topicsoundche.textversion}</a>
		<div  class="textversion">
			{$oTopic->getTextversion()}
		</div>
	</div>
{/if}
		
	{/if}
	
	{hook run='topic_content_end' topic=$oTopic bTopicList=$bTopicList}
</div> 


{include file='topic_part_footer.tpl'}
