<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=9" />
	<meta name="keywords" content="{$page->meta_keywords}{if $page->meta_keywords != "" && $site->metakeywords != ""},{/if}{$site->metakeywords}" />
	<meta name="description" content="{$page->meta_description}{if $page->meta_description != "" && $site->metadescription != ""} - {/if}{$site->metadescription}" />	
	<meta name="robots" content="noindex,nofollow"/>
	<meta name="application-name" content="newznab-{$site->version}" />
	<title>{$page->meta_title}{if $page->meta_title != "" && $site->metatitle != ""} - {/if}{$site->metatitle}</title>
{if $loggedin=="true"}	<link rel="alternate" type="application/rss+xml" title="{$site->title} Full Rss Feed" href="{$smarty.const.WWW_TOP}/rss?t=0&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}" />{/if}

{*	<link href="{$smarty.const.WWW_TOP}/views/styles/style.css" rel="stylesheet" type="text/css" media="screen" />	*}
	<link href="{$smarty.const.WWW_TOP}/views/styles/jquery.qtip.css" rel="stylesheet" type="text/css" media="screen" />

{if $site->google_adsense_acc != ''}	<link href="http://www.google.com/cse/api/branding.css" rel="stylesheet" type="text/css" media="screen" />{/if}
{if $site->style != "" && $site->style != "/"}	<link href="{$smarty.const.WWW_TOP}/views/themes/{$site->style}/style.css" rel="stylesheet" type="text/css" media="screen" />{/if}

	<!-- FAVICON -->
	<link rel="shortcut icon" type="image/ico" href="{$smarty.const.WWW_TOP}/views/images/favicon.ico"/>
	<link rel="search" type="application/opensearchdescription+xml" href="{$smarty.const.WWW_TOP}/opensearch" title="{$site->title|escape}" />
	
	<!-- Javascripts -->
	<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script type="text/javascript" src="{$smarty.const.WWW_TOP}/views/scripts/jquery.colorbox-min.js"></script>
	<script type="text/javascript" src="{$smarty.const.WWW_TOP}/views/scripts/jquery.qtip2.js"></script>
	<script type="text/javascript" src="{$smarty.const.WWW_TOP}/views/scripts/utils.js"></script>
	<script type="text/javascript" src="{$smarty.const.WWW_TOP}/views/scripts/sorttable.js"></script>

	<!-- Added the Bootstrap JS -->
	<script type="text/javascript" src="{$smarty.const.WWW_TOP}/views/scripts/bootstrap.min.js"></script>

	<script type="text/javascript">
	/* <![CDATA[ */	
		var WWW_TOP = "{$smarty.const.WWW_TOP}";
		var SERVERROOT = "{$serverroot}";
		var UID = "{if $loggedin=="true"}{$userdata.ID}{else}{/if}";
		var RSSTOKEN = "{if $loggedin=="true"}{$userdata.rsstoken}{else}{/if}";
	/* ]]> */		
	</script>
	{$page->head}
</head>
<body {$page->body}>

<!-- NAV
	================================================== -->

	<div class="navbar navbar-inverted navbar-fixed-top">
		<div class="navbar-inner" style="padding-left:30px; padding-right:30px;">
			<div class="container">
				<a class="brand" href="{$smarty.const.WWW_TOP}{$site->home_link}">{$site->title}</a>				
						{if $loggedin=="true"}
							{$header_menu}
						{/if}
					{if $loggedin=="true"}
						<ul class="nav pull-right">
							<li class="dropdown">
								<a id="dropUser" class="dropdown-toggle" data-toggle="dropdown" href="#">{$userdata.username} <b class="caret"></b></a>
								<ul class="dropdown-menu" role="menu" aria-labelledby="dropUser">
									<li class="">
										<a href="{$smarty.const.WWW_TOP}/profile">Profil</a>
									</li>
									<li class="divider"></li>
									<li class="">
										<a href="{$smarty.const.WWW_TOP}/logout">Logout</a>
									</li>
								</ul>
							</li>
						</ul>
					{/if}
			</div>
		</div>
	</div>
	</br>
	</br>
	</br>

	<!-- Container
		================================================== -->
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span2">
					<ul class="nav nav-list affix">
					{$main_menu}

					{$article_menu}

					{$useful_menu}

					{$recentposts_menu}

					</ul>
				</div>

				<div class="span10">
					{$page->content}
				</div>


			</div>
		</div>
		<footer class="footer">
			<div class="container">
				<p>{$site->footer}</p>
				<p>All rights reserved {$smarty.now|date_format:"%Y"}</p>
				<ul class="footer-links">
					<li><a href="http://getbootstrap.com">themed with Bootstrap</a></li>
					<li class="muted">·</li>
					<li><a href="{$smarty.const.WWW_TOP}/terms-and-conditions">{$site->title} terms and conditions</a></li>
					<li class="muted">·</li>
					<li><a href="https://newznab.com">Built with newznab</a></li>
				</ul>
			</div>
		</footer>

			{if $loggedin=="true"}
				<input type="hidden" name="UID" value="{$userdata.ID}" />
				<input type="hidden" name="RSSTOKEN" value="{$userdata.rsstoken}" />
			{/if}
	
	
	
	
</body>
</html>
