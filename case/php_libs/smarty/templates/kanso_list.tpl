{include file="{$smarty.const._SITE_ROOT}case/include/html_header.html"}
<body>
{include file="{$smarty.const._SITE_ROOT}lib/ssi/header.html"}
<div id="topicpath"><a href="/">トップページ</a> &gt; <a href="/case/">症例紹介</a> &gt; 患者さんからの感想　【{$category}】</div>
<div id="container">
	<div id="contents" class="wide">
{*
{foreach from=$post key="key" item="val"}
<p style="margin-bottom:0;">{$key} = {$val}</p>
{/foreach}
<p>{$sql}</p>
hit_id_orap
<ul>
{foreach from=$hit_id_orap key="key" item="val"}
<li>{$key} = {$val}</li>
{/foreach}
</ul>
hit_id_check
<ul>
{foreach from=$hit_id_check key="key" item="val"}
<li>{$key} = {$val}</li>
{/foreach}
</ul>
hit_id_dmy
<ul>
{foreach from=$hit_id_dmy key="key" item="val"}
<li>
word {$key}
<ul>
{foreach from=$val key="k" item="v"}
<li>{$k} = {$v}</li>
{/foreach}
</ul>
</li>
{/foreach}
</ul>
*}
<!--[contents]-->
{if $admin_mode}
<div class="admin_header">
<dl class="clearfix">
<dt>【管理モード】</dt>
<dd class="logout"><a href="/case/admin/admin_mode_logout.php"><img src="/case/img/btn_logout.gif" width="70" height="22" alt="ログアウト" /></a></dd>
</dl>
</div>
{/if}
   <!--[cont_header]-->
   <h1 class="htype01">患者さんからの感想　【{$category}】</h1>
			{*<p class="result_num"><strong class="redB">{$count}件</strong> 見つかりました。</p>*}
			{if $category_type}
			<p class="categoryback"><a href="{$category_type}.php?id={$category_code}" class="cmnbtn03">「{$category}」 症例一覧へ戻る</a></p>
			{/if}
   <!--/[cont_header]-->
   <div class="search_result kanso">
   <ul>
   {foreach from=$data item="row"}
    <li class="clearfix">
    <div class="image"><img src="{$row.photo_header}_thumb.jpg" width="118" height="78" alt="" /></div>
    <div class="detail">
    <h3><a href="detail.php?id={$row.id}">{$row.age}歳　{$row.sex}{$row.sex_ex}　{$row.shiretsu}　{$row.basshi}{if $row.basshi_bui}<span>　（抜歯部位：{$row.basshi_bui}）</span>{/if}</a></h3>
							<div class="shindan_title clearfix">
								<p class="notice_category"><strong>{$row.shindan}</strong></p>
								{if $row.shindan_sub}
								<div class="sub clearfix">
									<p>{$row.shindan_sub}</p>
								</div>
								{/if}
								</div>
								<p>{$row.kansou}</p>
							</div>
    </li>
    {/foreach}
   </ul>
   </div>
<!--/[contents]-->
</div>

<div id="bnavi">
<!--[side]-->
{include file="{$smarty.const._SMARTY_TEMPLATES_DIR}sidemenu.tpl"}
<!--/[side]-->
</div>
</div>
<!--/[container]-->
<!--[footer]-->
{include file="{$smarty.const._SITE_ROOT}lib/ssi/footer.html"}
<!--/[footer]-->
</body>
</html>































