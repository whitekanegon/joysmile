{include file="{$smarty.const._SITE_ROOT}case/admin/include/html_header.inc"}
</head>
<body>
<!--[HEADER]-->
{include file="{$smarty.const._SITE_ROOT}case/admin/include/header.inc"}
<!--/[HEADER]-->
<div id="contents"> 
 <!--[TOPICPATH]-->
 <div id="topicpath">
  <p>分類項目の一覧・編集 ＞ 
  {if $session.mode eq 'update_bunrui'}
  <a href="bunrui_index.php?bid={$bid}">{$bunrui_name}の一覧・編集</a> ＞ <a href="bunrui_edit.php?id={$session.edit_id}">ID：{$session.edit_id}　の{$bunrui_name}編集</a> ＞ <strong>登録内容確認</strong>
  {else}
  <a href="bunrui_edit.php">{$bunrui_name}の新規作成</a> ＞ <strong>登録内容確認</strong>
  {/if}
  </p>
 </div>
 <!--/[TOPICPATH]--> 
 <!--[CONTENTS]-->
 {* !for check
 <p>session_name = {$session_name}</p>
 {foreach from=$session_real key="key" item="value"}
 <p>{$key} = {$value}</p>
 {/foreach}
 *}
 {if $bid eq 'shindan'}
 <!-- [[shindan]] -->
 <h2 class="htype01">診断画像</h2>
 <div class="uploadimg confirm">
  <ul class="clearfix heading">
   {if $session.photo_header}
   <li><img src="../{$session.photo_header}_thumb.jpg" width="180" height="120" /></li>
   {else}
   <li><img src="{$smarty.const._PHOTO_HEADER_DUMMY}.gif" width="180" height="120" /></li>
   {/if}
  </ul>
 </div>
 <h2 class="htype01">基本項目</h2>
 <div class="indent">
  <table border="0" cellspacing="0" cellpadding="0" class="type01 kihon">
  {if $session.id}
    <tr>
    <th class="left">診断名ID</th>
    <td>{$session.id}</td>
   </tr>
   {/if}
  <tr>
    <th class="left">診断名</th>
    <td>{$session.name}</td>
   </tr>
   <tr>
    <th class="left">診断名　別名</th>
    <td>{$session.alias}</td>
   </tr>
   <tr>
    <th class="left">ディレクトリ名</th>
    <td>{$session.dir}</td>
   </tr>
   <tr>
    <th class="left">診断の説明</th>
    <td>{$session.explanation}</td>
   </tr>
   <tr>
    <th class="left">診断の説明<br />
（トップページ用）</th>
    <td>{$session.explanation_short}</td>
   </tr>
   <tr>
    <th class="left">関連リンク</th>
    <td>
    <ul class="arrowLink">
 {foreach from=$session.related_title key="key" item="val"}
 {if $val}
    <li><a href="{$session.related_url.$key}" target="_blank">{$val}</a></li>
    {/if}
    {/foreach}
    </ul>
    </td>
   </tr>
  </table>
 </div>
 <!-- /[[shindan]] -->
 {elseif $bid eq 'nendai'}
 <!-- [[nendai]] -->
 <h2 class="htype01">登録内容確認</h2>
 <div class="indent">
  <table border="0" cellspacing="0" cellpadding="0" class="type01 kihon">
  {if $session.id}
    <tr>
    <th class="left">年代名ID</th>
    <td>{$session.id}</td>
   </tr>
   {/if}
   <tr>
    <th class="left">年代名</th>
    <td>{$session.name}</td>
   </tr>
   <tr>
    <th class="left">年齢層</th>
    <td>{$session.generation.0}～{$session.generation.1}歳</td>
   </tr>
   <tr>
    <th class="left">年代の説明</th>
    <td>{$session.explanation}</td>
   </tr>
  </table>
 </div>
 {else}
 <!-- [[ohters]] -->
 <h2 class="htype01">登録内容確認</h2>
 <div class="indent">
  <table border="0" cellspacing="0" cellpadding="0" class="type01 kihon">
  {if $session.id}
    <tr>
    <th class="left">{$bunrui_name}名ID</th>
    <td>{$session.id}</td>
   </tr>
   {/if}
   <tr>
    <th class="left">{$bunrui_name}名</th>
    <td>{$session.name}</td>
   </tr>
  </table>
 </div>
 <!-- /[[ohters]] -->
 {/if}
  <div class="submit">
  {if $session.mode eq 'update_bunrui'}
  	<a href="process_bunrui.php"><img src="img/btn_update.gif" width="145" height="31" alt="編集を適用する"></a>
   <div class="backstep"><a href="bunrui_edit.php?id={$session.edit_id}"><img src="img/btn_back.gif" width="71" height="24" alt="戻る" /></a></div>
  {else}
  	<a href="process_bunrui.php"><img src="img/btn_tsuika_koumoku.gif" width="145" height="31" alt="項目を追加する"></a>
   <div class="backstep"><a href="bunrui_edit.php"><img src="img/btn_back.gif" width="71" height="24" alt="戻る" /></a></div>
  {/if}
</div>
   <div class="submit delete"><a href="bunrui_index.php?bid={$bid}"><img src="img/btn_edit_cancel.gif" width="145" height="31" alt="編集を取り消す" /></a></div>

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
  {if $session.mode eq 'update_bunrui'}
  <a href="bunrui_index.php?bid={$bid}">{$bunrui_name}の一覧・編集</a> ＞ <a href="bunrui_edit.php?id={$session.edit_id}">ID：{$edit_id}　の{$bunrui_name}編集</a> ＞ <strong>登録内容確認</strong>
  {else}
  <a href="bunrui_edit.php">{$bunrui_name}の新規作成</a> ＞ <strong>登録内容確認</strong>
  {/if}
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
