<div class="caseMenu">
<nav>
<div class="shindan">
<h2>診断別</h2>
<ul>
{foreach from=$shindan key="key" item="row"}
<li><a href="shindan.php?id={$row.id}">{$row.name}<span class="count">（{$shindan_count.$key}）</span></a><span class="kanso"><a href="kanso_list.php?shindan[]={$row.id}">患者さんからの感想</a></span></li>
{/foreach}
</ul>
</div>
<div class="nendai">
<h2>年代別</h2>
<ul>
{foreach from=$nendai key="key" item="row"}
<li><a href="nendai.php?id={$row.id}">{$row.name}<span class="count">（{$nendai_count.$key}）</span></a><span class="kanso"><a href="kanso_list.php?nendai[]={$row.id}">患者さんからの感想</a></span></li>
{/foreach}
</ul>
</div>
{* 担当医別は出力しない
<div class="tanto">
<h2>担当医別</h2>
<ul>
{foreach from=$tantou key="key" item="row"}
 <li><a href="tantou.php?id={$row.id}">{$row.name} （{$tantou_count.$key}）</a><span><a href="kanso_list.php?tantou[]={$row.id}">患者さんからの感想</a></span></li>
{/foreach}
</ul>
</div>
*}
<div class="sonota">
<div class="kubun">
<h2>治療区分</h2>
<ul>
<li><a href="kubun.php?id=1">前期のみ</a></li>
</ul>
</div>
<div class="others">
<h2>その他</h2>
<form method="get" action="search_result.php" name="others">
<select name="side_others" onchange="submit(this.form)">
<option value="">お選びください</option>
<option value="sex=男">男性</option>
<option value="sex=女">女性</option>
<option value="shiretsu=1">乳歯列</option>
<option value="shiretsu=2:basshi=1">混合歯列：抜歯</option>
<option value="shiretsu=2:basshi=2">混合歯列：非抜歯</option>
<option value="shiretsu=3:basshi=1">永久歯列：抜歯</option>
<option value="shiretsu=3:basshi=2">永久歯列：非抜歯</option>
<option value="basshi_bui=1">抜歯部位：上下顎小臼歯</option>
<option value="basshi_bui=2">抜歯部位：上顎小臼歯</option>
<option value="basshi_bui=4">抜歯部位：下顎小臼歯</option>
<option value="basshi_bui=3">抜歯部位：上顎その他</option>
<option value="basshi_bui=5">抜歯部位：下顎その他</option>
<option value="shindan=12">欠損歯</option>
<option value="basshi=3">補綴併用</option>
<option value="shindan=10">口唇口蓋裂</option>
<option value="basshi=4">外科矯正</option>
</select>
</form>
</div>
</div>
{if !$search}
<div class="freewords">
<h2>フリーワード検索</h2>
<form method="get" action="search_result.php" name="search_word">
<div class="freeword clearfix b_m10">
<input type="text" name="freeword" value="{$sword}" class="text freeword" />
<div class="submit">
<ul class="con clearfix">
<li><label for="s_con_and"><input type="radio" name="s_con" value="AND" id="s_con_and" checked="checked" />AND</label></li>
<li><label for="s_con_or"><input type="radio" name="s_con" value="OR" id="s_con_or" />OR</label></li>
</ul>
<input type="submit" class="cmnbtn03" value="検索">
</div>
</div>
</form>
<p class="search_detail"><a href="/case/search.php">症例詳細検索はこちら</a></p>
</div>
{/if}
</nav>
</div>
