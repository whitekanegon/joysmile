<!DOCTYPE HTML>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<meta name="apple-touch-fullscreen" content="YES">
<link rel="apple-touch-icon" href="/sp/common/img/HoteiTouchIcon.png">
<title>症例紹介｜矯正歯科 大阪【ほてい矯正歯科】</title>
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
<h1 id="pageTitle" class="bm0">症例検索結果</h1>
   <h2 class="htype01 bm10">検索条件</h2>
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
   <h2 class="htype01 bm10">検索結果</h2>
   <div class="search_result">
			<div class="count">
   {if $count}
   <p class="result_num"><strong class="redB">{$count}件</strong> 見つかりました。</p>
   {else}
   <p class="result_num b_m10">上記条件にあてはまる症例は見つかりませんでした。<br />
   {/if}
			</div>
   <ul class="menuLink">
   {foreach from=$data item="row"}
    <li>
				<a href="detail.php?id={$row.id}&car=sp" class="clearfix">
				<img src="{$row.photo_header}_thumb.jpg" width="60" height="40" alt="" />
				{$row.kansou_mark}{$row.age}歳 {$row.sex}{$row.sex_ex} {$row.shiretsu} {$row.basshi}<br>
<span>《{$row.shindan}》</span>
				</a>
    </li>
    {/foreach}
   </ul>
   </div>
<p class="shourei_top"><a href="/case/?car=sp">症例紹介トップに戻る</a></p>
<!-- /[contents] --> 
</div>
<!-- [footer] -->
{include file="{$smarty.const._SITE_ROOT}sp/common/ssi/footer.html"}
<!-- /[footer] -->
</body>
</html>