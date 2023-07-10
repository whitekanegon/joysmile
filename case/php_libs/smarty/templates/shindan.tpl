{include file="{$smarty.const._SITE_ROOT}case/include/html_header.html"}
<body>
{include file="{$smarty.const._SITE_ROOT}lib/ssi/header.html"}
<div id="topicpath"><a href="/">トップページ</a> &gt; <a href="/case/">症例紹介</a> &gt; {$data.name}</div>
<div id="container">
	<div id="contents" class="wide">
{if $admin_mode}
<div class="admin_header">
<dl class="clearfix">
<dt>【管理モード】</dt>
<dd class="logout"><a href="/case/admin/admin_mode_logout.php"><img src="/case/img/btn_logout.gif" width="70" height="22" alt="ログアウト" /></a></dd>
</dl>
</div>
{/if}
   <!--[cont_header]-->
   <h1 class="htype01">{$data.name}</h1>
   <!--/[cont_header]-->
   <div class="lead_category">
    <div class="image"><img src="{$data.photo_header}.jpg" width="180" height="120" alt="" /></div>
    <div class="detail">
     <p>{$data.explanation}</p>
     {* 関連記事は出力しない
     {if $data.related_title.0}
      <h2 class="htype01">関連記事</h2>
       <ul class="listtype01">
       {foreach from=$data.related_title key="key" item="val"}
        <li><a href="{$data.related_url.$key}">{$val}</a></li>
       {/foreach}
       </ul>
      {/if}
     *}
    </div>
   </div>
			<p class="posC"><a href="kanso_list.php?shindan[]={$shindan_id}" class="cmnbtn03">患者さんからのコメント一覧はこちら</a></p>
			{$count_id = $shindan_id - 1}
   <h2 class="htype02">症例（{$shindan_count.$count_id}）</h2>
   <p>尚、患者さんから治療についてのコメントをいただけたものは、★印が付いております。</p>
   <dl class="categoy_entries">
   {foreach from=$shindan_cate key="key" item="row_cate"}
   {if $row_cate}
    <dt>【{$category_title.$key}】</dt>
    <dd>
     <ul>
       {foreach from=$row_cate item="row"}
      <li>
       <div><a href="detail.php?id={$row.id}"><img src="{$row.photo_header}.jpg" width="120" height="80" alt="" /></a></div>
       <p><a href="detail.php?id={$row.id}">{$row.kansou_mark}{$row.age}歳　{$row.sex}{$row.sex_ex}</a></p>
      </li>
       {/foreach}
     </ul>
    </dd>
    {/if}
    {/foreach}
   </dl>
<!--/[contents]-->
<p class="backtop"><a href="/case/" class="cmnbtn03">症例紹介トップに戻る</a></p>
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































