<div class="page-header">
	<h1>{$page->title}</h1>
</div>

{if $serieslist}

<div class="navbar">
	<div class="navbar-inner">
		<form method="get" class="navbar-form pull-left" name="thetvdbsearch" action="">
			<div class="input-append">
				<input class="input input-xlagre" id="seriesname" type="text" name="seriesname" value="{$seriesname}" placeholder="Title" />
				<input class="btn btn-success" type="submit" value="Search" />
			</div>
		</form>
	</div>
</div>

{$pager}

<br/><br/>

<table class="data Sortable highlight table table-striped">

	<tr>
		<th style="width:90px;">TheTVDB ID</th>
		<th>Title</th>
		<th style="width:120px;" class="right">Options</th>
	</tr>

	{foreach from=$serieslist item=thetvdb}
	<tr class="{cycle values=",alt"}">
		<td class="less"><a href="{$site->dereferrer_link}http://thetvdb.com/?tab=series&id={$thetvdb.tvdbID}" title="View in TheTVDB">{$thetvdb.tvdbID}</a></td>
		<td><a title="Edit" href="{$smarty.const.WWW_TOP}/thetvdb-edit.php?id={$thetvdb.tvdbID}">{$thetvdb.seriesname|escape:"htmlall"}</a></td>
		<td class="right">
			<div class="btn-group">
				<a class="btn btn-mini btn-warning" title="Delete this TheTVDB entry" href="{$smarty.const.WWW_TOP}/thetvdb-delete.php?id={$thetvdb.tvdbID}">Delete</a>
				<a class="btn btn-mini btn-danger" title="Remove this tvdbID from all releases" href="{$smarty.const.WWW_TOP}/thetvdb-remove.php?id={$thetvdb.tvdbID}">Remove</a>
			</div>
		</td>
	</tr>
	{/foreach}

</table>
{else}

<div class="alert">
	<strong>Ups!</strong>
	No TheTVDB episodes available.
</div>
{/if}
