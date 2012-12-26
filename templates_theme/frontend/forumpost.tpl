<h2><a href="{$smarty.const.WWW_TOP}/forum">Forum</a></h2>


{if $results|@count > 0}

<h3>{$results[0].subject|escape:"htmlall"}</h3>

<div style="float:right;margin-bottom:5px;"><a class="btn btn-small btn-primary" href="#reply">Reply</a></div>

<a id="top"></a>
<table style="width:100%;" class="data highlight table table-striped" id="forumtable">
	<tr>
		<th style="padding-top:0px; padding-bottom:0px;">By</th>
		<th style="padding-top:0px; padding-bottom:0px;">Message</th>
	</tr>

	{foreach from=$results item=result name=result}
		<tr class="{cycle values=",alt"}">
			<td width="15%;">
				{if $result.isadmin == 1}<strong>{/if}
				<a {if $smarty.foreach.result.last}id="last"{/if} title="{if $result.isadmin == 1}Admin{else}View profile{/if}" href="{$smarty.const.WWW_TOP}/profile/?name={$result.username}">{$result.username}</a>
				{if $result.isadmin == 1}</strong>{/if}
				<br/>
				on <span title="{$result.createddate}">{$result.createddate|date_format}</span> <div class="hint">({$result.createddate|timeago})</div>
				{if $userdata.role==2}
				<div>
					<a class="rndbtn confirm_action btn btn-mini btn-danger" href="{$smarty.const.WWW_TOP}/admin/forum-delete.php?id={$result.ID}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Delete Post">Delete</a>
				</div>
				{/if}
				
			</td>
			<td>{$result.message|escape:"htmlall"|nl2br|magicurl}</td>
		</tr>
	{/foreach}
	
</table>

<div style="float:right;margin-top:5px;"><a class="btn btn-small" href="#">Top</a></div>


<div style="margin-top:10px;">
<h3>Add Reply</h3>
<a id="reply"></a>
<form class="form-horizontal" action="" method="post">
	
	<div class="control-group">
		<label class="control-label" for="addReply">Message</label>
		<div class="controls">
			<textarea class="input input-xlarge" maxlength="5000" id="addReply" name="addReply" rows="6" cols="100"></textarea>
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label"></label>
		<div class="controls">
			<input class="forumreplysubmit btn btn-success" type="submit" value="submit"/>
		</div>
	</div>
</form>
</div>

{/if}

