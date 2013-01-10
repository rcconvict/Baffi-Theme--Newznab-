<h2>My Cart</h2>

<p>
	Your cart can be downloaded as an <a href="{$smarty.const.WWW_TOP}/rss?t=-2&amp;dl=1&amp;i={$userdata.ID}&amp;r={$userdata.rsstoken}&amp;del=1">Rss Feed</a>.
</p>

{if $results|@count > 0}

<form id="nzb_multi_operations_form" action="get">

	<div class="well well-small">
		<div class="nzb_multi_operations">
			With Selected:
			<div class="btn-group">
				<input type="button" class="nzb_multi_operations_cartdelete btn btn-small btn-danger" value="Delete"/>
				{if $sabintegrated}<input type="button" class="nzb_multi_operations_cartsab btn btn-small btn-primary" value="Send To Sab"/>{/if}
				<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download">
			</div>
		</div>
	</div>

	<table style="width:100%;" class="data highlight table table-striped" id="browsetable">
		<tr>
			<th width="50"><input id="chkSelectAll" type="checkbox" class="nzb_check_all" /><label for="chkSelectAll" style="display:none;">Select All</label></th>
			<th>name</th>
			<th>added</th>
			<th>options</th>
		</tr>

		{foreach from=$results item=result}
		<tr class="{cycle values=",alt"}">
			<td class="check">
				<input id="chk{$result.guid|substr:0:7}" type="checkbox" class="nzb_check" value="{$result.guid}" />
			</td>
			<td>
				<a title="View details" href="{$smarty.const.WWW_TOP}/details/{$result.guid}/{$result.searchname|escape:"seourl"}">{$result.searchname|escape:"htmlall"|wordwrap:75:"\n":true}</a>
			</td>
			<td class="less" title="Added on {$result.createddate}">{$result.createddate|date_format}</td>
			<td><a class="btn btn-mini btn-danger" title="Delete from your cart" href="?delete={$result.guid}">Delete</a></td>
		</tr>
		{/foreach}

	</table>
</form>

{else}
<div class="pull-left alert alert-info">
	<h4>Sorry!</h4>
	There is no NZBs in your cart. Sorry!
</div>
{/if}