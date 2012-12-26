{if $page->isSuccess()}
	<div align="center">
		<p>The news server setup is correct. If you need to change these settings, they can be edited in /www/config.php. <br/><br/>You may continue to the next step.</p>
		<form action="step4.php"><input type="submit" value="Step four: Cache Settings" /></form>
	</div>
{else}

<p>
newznab supports caching to improve site performance. You can select from none, file, apc or memcache.
</p>
<ul>
<li>None - Caching disabled.</li>
<li>File - Query results are saved files in /yourinstall/db/cache.</li>
<li>Memcache/APC - Query results cached in memcache or APC service</li>
</ul>

<p>The cache settings can be altered later by editing your config.php file</p>

<form action="?" method="post">
	<table width="100%" border="0" style="margin-top:10px;" class="data highlight">
		<tr class="">
			<td><label for="server">Caching Type:</label></td>
			<td>
				<select name="cacheopt">
					<option value="none">None</option>
					<option value="file">File</option>
					<option value="memcache">Memcache</option>
					<option value="apc">APC</option>
				</select>
			</td>
		</tr>
	</table>

	<div style="padding-top:20px; text-align:center;">
		<input type="submit" value="Save configuration file" />
	</div>

</form>

{/if}