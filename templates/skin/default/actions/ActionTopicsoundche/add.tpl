{if $sEvent=='add'}
	{include file='header.tpl' menu_content='create'}
{else}
	{include file='header.tpl'}
	<h2 class="page-header">{$aLang.topic_topic_edit}</h2>
{/if}


{include file='editor.tpl'}


<script type="text/javascript">
	jQuery(function($){
		if (jQuery.browser.flash) {
			ls.photoset.initSwfUpload({
				post_params: { 'topic_id': {json var=$_aRequest.topic_id} }
			});
		}
	});
</script>


<form id="photoset-upload-form" method="POST" enctype="multipart/form-data" onsubmit="return false;" class="modal modal-image-upload">
	<header class="modal-header">
		<h3>{$aLang.uploadimg}</h3>
		<a href="#" class="close jqmClose"></a>
	</header>
	
	<div id="topic-photo-upload-input" class="topic-photo-upload-input modal-content">
		<label for="photoset-upload-file">{$aLang.topic_photoset_choose_image}:</label>
		<input type="file" id="photoset-upload-file" name="Filedata" /><br><br>

		<button type="submit" class="button button-primary" onclick="ls.photoset.upload();">{$aLang.topic_photoset_upload_choose}</button>
		<button type="submit" class="button" onclick="ls.photoset.closeForm();">{$aLang.topic_photoset_upload_close}</button>
		
		<input type="hidden" name="is_iframe" value="true" />
		<input type="hidden" name="topic_id" value="{$_aRequest.topic_id}" />
	</div>
</form>


{hook run='add_topic_topic_begin'}


<form action="" method="POST" enctype="multipart/form-data" id="form-topic-add" class="wrapper-content">
	{hook run='form_add_topic_topic_begin'}

	
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />
	<input type="hidden" name="title_podcast" id="title_podcast" value="" />
	<p><label for="blog_id">{$aLang.topic_create_blog}</label>
	<select name="blog_id" id="blog_id" onChange="ls.blog.loadInfo(jQuery(this).val()); $('#topic_title').val($('#blog_id :selected').html()+' {$aLang.plugin.topicsoundche.guest_podcast} {$title_podcast}')" class="input-width-full">
		<option value="0">{$aLang.topic_create_blog_personal}</option>
		{foreach from=$aBlogsAllow item=oBlog}
			<option value="{$oBlog->getId()}" {if $_aRequest.blog_id==$oBlog->getId()}selected{/if}>{$oBlog->getTitle()|escape:'html'}</option>
		{/foreach}
	</select>
	<small class="note">{$aLang.topic_create_blog_notice}</small></p>


	
	<script type="text/javascript">
		jQuery(document).ready(function($){
			ls.blog.loadInfo($('#blog_id').val());
		});
    </script>
	
	
	<p><label for="topic_title">{$aLang.topic_create_title}:</label>
	<input type="text" id="topic_title" name="topic_title" value="{$_aRequest.topic_title}" class="input-text input-width-full" />
	<small class="note">{$aLang.topic_create_title_notice}</small></p>
	
	<p><label for="topic_audio">{$aLang.plugin.topicsoundche.topic_create_audio}:</label>
	<input type="file" name="topic_audio" />
	{if isset($_aRequest.topic_audio_hidden) and $_aRequest.topic_audio_hidden != ''}
	<input type="hidden" name="topic_audio_hidden" value="{$_aRequest.topic_audio_hidden}">
	{/if}
	<small class="note">{$aLang.plugin.topicsoundche.topic_create_audio_notice}</small></p>
	
	<label for="topic_text">{$aLang.topic_create_text}:</label>
	<textarea name="topic_text" id="topic_text" class="mce-editor markitup-editor input-width-full" rows="20">{$_aRequest.topic_text}</textarea>
	
	<label for="topic_sponsor">{$aLang.plugin.topicsoundche.topic_create_sponsor}:</label>
	<textarea name="topic_sponsor" id="topic_sponsor" class="mce-editor markitup-editor input-width-full" rows="5" style="height: 80px">{if isset($_aRequest.topic_sponsor) }{$_aRequest.topic_sponsor}{else}{$aLang.plugin.topicsoundche.topic_sponsor}{/if}</textarea>
	
	<label for="topic_audio_text_version">{$aLang.plugin.topicsoundche.topic_audio_text_version}:</label>
	<textarea name="topic_audio_text_version" id="topic_audio_text_version" class="mce-editor markitup-editor input-width-full" rows="15" style="height: 180px">{if isset($_aRequest.topic_audio_text_version) }{$_aRequest.topic_audio_text_version}{/if}</textarea>
	
	<div class="topic-photo-upload">
		<h2>{$aLang.topic_photoset_upload_title}</h2>
		
		<div class="topic-photo-upload-rules">
			{$aLang.topic_photoset_upload_rules|ls_lang:"SIZE%%`$oConfig->get('module.topic.photoset.photo_max_size')`":"COUNT%%`$oConfig->get('module.topic.photoset.count_photos_max')`"}
		</div>
		
		<input type="hidden" name="topic_main_photo" id="topic_main_photo" value="{$_aRequest.topic_main_photo}" />
		
		<ul id="swfu_images">
			{if count($aPhotos)}
				{foreach from=$aPhotos item=oPhoto}
					{if $_aRequest.topic_main_photo && $_aRequest.topic_main_photo == $oPhoto->getId()}
						{assign var=bIsMainPhoto value=true}
					{/if}
					
					<li id="photo_{$oPhoto->getId()}" {if $bIsMainPhoto}class="marked-as-preview"{/if}>
						<img src="{$oPhoto->getWebPath('100crop')}" alt="image" />
						<textarea onBlur="ls.photoset.setPreviewDescription({$oPhoto->getId()}, this.value)">{$oPhoto->getDescription()}</textarea><br />
						<a href="javascript:ls.photoset.deletePhoto({$oPhoto->getId()})" class="image-delete">{$aLang.topic_photoset_photo_delete}</a>
						<span id="photo_preview_state_{$oPhoto->getId()}" class="photo-preview-state">
							{if $bIsMainPhoto}
								{$aLang.topic_photoset_is_preview}
							{else}
								<a href="javascript:ls.photoset.setPreview({$oPhoto->getId()})" class="mark-as-preview">{$aLang.topic_photoset_mark_as_preview}</a>
							{/if}
						</span>
					</li>
					
					{assign var=bIsMainPhoto value=false}
				{/foreach}
			{/if}
		</ul>
		
		<a href="javascript:ls.photoset.showForm()" id="photoset-start-upload">{$aLang.topic_photoset_upload_choose}</a>
	</div>
	
	{if !$oConfig->GetValue('view.tinymce')}
		{include file='tags_help.tpl' sTagsTargetId="topic_text"}
		<br />
		<br />
	{/if}
	
	<p><label for="topic_tags">{$aLang.topic_create_tags}:</label>
	<input type="text" id="topic_tags" name="topic_tags" value="{$_aRequest.topic_tags}" class="input-text input-width-full autocomplete-tags-sep" />
	<small class="note">{$aLang.topic_create_tags_notice}</small></p>

	
	<p><label><input type="checkbox" id="topic_forbid_comment" name="topic_forbid_comment" class="input-checkbox" value="1" {if $_aRequest.topic_forbid_comment==1}checked{/if} />
	{$aLang.topic_create_forbid_comment}</label>
	<small class="note">{$aLang.topic_create_forbid_comment_notice}</small></p>

	
	{if $oUserCurrent->isAdministrator()}
		<p><label><input type="checkbox" id="topic_publish_index" name="topic_publish_index" class="input-checkbox" value="1" {if $_aRequest.topic_publish_index==1}checked{/if} />
		{$aLang.topic_create_publish_index}</label>
		<small class="note">{$aLang.topic_create_publish_index_notice}</small></p>
	{/if}

	<input type="hidden" name="topic_type" value="topic" />
	
	{hook run='form_add_topic_topic_end'}
	
	
	<button type="submit"  name="submit_topic_publish" id="submit_topic_publish" class="button button-primary fl-r">{$aLang.topic_create_submit_publish}</button>
	<button type="submit"  name="submit_preview" onclick="ls.topic.preview('form-topic-add','text_preview'); return false;" class="button">{$aLang.topic_create_submit_preview}</button>
	<button type="submit"  name="submit_topic_save" id="submit_topic_save" class="button">{$aLang.topic_create_submit_save}</button>
</form>

	
<div class="topic-preview" style="display: none;" id="text_preview"></div>


{hook run='add_topic_topic_end'}


{include file='footer.tpl'}