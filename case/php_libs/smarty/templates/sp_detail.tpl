<!DOCTYPE HTML>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
<meta name="apple-touch-fullscreen" content="YES">
<link rel="apple-touch-icon" href="/sp/common/img/HoteiTouchIcon.png">
<title>{$data.kansou_mark}{$data.age}歳　{$data.sex}{$data.sex_ex}　{$data.shiretsu}　{$data.basshi}｜症例紹介｜矯正歯科 大阪【ほてい矯正歯科】</title>
<link rel="stylesheet" href="/sp/common/css/import.css">
<link rel="stylesheet" href="/case/css/case_sp.css" type="text/css">
<link rel="stylesheet" href="/case/css/jquery.lightbox.css" type="text/css">
<script src="/sp/common/js/import.js"></script>
<script type="text/javascript" src="/case/js/jquery.lightbox.js"></script>
<script type="text/javascript" src="/case/js/jquery.lightbox_cross.js"></script>
<link rel="canonical" href="http://www.hotei.or.jp/case/" />
</head>
<body>
<!-- [header] -->
{include file="{$smarty.const._SITE_ROOT}sp/common/ssi/header.html"}
<!-- /[header] -->
<div id="contents"> 
	<!-- [contents] -->
   <h1 id="pageTitle" class="bm0">{$data.kansou_mark}{$data.age}歳　{$data.sex}{$data.sex_ex}　{$data.shiretsu}　{$data.basshi}{if $data.basshi_bui}<br>（抜歯部位：{$data.basshi_bui}）{/if}</h1>
   <div class="sub_header">
			<ul>
			<li>{$data.shindan}</li>
   {if $data.shindan_sub}
   {foreach from=$data.shindan_sub item="val"}
   <li>《{$val}》</li>
   {/foreach}
   {/if}
			</ul>
   </div>
<div class="photo_header"><img src="{$data.photo_header}_thumb.jpg" width="180" height="120" alt=""></div>
<p class="insideBlk">Case{$data.case_num}<br>
{$data.thisinfo}</p>
   {if $data.kansou}
   <h2 class="htype01 bm10">患者さんからの感想</h2>
   <div class="insideBlk">
   <p>{$data.kansou}</p>
   </div>
   {/if}
   {if $data.comment}
   <h2 class="htype01 bm10">クリニックコメント</h2>
   <div class="insideBlk">
   <p>{$data.comment}</p>
   </div>
   {/if}
			{if $data.souchi}
   <h2 class="htype01">装置</h2>
   <ul class="listDot bm10 tm10">
   {foreach from=$data.souchi item="val"}
   <li>{$val}</li>
   {/foreach}
   </ul>
   {/if}
			{if $data.tantou}
   <h2 class="htype01">担当医</h2>
   <ul class="listDot bm10 tm10">
   {foreach from=$data.tantou item="val"}
   <li>{$val}</li>
   {/foreach}
   </ul>
   {/if}
   <h2 class="htype01">症例画像</h2>
			<dl class="categoy_entries tm10">
   {foreach from=$photo item="status"}
   {$photo_name = $status.title.name}
   {if $data.$photo_name.0}
   	<dt>{$status.title.header}</dt>
				<dd>
    	<ul class="clearfix">
     {foreach from=$data.$photo_name key="key" item="photo_path"}
     {if $photo_path}
     	<li><a href="{$photo_path}_thumb.jpg" rel="lightbox"><img src="{$photo_path}_thumb.jpg" width="70" height="46" alt="" /></a></li>
      {/if}
     {/foreach}
    	</ul>
					</dd>
   {/if}
   {/foreach}
			</dl>
   {if $related_count > 1}
<h2 class="htype01">【{$data.shindan}】{if $nendai_name} 【{$nendai_name}】{/if} その他の症例</h2>
   <ul class="categoy_entries clearfix tm15">
   {foreach from=$related_data item="row"}
   {if $row.id != $main_id}
    <li>
     <div><a href="detail.php?id={$row.id}&car=sp"><img src="{$row.photo_header}_thumb.jpg" width="70" height="46" alt=""></a></div>
      <p><a href="detail.php?id={$row.id}&car=sp">{$row.kansou_mark}{$row.age}歳 {$row.sex}{$row.sex_ex}<br>
{$row.shiretsu}<br>
{$row.basshi}</a></p>
    </li>
    {/if}
    {/foreach}
   </ul>
   {/if}
			
<p class="shourei_top">
{if $nendai_id}
<a href="/case/nendai.php?id={$nendai_id}&car=sp">{$nendai_name} トップに戻る</a>
{else}
<a href="/case/shindan.php?id={$shindan_id}&car=sp">{$data.shindan} トップに戻る</a>
{/if}
</p>
<!-- /[contents] --> 
</div>
<!-- [footer] -->
{include file="{$smarty.const._SITE_ROOT}sp/common/ssi/footer.html"}
<!-- /[footer] -->
</body>
</html>