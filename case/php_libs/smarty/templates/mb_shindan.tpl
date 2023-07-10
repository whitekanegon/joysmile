<?xml version="1.0" encoding="{$charset}"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ja" xml:lang="ja">
<head>
<meta http-equiv="content-Type" content="application/xhtml+xml; charset={$charset}" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>{$data.name}｜症例紹介｜矯正歯科 大阪【ほてい矯正歯科】</title>
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
<h1 style="color:#000; line-height:1em; margin-bottom:0; padding:0 10px; background:#FFF;"><span style="font-size:small;font-weight:normal;">{$data.name}</span></h1>
<div style="padding:0 0 10px;background:#EFEFEF;"><img src="/m/img/line_s01.jpg" alt="" width="240" height="11" /></div>
<div style="background:#EFEFEF;margin-bottom:10px; padding:10px 0 10px 0;">
<!--CONTENTS-->
<div style="text-align:center; margin-bottom:10px;"><img src="{$data.photo_header}.jpg" width="180" height="120" alt=""></div>
<div style="margin-bottom:10px; padding:0 10px;">{$data.explanation}</div>
<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○症例</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:10px; padding:0 10px;">尚、患者さんから治療についてのコメントをいただけたものは、★印が付いております。</div>
   {foreach from=$shindan_cate key="key" item="row_cate"}
<div style="margin-bottom:10px; padding:0 10px;">
   {if $row_cate}
    <div><strong>【{$category_title.$key}】</strong></div>
       {foreach from=$row_cate item="row" name="shindan"}
       <a href="detail.php?id={$row.id}&car=mb" style="line-height:1.8;">{$row.kansou_mark}{$row.age}歳 {$row.sex}{$row.sex_ex}</a>{if $smarty.foreach.shindan.last}{else}{if $smarty.foreach.shindan.index % 2 == 0} ／{else}<br />{/if}{/if}
       {/foreach}
    {/if}
</div>
    {/foreach}
<div style="padding-top:10px"><img src="/m/img/line_s02.gif" alt="" width="240" height="11" /></div>
<img src="/m/img/icon_04.gif" alt="" width="13" height="8" style="margin:0 4px; vertical-align:middle;" /><a href="/case/?car=mb">症例ﾄｯﾌﾟに戻る</a>
<!--/CONTENTS-->
</div>
<!--FOOTER-->
{include file="{$smarty.const._SITE_ROOT}m/ssi/footer_case.html"}
<!--/FOOTER-->
</div>
<!--/WRAP-->
</body>
</html>