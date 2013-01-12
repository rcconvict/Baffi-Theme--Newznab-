<div class="page-header">
	<h2>{$page->title}</h2>
</div>

{if $releaselist}
{$pager}

<table class="data Sortable highlight table table-striped">

	<tr>
		<th>name</th>
		<th>category</th>
		<th>size</th>
		<th>files</th>
		<th>posted</th>
		<th>added</th>
		<th>grabs</th>
		<th>options</th>
	</tr>
	
	{foreach from=$releaselist item=release}
	<tr class="{cycle values=",alt"}">
		<td title="{$release.name}"><a href="{$smarty.const.WWW_TOP}/release-edit.php?id={$release.ID}">{$release.searchname|escape:"htmlall"|wordwrap:75:"\n":true}</a></td>
		<td class="less">{$release.category_name}</td>
		<td class="less">{$release.size|fsize_format:"MB"}</td>
		<td class="less" style="width:50px;"><a href="release-files.php?id={$release.guid}">{$release.totalpart} <i class="fa-icon-file"></i></a></td>
		<td class="less">{$release.postdate|date_format}</td>
		<td class="less">{$release.adddate|date_format}</td>
		<td class="less">{$release.grabs} <i class="icon-download-alt"></td>
		<td><a class="btn btn-mini btn-danger" href="{$smarty.const.WWW_TOP}/release-delete.php?id={$release.ID}">Delete</a></td>
	</tr>
	{/foreach}

</table>
{else}
<p>No releases available.</p>
{/if}
