<?xml version="1.0" encoding="{$charset}"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ja" xml:lang="ja">
<head>
<meta http-equiv="content-Type" content="application/xhtml+xml; charset={$charset}" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>症例紹介｜矯正歯科 大阪【ほてい矯正歯科】</title>
<style type="text/css">
<![CDATA[ a:link { color: #0000FF;}
a:visited {	color: #003399}]]>
</style>
</head>
<body>
<!--WRAP-->
<div style="color:#444; font-size:small; width:240px; margin:0 auto; line-height:1.5em;">
<!--HEADER-->
{include file="{$smarty.const._SITE_ROOT}m/ssi/header_case.html"}
<!--/HEADER-->
<h1 style="color:#000; line-height:1em; margin-bottom:0; padding:0 10px; background:#FFF;"><span style="font-size:small;font-weight:normal;">症例紹介</span></h1>
<div style="padding:0 0 10px;background:#EFEFEF;"><img src="/m/img/line_s01.jpg" alt="" width="240" height="11" /></div>
<div style="background:#EFEFEF;margin-bottom:10px; padding:10px 0 10px 0;">
<!--CONTENTS-->
<div style="margin-bottom:10px; padding:0 10px;">代表的な不正咬合をご紹介いたします。その分類ごとに、混合歯列期（小学校のお子様）、永久歯列期（中学生以上）にわけ、それぞれで抜歯ケース、非抜歯ケースでの治療例を紹介いたしております。</div>
<div style="margin-bottom:10px; padding:0 10px;">全症例数：{$all_count.0}件</div>
<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○診断別</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px;">
{foreach from=$shindan key="key" item="row"}
<div style="margin-bottom:3px;"><img src="/m/img/icon_01.gif" alt="" width="13" height="13" style="margin:0 4px; vertical-align:middle;" /><a href="shindan.php?id={$row.id}&car=mb">{$row.name} ({$shindan_count.$key})</a></div>
{/foreach}
</div>
<h2 style="margin:0; padding:0 10px; "><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○年代別</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px;">
{foreach from=$nendai key="key" item="row"}
<div style="margin-bottom:3px;"><img src="/m/img/icon_01.gif" alt="" width="13" height="13" style="margin:0 4px; vertical-align:middle;" /><a href="nendai.php?id={$row.id}&car=mb">{$row.name} ({$nendai_count.$key})</a></div>
{/foreach}
</div>
<h2 style="margin:0; padding:0 10px; "><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○その他</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px; padding:0 10px;">
<form method="get" action="search_result.php" style="margin-bottom:10px;">
<input type="hidden" name="car" value="mb">
<select name="side_others">
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
<input type="submit" value="検索" />
</form>
</div>
<h2 style="margin:0; padding:0 10px; "><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○フリーワード検索</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px; padding:0 10px;">
<form method="get" action="search_result.php" style="margin-bottom:10px;">
<input name="freeword" type="text" class="text_box" value="" size="28">
<input type="hidden" name="car" value="mb">
<input type="hidden" name="s_con" value="AND">
<input type="submit" value="検索">
</form>
</div>
<!--/CONTENTS-->
</div>
<!--FOOTER-->
{include file="{$smarty.const._SITE_ROOT}m/ssi/footer_case.html"}
<!--/FOOTER-->
</div>
<!--/WRAP-->
</body>
</html>