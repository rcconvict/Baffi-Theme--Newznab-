<div class="page-header">
	<h1>{$page->title}</h1>
</div>

{if $movielist}

<div class="navbar">
	<div class="navbar-inner">
		<form method="get" class="navbar-form pull-left" name="moviesearch" action="">
			<div class="input-append">
				<input class="input input-xlagre" id="moviename" type="text" name="moviename" value="{$moviename}" placeholder="Title" />
				<input class="btn btn-success" type="submit" value="Search" />
			</div>
		</form>
	</div>
</div>

{$pager}

<br/><br/>

<table class="data Sortable highlight table table-striped">

	<tr>
		<th>IMDB ID</th>
		<th>TMDb ID</th>
		<th>Title</th>
		<th class="mid">Cover</th>
		<th class="mid">Backdrop</th>
		<th style="width:80px;">Created</th>
		<th style="width:100px;" class="right">options</th>
	</tr>
	
	{foreach from=$movielist item=movie}
	<tr class="{cycle values=",alt"}">
		<td class="less"><a href="http://www.imdb.com/title/tt{$movie.imdbID}" title="View in IMDB">{$movie.imdbID}</a></td>
		<td class="less"><a href="http://www.themoviedb.org/movie/{$movie.tmdbID}" title="View in TMDb">{$movie.tmdbID}</a></td>
		<td><a title="Edit" href="{$smarty.const.WWW_TOP}/movie-edit.php?id={$movie.imdbID}">{$movie.title} ({$movie.year})</a></td>
		<td class="less mid">{if $movie.cover == "1"}Yes{else}No{/if}</td>
		<td class="less mid">{if $movie.backdrop == "1"}Yes{else}No{/if}</td>
		<td class="less" style="width:100px;">{$movie.createddate|date_format}</td>
		<td class="right">
			<div class="btn-group">
			<a class="btn btn-mini btn-warning" title="update" href="{$smarty.const.WWW_TOP}/movie-add.php?id={$movie.imdbID}&amp;update=1">Update</a> | 
			<a class="btn btn-mini btn-danger" title="delete" href="{$smarty.const.WWW_TOP}/movie-delete.php?id={$movie.imdbID}">Delete</a>
			</div>
		</td>
	</tr>
	{/foreach}

</table>
{else}
<div class="alert">
	<strong>Ups!</strong>
	No Movies available.
</div>
{/if}
