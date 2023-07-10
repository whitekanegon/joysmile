<!DOCTYPE HTML>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<meta name="apple-touch-fullscreen" content="YES">
<link rel="apple-touch-icon" href="/sp/common/img/HoteiTouchIcon.png">
<title>{$data.name}｜症例紹介｜矯正歯科 大阪【ほてい矯正歯科】</title>
<link rel="stylesheet" href="/sp/common/css/import.css">
<link rel="stylesheet" href="/case/css/case_sp.css" type="text/css">
<script src="/sp/common/js/import.js"></script>
<link rel="canonical" href="http://www.hotei.or.jp/case/" />
</head>
<body>
<!-- [header] -->
{include file="{$smarty.const._SITE_ROOT}sp/common/ssi/header.html"}
<!-- /[header] -->
<div id="contents"> 
	<!-- [contents] -->
<h1 id="pageTitle">{$data.name}</h1>
<p class="insideBlk">{$data.explanation}</p>
<h2 class="htype01 bm10">症例</h2>
<p class="insideBlk">尚、患者さんから治療についてのコメントをいただけたものは、★印が付いております。</p>
   <dl class="categoy_entries">
   {foreach from=$shindan_cate key="key" item="row_cate"}
   {if $row_cate}
    <dt>【{$category_title.$key.name}】</dt>
    <dd>
     <ul class="clearfix">
       {foreach from=$row_cate item="row"}
      <li>
       <div><a href="detail.php?id={$row.id}&nendai={$nendai_id}&car=sp"><img src="{$row.photo_header}.jpg" width="70" height="46" alt=""></a></div>
       <p><a href="detail.php?id={$row.id}&nendai={$nendai_id}&car=sp">{$row.kansou_mark}{$row.age}歳 {$row.sex}{$row.sex_ex}</a></p>
      </li>
       {/foreach}
     </ul>
    </dd>
    {/if}
    {/foreach}
   </dl>
<p class="shourei_top"><a href="/case/?car=sp">症例紹介トップに戻る</a></p>
<!-- /[contents] --> 
</div>
<!-- [footer] -->
{include file="{$smarty.const._SITE_ROOT}sp/common/ssi/footer.html"}
<!-- /[footer] -->
</body>
</html>