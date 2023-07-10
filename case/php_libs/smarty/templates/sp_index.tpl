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
<h1 id="pageTitle">症例紹介</h1>
<p class="insideBlk">代表的な不正咬合をご紹介いたします。その分類ごとに、混合歯列期（小学校のお子様）、永久歯列期（中学生以上）にわけ、それぞれで抜歯ケース、非抜歯ケースでの治療例を紹介いたしております。ただし、症例によっては、「叢生」、「前歯部交叉咬合」など、厳密には分けがたい場合もありますが、ご覧頂きやすい方に分類しております</p>
<p class="insideBlk">《全症例数：{$all_count.0}件》</p>
<h2 class="htype01Link tglSwitch"><a href="#">診断別</a></h2>
<ul class="menuLink thumb tglclose">
{foreach from=$shindan key="key" item="row"}
 <li><a href="shindan.php?id={$row.id}&car=sp"><img src="{$row.photo_header}.jpg" alt="{$row.name}" width="60" height="40">{$row.name} ({$shindan_count.$key})</a></li>
{/foreach}
</ul>
<h2 class="htype01Link tglSwitch"><a href="#">年代別</a></h2>
<ul class="menuLink tglclose">
{foreach from=$nendai key="key" item="row"}
 <li><a href="nendai.php?id={$row.id}&car=sp">{$row.name} ({$nendai_count.$key})</a> </li>
{/foreach}
</ul>
<h2 class="htype01Link tglSwitch"><a href="#">その他</a></h2>
<div class="top_others_area tglclose">
<form method="get" action="search_result.php" id="top_others" name="top_others">
<input type="hidden" name="car" value="sp">
<span id="select_fake"></span>
<select name="side_others" onchange="submit(this.form)" id="top_others_select">
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
<option value="shindan=12">先天性欠損</option>
<option value="basshi=3">補綴併用</option>
<option value="shindan=10">口唇口蓋裂</option>
<option value="basshi=4">外科矯正</option>
</select>
</form>
</div>
<h2 class="htype01Link tglSwitch"><a href="#">フリーワード検索</a></h2>
<div class="freeword tglclose">
<form method="get" action="search_result.php?car=sp" name="search_word">
<input type="text" name="freeword" value="{$sword}" class="text_box">
<input type="hidden" name="car" value="sp">
<input type="hidden" name="s_con" value="AND">
<input type="submit" class="submit_btn" value="検索" alt="検索">
</form>
</div>
<!-- /[contents] --> 
</div>
<!-- [footer] -->
{include file="{$smarty.const._SITE_ROOT}sp/common/ssi/footer.html"}
<!-- /[footer] -->
</body>
</html>