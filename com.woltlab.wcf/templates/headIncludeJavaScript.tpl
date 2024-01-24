{*
	DO NOT EDIT THIS FILE
*}

<script>
	var WCF_PATH = '{@$__wcf->getPath()}';
	var WSC_API_URL = '{@$__wcf->getPath()}';
	{* The SECURITY_TOKEN is defined in wcf.globalHelper.js *}
	var LANGUAGE_ID = {@$__wcf->getLanguage()->languageID};
	var LANGUAGE_USE_INFORMAL_VARIANT = {if LANGUAGE_USE_INFORMAL_VARIANT}true{else}false{/if};
	var TIME_NOW = {@TIME_NOW};
	var LAST_UPDATE_TIME = {@LAST_UPDATE_TIME};
	var ENABLE_DEBUG_MODE = {if ENABLE_DEBUG_MODE}true{else}false{/if};
	var ENABLE_PRODUCTION_DEBUG_MODE = {if ENABLE_PRODUCTION_DEBUG_MODE}true{else}false{/if};
	var ENABLE_DEVELOPER_TOOLS = {if ENABLE_DEVELOPER_TOOLS}true{else}false{/if};
	var PAGE_TITLE = '{PAGE_TITLE|phrase|encodeJS}';
	
	var REACTION_TYPES = {@$__wcf->getReactionHandler()->getReactionsJSVariable()};
	
	{if ENABLE_DEBUG_MODE}
		{* This constant is a compiler option, it does not exist in production. *}
		var COMPILER_TARGET_DEFAULT = {if !VISITOR_USE_TINY_BUILD || $__wcf->user->userID}true{else}false{/if};
	{/if}

	{if $__wcf->getStyleHandler()->getColorScheme() === 'system'}
	{
		const colorScheme = matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
		document.documentElement.dataset.colorScheme = colorScheme;
	}
	{/if}
</script>

<script src="{$__wcf->getPath()}js/WoltLabSuite/WebComponent.min.js?v={@LAST_UPDATE_TIME}"></script>
<script src="{$phrasePreloader->getUrl($__wcf->language)}"></script>

{js application='wcf' file='require' bundle='WoltLabSuite.Core' core='true' hasTiny=true}
{js application='wcf' file='require.config' bundle='WoltLabSuite.Core' core='true' hasTiny=true}
{js application='wcf' file='require.linearExecution' bundle='WoltLabSuite.Core' core='true' hasTiny=true}
{js application='wcf' file='wcf.globalHelper' bundle='WoltLabSuite.Core' core='true' hasTiny=true}
{js application='wcf' file='3rdParty/tslib' bundle='WoltLabSuite.Core' core='true' hasTiny=true}
<script>
requirejs.config({
	baseUrl: '{@$__wcf->getPath()}js',
	urlArgs: 't={@LAST_UPDATE_TIME}'
	{hascontent}
	, paths: {
		{content}{event name='requirePaths'}{/content}
	}
	{/hascontent}
});
{* Safari ignores the HTTP cache headers for the back/forward navigation. *}
window.addEventListener('pageshow', function(event) {
	if (event.persisted) {
		window.location.reload();
	}
});
{event name='requireConfig'}
</script>
<script data-relocate="true">
	require(['Language', 'WoltLabSuite/Core/BootstrapFrontend', 'User'], function(Language, BootstrapFrontend, User) {
		{hascontent}
			Language.addObject({
				{content}{event name='javascriptLanguageImport'}{/content}
			});
		{/hascontent}
		
		User.init(
			{@$__wcf->user->userID},
			{if $__wcf->user->userID}'{@$__wcf->user->username|encodeJS}'{else}''{/if},
			{if $__wcf->user->userID}'{@$__wcf->user->getLink()|encodeJS}'{else}''{/if}
		);
		
		BootstrapFrontend.setup({
			backgroundQueue: {
				url: '{link controller="BackgroundQueuePerform"}{/link}',
				force: {if $forceBackgroundQueuePerform|isset}true{else}false{/if}
			},
			dynamicColorScheme: {if $__wcf->getStyleHandler()->getColorScheme() === 'system'}true{else}false{/if},
			endpointUserPopover: {if $__wcf->getSession()->getPermission('user.profile.canViewUserProfile')}'{link controller='UserPopover'}{/link}'{else}''{/if},
			executeCronjobs: {if $executeCronjobs}'{link controller="CronjobPerform"}{/link}'{else}undefined{/if},
			{if ENABLE_SHARE_BUTTONS}
				{assign var='__shareProviders' value="\n"|explode:SHARE_BUTTONS_PROVIDERS}
				shareButtonProviders: [
					{if 'Facebook'|in_array:$__shareProviders}["Facebook", "{jslang}wcf.message.share.facebook{/jslang}", {icon size=24 name='facebook' type='brand' encodeJson=true}],{/if} 
					{if 'Twitter'|in_array:$__shareProviders}["Twitter", "{jslang}wcf.message.share.twitter{/jslang}", {icon size=24 name='x-twitter' type='brand' encodeJson=true}],{/if} 
					{if 'Reddit'|in_array:$__shareProviders}["Reddit", "{jslang}wcf.message.share.reddit{/jslang}", {icon size=24 name='reddit' type='brand' encodeJson=true}],{/if} 
					{if 'WhatsApp'|in_array:$__shareProviders}["WhatsApp", "{jslang}wcf.message.share.whatsApp{/jslang}", {icon size=24 name='whatsapp' type='brand' encodeJson=true}],{/if} 
					{if 'LinkedIn'|in_array:$__shareProviders}["LinkedIn", "{jslang}wcf.message.share.linkedIn{/jslang}", {icon size=24 name='linkedin-in' type='brand' encodeJson=true}],{/if} 
					{if 'Pinterest'|in_array:$__shareProviders}["Pinterest", "{jslang}wcf.message.share.pinterest{/jslang}", {icon size=24 name='pinterest' type='brand' encodeJson=true}],{/if} 
					{if 'XING'|in_array:$__shareProviders}["XING", "{jslang}wcf.message.share.xing{/jslang}", {icon size=24 name='xing' type='brand' encodeJson=true}],{/if} 
					{event name='javascriptShareButtonProviders'}
				],
			{/if}
			styleChanger: {if $__wcf->getStyleHandler()->showStyleChanger()}true{else}false{/if}
		});
	});
</script>

{include file='__devtoolsLanguageChooser'}

{if ENABLE_DEBUG_MODE && ENABLE_DEVELOPER_TOOLS}
<script data-relocate="true">
	require(["WoltLabSuite/Core/Devtools/Style/LiveReload"], (LiveReload) => LiveReload.watch());
</script>
{/if}

<script data-relocate="true">
	// prevent jQuery and other libraries from utilizing define()
	__require_define_amd = define.amd;
	define.amd = undefined;
</script>
{js application='wcf' lib='jquery' hasTiny=true}
{js application='wcf' lib='jquery-ui' hasTiny=true}
{js application='wcf' lib='jquery-ui' file='touchPunch' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' lib='jquery-ui' file='nestedSortable' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.Assets' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF' bundle='WCF.Combined' hasTiny=true}
<script data-relocate="true">
	define.amd = __require_define_amd;
	$.holdReady(true);
</script>

<script data-relocate="true">
	WCF.User.init(
		{@$__wcf->user->userID},
		{if $__wcf->user->userID}'{@$__wcf->user->username|encodeJS}'{else}''{/if}
	);
</script>

{js application='wcf' file='WCF.ACL' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.Attachment' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.ColorPicker' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.ImageViewer' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.Label' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.Location' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.Message' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.User' bundle='WCF.Combined' hasTiny=true}
{js application='wcf' file='WCF.Moderation' bundle='WCF.Combined' hasTiny=true}

{event name='javascriptInclude'}

<noscript>
	<style>
		.jsOnly {
			display: none !important;
		}
		
		.noJsOnly {
			display: block !important;
		}
	</style>
</noscript>

<script data-relocate="true">
	$(function() {
		WCF.User.Profile.ActivityPointList.init();
		
		{if MODULE_TROPHY && $__wcf->session->getPermission('user.profile.trophy.canSeeTrophies')}
			require(['WoltLabSuite/Core/Ui/User/Trophy/List'], function (UserTrophyList) {
				new UserTrophyList();
			});
		{/if}
		
		{event name='javascriptInit'}
		
		{if ENABLE_POLLING && $__wcf->user->userID}
			require(['WoltLabSuite/Core/Notification/Handler'], function(NotificationHandler) {
				NotificationHandler.setup({
					icon: '{$__wcf->getStyleHandler()->getStyle()->getFaviconAppleTouchIcon()}',
				});
			});
		{/if}
	});
</script>

{include file='imageViewer'}
{include file='headIncludeJsonLd'}
