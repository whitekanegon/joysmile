{include file="{$smarty.const._SITE_ROOT}case/include/html_header.html"}
<body>
{include file="{$smarty.const._SITE_ROOT}lib/ssi/header.html"}
<div id="topicpath"><a href="/">トップページ</a> &gt; <a href="/case/">症例紹介</a> &gt; 症例検索結果</div>
<div id="container">
	<div id="contents" class="wide">
<!--[contents]-->
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
   <h1 class="htype01">症例検索結果</h1>
   <!--/[cont_header]-->
   <h2 class="htype04">検索条件</h2>
   <div class="search_condition">
   {if $post_count}
   <dl>
   {foreach from=$search_item item="row"}
   <dt>{$row.name}</dt>
   <dd>{$row.result}</dd>
   {/foreach}
   </dl>
   {else}
   <p>全ての症例</p>
   {/if}
   </div>
   <h2 class="htype04">検索結果</h2>
   {if $count}
   <p class="result_num"><strong class="redB">{$count}件</strong> 見つかりました。</p>
   {else}
   <p class="result_num b_m10">上記条件にあてはまる症例は見つかりませんでした。<br />
   <div class="submit"><a href="#" onclick="history.back(); return false;" class="cmnbtn03 back">戻る</a></div>
   {/if}
   <div class="search_result search">
   <ul>
   {foreach from=$data item="row"}
    <li class="clearfix">
    <div class="image"><img src="{$row.photo_header}_thumb.jpg" width="118" height="78" alt="" /></div>
    <div class="detail">
    <h3><a href="detail.php?id={$row.id}">{$row.kansou_mark}{$row.age}歳　{$row.sex}{$row.sex_ex}　{$row.shiretsu}　{$row.basshi}{if $row.basshi_bui}<span>　（抜歯部位：{$row.basshi_bui}）</span>{/if}</a></h3>
    <ul>
    <li>
    <dl class="clearfix">
    <dt>診断名：</dt>
    <dd>{$row.shindan}</dd>
    </dl>
    </li>
    {if $row.shindan_sub}
    <li class="shindan_sub">
    <dl class="clearfix">
    <dt>診断名（サブ）：</dt>
    <dd>{$row.shindan_sub}</dd>
    </dl>
    </li>
    {/if}
    <li>
    <dl class="clearfix">
    <dt>説明：</dt>
    <dd>{$row.thisinfo}</dd>
    </dl>
    </li>
    {if $row.souchi}
    <li class="souchi">
    <dl class="clearfix">
    <dt>装置：</dt>
    <dd>{$row.souchi}</dd>
    </dl>
    </li>
    {/if}
    {* 担当医 非表示
    {if $row.tantou}
    <li>
    <dl class="clearfix">
    <dt>担当医：</dt>
    <dd>{$row.tantou}</dd>
    </dl>
    </li>
    {/if}
    *}
    </ul>
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































