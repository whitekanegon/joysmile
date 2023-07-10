<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ja" xml:lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>症例検索｜矯正歯科 大阪【ほてい矯正歯科】</title>
<meta name="description" content="症例を検索できます。矯正歯科 大阪(堺・千里)の歯列矯正なら「ほてい矯正歯科」" />
<meta name="keywords" content=",症例,矯正,歯科,大阪,堺,千里,歯列,治療" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<link rel="shortcut icon" href="/common/img/favicon.ico" />
<link rel="stylesheet" href="/fb/lib/css/import.css" type="text/css" media="screen, all" />
{literal}
<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
<script language="JavaScript">
FB.init({
    appId: '238025452906942',
    status: true,
    cookie: true,
    xfbml: true
});
window.fbAsyncInit = function() {
  FB.Canvas.setSize();
}
function sizeChangeCallback() {
  FB.Canvas.setSize();
}
</script>
<script type="text/javascript" src="/fb/lib/js/common.js"></script>
{/literal}
</head>
<body>
<div id="fb-root"></div>
{literal}
<script>
  FB.Canvas.setSize({ width: 520, height: 2000 });
</script> 
{/literal}
<!-- [CONTAINER] -->
<div id="container">
	<div id="contents"> 
		<!-- [CONTENTS] --> 
   <!--[cont_header]-->
   <h1 class="pageTitle"><img src="/fb/lib/img/t_case.gif" alt="症例カスタム検索" width="520" height="40" /></h1>
   <!--/[cont_header]-->
   <h2 class="htypeToggle">フリーワード検索</h2>
   <div class="indent toggleChild">
   <form method="get" action="search_result.php" name="search_word" target="_blank">
   <div class="freeword clearfix">
   <input type="text" name="freeword" value="" class="text w01" />
   <input type="image" src="img/btn_case_search_small.gif" alt="検索" />
<ul class="con clearfix b_m0">
<li><label for="s_con_and"><input type="radio" name="s_con" value="AND" id="s_con_and" checked="checked" />AND</label></li>
<li><label for="s_con_or"><input type="radio" name="s_con" value="OR" id="s_con_or" />OR</label></li>
</ul>
   </div>
   </form>
   </div>
   <h2 class="htypeToggle">分類項目を指定して検索</h2>
			<div class="toggleChild">
			<div class="submit">
			<p class="submit"><a href="#" onclick="document.search_item.submit(); return false;">検索</a></p>
    <p class="checkoff"><a href="#" onclick="document.search_item.reset(); return false;"><img src="/fb/lib/img/btn_checkoff.gif" alt="チェックを全てはずす" width="105" height="19" /></a></p>
				</div>
  <form method="get" action="search_result.php" name="search_item" class="search_item" target="_blank">
   <h3 class="htype01">診断名</h3>
   <ul class="shindan_photo clearfix fixHeight">
   {foreach from=$data.shindan item="value"}
			{if $value.id != "10" && $value.id != "11" && $value.id != "12"}
    <li>
      <input type="checkbox" value="{$value.id}" name="shindan[]" id="shindan{$value.id}" />
						<label for="shindan{$value.id}">
						<span class="photo"><img src="{$value.photo_header}.jpg" alt="{$value.name}" width="100" height="66" /></span>
						<span>{$value.name}</span>
						</label>
						<div class="ex">
						<dl>
						<dt>{$value.name}</dt>
						<dd>{$value.explanation_short}</dd>
						</dl>
						<div class="btm"></div>
						</div>
    </li>
				{/if}
   {/foreach}
   </ul>
   <h3 class="htype01">歯列</h3>
   <div class="indent">
     <ul class="koumoku clearfix">
   {foreach from=$data.shiretsu item="value"}
    <li>
      <label for="shiretsu{$value.id}">
       <input name="shiretsu[]" type="checkbox" id="shiretsu{$value.id}" value="{$value.id}" />
       {$value.name}</label>
      </li>
   {/foreach}
   </ul>
   </div>
   <h3 class="htype01">治療方針</h3>
   <div class="indent">
     <ul class="koumoku clearfix">
   {foreach from=$data.basshi item="value"}
    <li>
      <label for="basshi{$value.id}">
       <input name="basshi[]" type="checkbox" id="basshi{$value.id}" value="{$value.id}" />
       {$value.name}</label>
      </li>
   {/foreach}
   </ul>
   </div>
   <h3 class="htype01">年代</h3>
   <div class="indent">
     <ul class="koumoku02 clearfix">
   {foreach from=$data.nendai item="value"}
    <li>
      <label for="nendai{$value.id}">
       <input name="nendai[]" type="checkbox" id="nendai{$value.id}" value="{$value.id}" />
       {$value.name}</label>
      </li>
   {/foreach}
   </ul>
   </div>
   <h3 class="htype01">性別</h3>
   <div class="indent">
     <ul class="koumoku02 clearfix">
     <li>
      <label for="male">
       <input name="sex" type="radio" id="male" value="男" />
       男性</label>
      </li>
      <li>
      <label for="female">
       <input name="sex" type="radio" id="female" value="女" />
       女性 </label>
      </li>
    <li>
      <label for="sex_noselect">
       <input name="sex" type="radio" id="sex_noselect" value="" />
       指定しない</label>
      </li>
    </ul>
   </div>
   <h3 class="htype01">装置</h3>
   <div class="indent">
   <ul class="souchi clearfix fixHeight">
   {foreach from=$data.souchi item="value"}
    <li>
     <label for="souchi{$value.id}">
      <input type="checkbox" value="{$value.id}" name="souchi[]" id="souchi{$value.id}"{$checked} />
      {$value.name}</label>
     </li>
   {/foreach}
   </ul>
   </div>
   <h3 class="htype01">担当医</h3>
   <div class="indent">
     <ul class="koumoku clearfix">
   {foreach from=$data.tantou item="value"}
    <li>
      <label for="tantou{$value.id}">
       <input name="tantou[]" type="checkbox" id="tantou{$value.id}" value="{$value.id}" />
       {$value.name}</label>
      </li>
   {/foreach}
   </ul>
   </div>
   <h3 class="htype01">患者さんの感想</h3>
   <div class="indent b_m0">
     <ul class="koumoku02 clearfix">
    <li>
      <label for="kansou_yes">
       <input name="kansou" type="radio" id="kansou_yes" value="あり" />
       あり</label>
      </li>
    <li>
      <label for="kansou_no">
       <input name="kansou" type="radio" id="kansou_no" value="なし" />
       なし</label>
      </li>
    <li>
      <label for="kansou_noselect">
       <input name="kansou" type="radio" id="kansou_noselect" value="" />
       指定しない</label>
      </li>
   </ul>
   </div>
  </form>
			<div class="submit bottom">
			<p class="submit"><a href="#" onclick="document.search_item.submit(); return false;">検索</a></p>
    <p class="checkoff"><a href="#" onclick="document.search_item.reset(); return false;"><img src="/fb/lib/img/btn_checkoff.gif" alt="チェックを全てはずす" width="105" height="19" /></a></p>
				</div>
		</div>
		<!-- [CONTENTS] --> 
	</div>
</div>
<!-- [CONTAINER] -->
</body>
</html>
