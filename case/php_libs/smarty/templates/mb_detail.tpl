<?xml version="1.0" encoding="{$charset}"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ja" xml:lang="ja">
<head>
<meta http-equiv="content-Type" content="application/xhtml+xml; charset={$charset}" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>{$data.kansou_mark}{$data.age}歳　{$data.sex}{$data.sex_ex}　{$data.shiretsu}　{$data.basshi}｜症例紹介｜矯正歯科 大阪【ほてい矯正歯科】</title>
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
<h1 style="color:#000; margin-bottom:10px; padding:0 10px; background:#FFF;"><span style="font-size:small;font-weight:normal;">{$data.kansou_mark}{$data.age}歳　{$data.sex}{$data.sex_ex}　{$data.shiretsu}　{$data.basshi}{if $data.basshi_bui}<br />（抜歯部位：{$data.basshi_bui}）{/if}</span></h1>
<div style="padding:0 0 10px;background:#EFEFEF;"><img src="/m/img/line_s01.jpg" alt="" width="240" height="11" /></div>
<div style="background:#EFEFEF;margin-bottom:10px; padding:10px 0 10px 0;">
<!--CONTENTS-->
<div style="margin-bottom:10px; text-align:center;">
			<div>{$data.shindan}</div>
   {if $data.shindan_sub}
   {foreach from=$data.shindan_sub item="val"}
   <div>《{$val}》</div>
   {/foreach}
   {/if}
			</div>
<div style="text-align:center; margin-bottom:10px;"><img src="{$data.photo_header}_thumb.jpg" width="180" height="120" alt=""></div>
<div style="margin-bottom:15px; padding:0 10px;">Case{$data.case_num}<br>
{$data.thisinfo}</div>

{if $data.kansou}
<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○患者さんからの感想</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px; padding:0 10px;">{$data.kansou}</div>
{/if}

{if $data.comment}
<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○クリニックコメント</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px; padding:0 10px;">{$data.comment}</div>
{/if}

{if $data.souchi}
<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○装置</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px; padding:0 10px;">
   {foreach from=$data.souchi item="val"}
   <div>･{$val}</div>
   {/foreach}
</div>
{/if}

{if $data.tantou}
<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○担当医</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="margin-bottom:15px; padding:0 10px;">
   {foreach from=$data.tantou item="val"}
   <div>･{$val}</div>
   {/foreach}
</div>
{/if}

<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○症例画像</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<table cellspacing="0" cellpadding="0" border="0" style="margin:0 0 10px 10px;">
   {foreach from=$photo item="status" name="photo"}
   {$photo_name = $status.title.name}
   {if $data.$photo_name.0}
			<tr>
   	<th colspan="2" style="text-align:left; padding-bottom:4px;">【{$status.title.header}】</th>
				</tr>
				<tr>
     {foreach from=$data.$photo_name key="key" item="photo_path" name="photo"}
					{if $smarty.foreach.photo.index < 2}
     {if $photo_path}
     	<td style="padding:0 8px 8px 0;"><img src="{$photo_path}_thumb.jpg" width="105" height="70" alt="" /></td>
      {/if}
						{/if}
     {/foreach}
    	</tr>
   {/if}
   {/foreach}
</table>

   {if $related_count > 1}
<h2 style="margin:0; padding:0 10px;"><span style="font-size:small;font-weight:normal; margin:0;line-height:1em; color:#FF0066;">○【{$data.shindan}】{if $nendai_name} 【{$nendai_name}】{/if}その他の症例</span></h2>
<img src="/m/img/line_s02.gif" alt="" width="240" height="11" />
<div style="padding:0 10px;">
   {foreach from=$related_data item="row"}
   {if $row.id != $main_id}
    <div style="margin-bottom:3px;">･<a href="detail.php?id={$row.id}&car=mb">{$row.kansou_mark}{$row.age}歳 {$row.sex}{$row.sex_ex} {$row.shiretsu} {$row.basshi}</a></div>
    {/if}
    {/foreach}
   {/if}
</div>

<div style="padding-top:10px"><img src="/m/img/line_s02.gif" alt="" width="240" height="11" /></div>
<img src="/m/img/icon_04.gif" alt="" width="13" height="8" style="margin:0 4px; vertical-align:middle;" />
{if $nendai_id}
<a href="/case/nendai.php?id={$nendai_id}&car=mb">{$nendai_name} ﾄｯﾌﾟに戻る</a>
{else}
<a href="/case/shindan.php?id={$shindan_id}&car=mb">{$data.shindan} ﾄｯﾌﾟに戻る</a>
{/if}
<!--/CONTENTS-->
</div>
<!--FOOTER-->
{include file="{$smarty.const._SITE_ROOT}m/ssi/footer_case.html"}
<!--/FOOTER-->
</div>
<!--/WRAP-->
</body>
</html>