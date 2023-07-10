{include file="{$smarty.const._SITE_ROOT}case/admin/include/html_header.inc"}
<script type="text/javascript">
{literal}
$(function(){
	$(".tablesorter").tablesorter({
		widgets: ['zebra'],
		sortList: [[0,0]]
	});
});
{/literal}
</script>
</head>
<body>
<!--[HEADER]-->
{include file="{$smarty.const._SITE_ROOT}case/admin/include/header.inc"}
<!--/[HEADER]-->
<div id="contents"> 
 <!--[TOPICPATH]-->
 <div id="topicpath">
  <p>分類項目の一覧・編集 ＞ 
  <strong>{$bunrui_name}一覧</strong>
  </p>
 </div>
 <!--/[TOPICPATH]-->
 {* !for check
 <p>session_name = {$session_name}</p>
 {foreach from=$session_real key="key" item="value"}
 <p>{$key} = {$value}</p>
 {/foreach}
 *}
 <!--[CONTENTS]--> 
 <h2 class="htype01">{$bunrui_name}一覧</h2>
 {if isset($db_msg)}
 <p class="DB_massage">{$db_msg}</p>
 {* <p>insert_id = {$insert_id}</p> *}
 {/if}
 {if $bid eq 'shindan'}
 <!-- [[shindan]] -->
 <table border="0" cellspacing="0" cellpadding="0" class="type01 tablesorter trlink">
 <thead>
 <tr>
  <th class="w_id">ID</th>
  <th>診断名</th>
  <th>診断名　別名</th>
  <th>ディレクトリ名</th>
 </tr>
 </thead>
{foreach from=$data item="val"}
{if $val.id eq $insert_id}
	<tr class="db_mark">
{else}
 <tr>
{/if}
  <th scope="row"><a href="bunrui_edit.php?id={$val.id}">{$val.id}</a></th>
  <td>{$val.name}</td>
  <td>{$val.alias}</td>
  <td>{$val.dir}</td>
  </tr>
 {/foreach}
 </table>
 <!-- /[[shindan]] -->
 {elseif $bid eq 'nendai'}
 <!-- [[nendai]] -->
  <table border="0" cellspacing="0" cellpadding="0" class="type01 tablesorter trlink">
 <thead>
 <tr>
  <th class="w_id">ID</th>
  <th>年代名</th>
  <th>年齢</th>
  </tr>
 </thead>
{foreach from=$data item="val"}
{if $val.id eq $insert_id}
	<tr class="db_mark">
{else}
 <tr>
{/if}
  <th scope="row"><a href="bunrui_edit.php?id={$val.id}">{$val.id}</a></th>
  <td>{$val.name}</td>
  <td>{$val.generation.0}～{$val.generation.1}歳</td>
  </tr>
 {/foreach}
 </table>
 <!-- /[[nendai]] -->
 {else}
 <!-- [[others]] -->
  <table border="0" cellspacing="0" cellpadding="0" class="type01 tablesorter trlink">
 <thead>
 <tr>
  <th class="w_id">ID</th>
  <th>{$bunrui_name}名</th>
  </tr>
 </thead>
{foreach from=$data item="val"}
{if $val.id eq $insert_id}
	<tr class="db_mark">
{else}
 <tr>
{/if}
  <th scope="row"><a href="bunrui_edit.php?id={$val.id}">{$val.id}</a></th>
  <td>{$val.name}</td>
  </tr>
 {/foreach}
 </table>
 <!-- /[[others]] -->
 {/if}
 <div class="btn_right"><a href="bunrui_edit.php?mode=regist_bunrui"><img src="img/btn_tsuika_koumoku.gif" width="145" height="31" alt="項目を追加する"></a></div>
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
  <p>分類項目の一覧・編集 ＞ 
  <strong>{$bunrui_name}一覧</strong>
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
