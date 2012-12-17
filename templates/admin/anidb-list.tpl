<div class="page-header">
	<h1>{$page->title}</h1>
</div>

{if $anidblist}

<div class="navbar">
	<div class="navbar-inner">
		<form method="get" class="navbar-form pull-left" name="anidbsearch" action="">
			<div class="input-append">
				<input class="input input-xlagre" id="animetitle" type="text" name="animetitle" value="{$animetitle}" placeholder="Title" />
				<input class="btn btn-success" type="submit" value="Search" />
			</div>
		</form>
	</div>
</div>

{$pager}

<br/><br/>

<table class="data Sortable highlight table table-striped">

	<tr>
		<th style="width:60px;">AniDB Id</th>
		<th>Title</th>
		<th style="width:120px;" class="right">Options</th>
	</tr>
	
	{foreach from=$anidblist item=anidb}
	<tr class="{cycle values=",alt"}">
		<td class="less"><a href="http://anidb.net/perl-bin/animedb.pl?show=anime&amp;aid={$anidb.anidbID}" title="View in AniDB">{$anidb.anidbID}</a></td>
		<td><a title="Edit" href="{$smarty.const.WWW_TOP}/anidb-edit.php?id={$anidb.anidbID}">{$anidb.title|escape:"htmlall"}</a></td>
		<td class="right">
			<div class="btn-group">
				<a class="btn btn-mini btn-warning" title="Delete this AniDB entry" href="{$smarty.const.WWW_TOP}/anidb-delete.php?id={$anidb.anidbID}">Delete</a>
				<a class="btn btn-mini btn-danger" title="Remove this anidbID from all releases" href="{$smarty.const.WWW_TOP}/anidb-remove.php?id={$anidb.anidbID}">Remove</a>
				</div>
		</td>
	</tr>
	{/foreach}

</table>
{else}
<div class="alert">
	<strong>Ups!</strong>
	No AniDB episodes available.
</div>
{/if}
