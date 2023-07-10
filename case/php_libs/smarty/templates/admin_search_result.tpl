{include file="{$smarty.const._SITE_ROOT}case/admin/include/html_header.inc"}
</head>
<body>
<!--[HEADER]-->
{include file="{$smarty.const._SITE_ROOT}case/admin/include/header.inc"}
<!--/[HEADER]-->
<div id="contents"> 
 <!--[TOPICPATH]-->
 <div id="topicpath">
  <p>記事の追加・編集 ＞ 
   <a href="search.php">記事詳細検索</a> ＞　<strong>検索結果</strong>
  </p>
 </div>
 <!--/[TOPICPATH]-->
 {*{$sql}*}
 <!--[CONTENTS]--> 
   <h2 class="htype01">検索条件</h2>
   <div class="search_item">
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
   <h2 class="htype01">検索結果</h2>
   {if $count}
   <p class="result_num"><strong class="redB">{$count}件</strong> 見つかりました。</p>
   {else}
   <p class="indent b_m10">上記条件にあてはまる症例は見つかりませんでした。<br />
   <div class="submit"><a href="#" onClick="history.back(); return false;"><img src="/case/img/btn_case_back.gif" width="49" height="26" alt="" /></a></div>
   {/if}
   <div class="search_result">
   <ul>
   {foreach from=$data item="row"}
    <li class="clearfix">
    <div class="image"><img src="../{$row.photo_header}_thumb.jpg" width="118" height="78" alt="" /></div>
    <div class="detail">
    <h3><a href="kiji_confirm.php?id={$row.id}">{$row.kansou_mark}{$row.age}歳　{$row.sex}{$row.sex_ex}　{$row.shiretsu}　{$row.basshi}{if $row.basshi_bui}<span>　（抜歯部位：{$row.basshi_bui}）</span>{/if}</a></h3>
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
    {if $row.tantou}
    <li>
    <dl class="clearfix">
    <dt>担当医：</dt>
    <dd>{$row.tantou}</dd>
    </dl>
    </li>
    {/if}
    </ul>
    </div>
    </li>
    {/foreach}
   </ul>
   </div>
 <!--/[CONTENTS]--> 
</div>
<!--[PAGETOP]-->
<div id="pagetop">
 <p><a href="#header">ページトップへ</a></p>
</div>
<!--/[PAGETOP]--> 
<!--[FOOTER]-->
<div id="footer_path_container">
 <div id="footer_path">
  <p>記事の追加・編集 ＞ 
   <a href="search.php">記事詳細検索</a> ＞　<strong>検索結果</strong>
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
