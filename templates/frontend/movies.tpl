<h2>Browse {$catname}</h2>

<div class="well well-small">
<center>
<form class="form-inline" name="browseby" action="movies" style="margin:0;">
		
		<i class="fa-icon-film"></i>
		<input class="input input-medium" id="movietitle" type="text" name="title" value="{$title}" placeholder="Title" />
		
		<i class="fa-icon-group"></i>
		<input class="input input-medium" id="movieactors" type="text" name="actors" value="{$actors}" placeholder="Actor" />
		
		<i class="fa-icon-bullhorn"></i>
		<input class="input input-medium" id="moviedirector" type="text" name="director" value="{$director}"  placeholder="Director" />
		
		<i class="fa-icon-star"></i>
			<select class="input input-mini" id="rating" name="rating">
				<option class="grouping" value=""></option>
				{foreach from=$ratings item=rate}
				<option {if $rating==$rate}selected="selected"{/if} value="{$rate}">{$rate}</option>
				{/foreach}
			</select>
			
		<i class="fa-icon-inbox"></i>
			<select class="input input-small" id="genre" name="genre">
				<option class="grouping" value=""></option>
				{foreach from=$genres item=gen}
					<option {if $gen==$genre}selected="selected"{/if} value="{$gen}">{$gen}</option>
				{/foreach}
			</select>
		
		<i class="fa-icon-calendar"></i>
			<select class="input input-small" id="year" name="year">
				<option class="grouping" value=""></option>
				{foreach from=$years item=yr}
					<option {if $yr==$year}selected="selected"{/if} value="{$yr}">{$yr}</option>
				{/foreach}
			</select>
			
		<i class="fa-icon-flag"></i>
			<select class="input input-small" id="category" name="t">
			<option class="grouping" value="2000"></option>
				{foreach from=$catlist item=ct}
				<option {if $ct.ID==$category}selected="selected"{/if} value="{$ct.ID}">{$ct.title}</option>
				{/foreach}
			</select>
		
		<input class="btn btn-success" type="submit" value="Go" />
</form>
</center>
</div>

{$site->adbrowse}	

{if $results|@count > 0}

{if $results|@count == 50}
	<div {if $section != ''}style="margin-bottom:-40px;"{else}style="margin-bottom:-20px;"{/if}>
	{$pager}
	</div>
{/if}

<form id="nzb_multi_operations_form" action="get">

View: <b>Covers</b> | <a href="{$smarty.const.WWW_TOP}/browse?t={$category}">List</a><br />

<div class="well well-small">
	<div class="nzb_multi_operations">
		With Selected:
		<div class="btn-group">
			<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
			<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
			{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to SAB" />{/if}
		</div>
	</div>
</div>

<table style="width:100%;" class="data highlight icons table table-striped" id="coverstable">
	<tr>
		<th width="130" style="padding-top:0px; padding-bottom:0px;">
			<input type="checkbox" class="nzb_check_all" />
		</th>
		
		<th style="padding-top:0px; padding-bottom:0px;">title<br/>
			<a title="Sort Descending" href="{$orderbytitle_desc}">
				<i class="fa-icon-caret-down"></i>
			</a>
			<a title="Sort Ascending" href="{$orderbytitle_asc}">
				<i class="fa-icon-caret-up"></i>
			</a>
		</th>
		
		<th style="padding-top:0px; padding-bottom:0px;">year<br/>
			<a title="Sort Descending" href="{$orderbyyear_desc}">
				<i class="fa-icon-caret-down"></i>
			</a>
			<a title="Sort Ascending" href="{$orderbyyear_asc}">
				<i class="fa-icon-caret-up"></i>
			</a>
		</th>
		
		<th style="padding-top:0px; padding-bottom:0px;">rating<br/>
			<a title="Sort Descending" href="{$orderbyrating_desc}">
				<i class="fa-icon-caret-down"></i>
			</a>
			<a title="Sort Ascending" href="{$orderbyrating_asc}">
				<i class="fa-icon-caret-up"></i>
			</a>
		</th>
	</tr>

	{foreach from=$results item=result}
		<tr class="{cycle values=",alt"}">
			<td class="mid">
				<div class="movcover">
					<a target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbID}/" name="name{$result.imdbID}" title="View movie info" class="modal_imdb" rel="movie" >
						<img class="shadow img-polaroid" src="{$smarty.const.WWW_TOP}/covers/movies/{if $result.cover == 1}{$result.imdbID}-cover.jpg{else}no-cover.jpg{/if}" width="120" border="0" alt="{$result.title|escape:"htmlall"}" />
					</a>
					<div class="movextra">
						<center>
						<a target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbID}/" name="name{$result.imdbID}" title="View movie info" class="rndbtn modal_imdb badge" rel="movie" >Cover</a>
						<a class="rndbtn badge badge-imdb" target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbID}/" name="imdb{$result.imdbID}" title="View imdb page">Imdb</a>
						</center>
					</div>
				</div>
			</td>
			<td colspan="3" class="left">
				<h4><a title="View Movie" href="{$smarty.const.WWW_TOP}/movies/?imdb={$result.imdbID}">{$result.title|escape:"htmlall"}</a> (<a class="title" title="{$result.year}" href="{$smarty.const.WWW_TOP}/movies?year={$result.year}">{$result.year}</a>) {if $result.rating != ''}{$result.rating}/10{/if}</h4>
				{if $result.tagline != ''}<b>{$result.tagline}</b><br />{/if}
				{if $result.plot != ''}{$result.plot}<br /><br />{/if}
				{if $result.genre != ''}<b>Genre:</b> {$result.genre}<br />{/if}
				{if $result.director != ''}<b>Director:</b> {$result.director}<br />{/if}
				{if $result.actors != ''}<b>Starring:</b> {$result.actors}<br /><br />{/if}
				<div class="movextra">
					<table class="table" style="margin-bottom:0px;">
						{assign var="msplits" value=","|explode:$result.grp_release_id}
						{assign var="mguid" value=","|explode:$result.grp_release_guid}
						{assign var="mnfo" value=","|explode:$result.grp_release_nfoID}
						{assign var="mgrp" value=","|explode:$result.grp_release_grpname}
						{assign var="mname" value="#"|explode:$result.grp_release_name}
						{assign var="mpostdate" value=","|explode:$result.grp_release_postdate}
						{assign var="msize" value=","|explode:$result.grp_release_size}
						{assign var="mtotalparts" value=","|explode:$result.grp_release_totalparts}
						{assign var="mcomments" value=","|explode:$result.grp_release_comments}
						{assign var="mgrabs" value=","|explode:$result.grp_release_grabs}
						{assign var="mpass" value=","|explode:$result.grp_release_password}
						{assign var="minnerfiles" value=","|explode:$result.grp_rarinnerfilecount}
						{assign var="mhaspreview" value=","|explode:$result.grp_haspreview}
						{foreach from=$msplits item=m}
						
						<tr id="guid{$mguid[$m@index]}" {if $m@index > 1}class="mlextra"{/if}>
							<td>
								<div class="icon"><input type="checkbox" class="nzb_check" value="{$mguid[$m@index]}" /></div>							
							</td>
							<td>
								<a href="{$smarty.const.WWW_TOP}/details/{$mguid[$m@index]}/{$mname[$m@index]|escape:"seourl"}">&nbsp;{$mname[$m@index]|escape:"htmlall"}</a>
								<ul class="inline">
									<li>Posted {$mpostdate[$m@index]|timeago}</li>
									<li>{$msize[$m@index]|fsize_format:"MB"}</li>
									<li><a title="View file list" href="{$smarty.const.WWW_TOP}/filelist/{$mguid[$m@index]}">{$mtotalparts[$m@index]}</a> <i class="fa-icon-file"></i></li>
									<li><a title="View comments" href="{$smarty.const.WWW_TOP}/details/{$mguid[$m@index]}/#comments">{$mcomments[$m@index]}</a> <i class="fa-icon-comments-alt"></i></li>
									<li>{$mgrabs[$m@index]} <i class="fa-icon-download-alt"></i></li>
									<li>{if $mnfo[$m@index] > 0}<a href="{$smarty.const.WWW_TOP}/nfo/{$mguid[$m@index]}" title="View Nfo" class="modal_nfo fa-icon-info-sign" rel="nfo"></a>{/if}</li>
									<li><a href="{$smarty.const.WWW_TOP}/browse?g={$mgrp[$m@index]}" title="Browse releases in {$mgrp[$m@index]|replace:"alt.binaries":"a.b"}" class="fa-icon-group"></a></li>
									<li>{if $mhaspreview[$m@index] == 1 && $userdata.canpreview == 1}<a href="{$smarty.const.WWW_TOP}/covers/preview/{$mguid[$m@index]}_thumb.jpg" name="name{$mguid[$m@index]}" title="View Screenshot" class="modal_prev" rel="preview">Preview</a>{/if}</li>
									<li>{if $minnerfiles[$m@index] > 0}<a href="#" onclick="return false;" class="mediainfo" title="{$mguid[$m@index]}">Media</a>{/if}</li>
								</ul>
							</td>
							<td class="icons">
								<div class="icon icon_nzb"><a title="Download Nzb" href="{$smarty.const.WWW_TOP}/getnzb/{$mguid[$m@index]}/{$mname[$m@index]|escape:"url"}">&nbsp;</a></div>
								<div class="icon icon_cart" title="Add to Cart"></div>
								{if $sabintegrated}<div class="icon icon_sab" title="Send to my Sabnzbd"></div>{/if}
							</td>
						</tr>
						{/foreach}		
					</table>
				</div>
			</td>
		</tr>
	{/foreach}
	
</table>
{if $results|@count > 10}
<div class="well well-small" style="margin-bottom:-9px;">
	<div class="nzb_multi_operations">
		With Selected:
		<div class="btn-group">
			<input type="button" class="nzb_multi_operations_download btn btn-small btn-success" value="Download NZBs" />
			<input type="button" class="nzb_multi_operations_cart btn btn-small btn-info" value="Add to Cart" />
			{if $sabintegrated}<input type="button" class="nzb_multi_operations_sab btn btn-small btn-primary" value="Send to SAB" />{/if}
		</div>
	</div>
</div>
{/if}
{if $results|@count == 50}
	<div style="margin-top:-20px;">
	{$pager}
	</div>
{/if}

</form>

{/if}
