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
  {if $edit_id}
  <a href="bunrui_index.php?bid={$bid}">{$bunrui_name}一覧</a> ＞ <strong>ID：{$edit_id}　の{$bunrui_name}編集</strong>
  {else}
  <strong>{$bunrui_name}の新規作成</strong>
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
 <div class="uploadimg">
  <ul class="clearfix heading">
   <li>
    <form action="#" method="post" enctype="multipart/form-data">
     <dl>
      <dt>
       <div class="fileinputs">
        <input type="file" name="photo_header" class="file" />
        <input type="hidden" name="session_name" value="{$smarty.const._SESSION_BUNRUI}" />
        <input type="hidden" name="delete" value="photo_header" />
        <input type="hidden" name="updir" value="category" />
        <div class="fakefile">
         <input class="inputfake" />
         <img src="img/btn_sansho.gif" width="45" height="23" alt="選択" /></div>
       </div>
      </dt>
      <dd><a href="#" class="upload_btn"><img src="img/btn_upload.gif" width="100" height="23" alt="アップロード"></a></dd>
      {if $data.photo_header}
      <dd class="upimage"><img src="../{$data.photo_header}_thumb.jpg" width="180" height="120" alt=""></dd>
      {else}
      <dd class="upimage"><img src="{$smarty.const._PHOTO_HEADER_DUMMY}.gif" width="180" height="120" alt=""></dd>
      {/if}
      <dd class="delete"><a href="#" class="photo_delete_btn"><img src="img/btn_photo_delete.gif" width="90" height="24" alt="削除する"></a></dd>
      <dd class="msg"></dd>
     </dl>
   </form>
   </li>
  </ul>
 </div>
 <form method="post" action="bunrui_confirm.php" id="{$bid}_edit">
 {if $edit_id}
 	{$mode = 'update_bunrui'}
 {else}
 	{$mode = 'regist_bunrui'}
 	<h2 class="htype01">診断名ID</h2>
 	<div class="indent">
  	<select name="id">
   {foreach from=$bunrui_id_options item="options"}
   {$options}
   {/foreach}
   </select>
 	</div>
 {/if}
    <input type="hidden" name="mode" value="{$mode}" />
 <div class="column3">
  <ul class="clearfix">
   <li>
    <h2 class="htype01">診断名</h2>
    <div class="indent">
     <input type="text" name="name" class="text w01" value="{$data.name}" />
    <p class="error" htmlfor="name">診断名を入力してください。</p>
    </div>
   </li>
   <li>
    <h2 class="htype01">診断名　別名</h2>
    <div class="indent">
     <input type="text" name="alias" class="text w01" value="{$data.alias}" />
    </div>
   </li>
   <li>
    <h2 class="htype01">ディレクトリ名</h2>
    <div class="indent">
     <input type="text" name="dir" class="text w01" value="{$data.dir}" />
    <p class="error" htmlfor="dir">ディレクトリ名を入力してください。<br>
（半角英数字のみ）</p>
    </div>
   </li>
  </ul>
 </div>
 <h2 class="htype01">診断の説明</h2>
 <div class="indent">
  <textarea class="type01" name="explanation">{$data.explanation}</textarea>
    <p class="error" htmlfor="explanation">診断の説明を入力してください。</p>
 </div>
 <h2 class="htype01">診断の説明　（症例紹介トップページ用）</h2>
 <div class="indent">
  <textarea class="type01" name="explanation_short">{$data.explanation_short}</textarea>
    <p class="error" htmlfor="explanation_short">診断の説明　（症例紹介トップページ用）を入力してください。</p>
 </div>
 <h2 class="htype01">関連リンク</h2>
 <div class="relateLink">
 <dl>
 <dt class="header">タイトル</dt>
 <dd class="header">URL</dd>
 {foreach from=$data.related_title key="key" item="val"}
 <dt><input type="text" name="related_title[]" class="text" value="{$val}" /></dt>
 <dd><input type="text" name="related_url[]" class="text" value="{$data.related_url.$key}" /></dd>
 {/foreach}
 <dt><input type="text" name="related_title[]" class="text" value="" /></dt>
 <dd><input type="text" name="related_url[]" class="text" value="" /></dd>
 </dl>
 <div class="btn_right"><a href="#" class="add_relatedLink"><img src="img/btn_add_waku.gif" width="109" height="23" alt="入力枠を追加"></a></div>
 </div>
 <!-- /[[shindan]] -->
 {elseif $bid eq 'nendai'}
 <!-- [[nendai]] -->
 <form method="post" action="bunrui_confirm.php" id="{$bid}_edit">
 {if $edit_id}
 	{$mode = 'update_bunrui'}
 {else}
 	{$mode = 'regist_bunrui'}
 	<h2 class="htype01">年代名ID</h2>
 	<div class="indent">
  	<select name="id">
   {foreach from=$bunrui_id_options item="options"}
   {$options}
   {/foreach}
   </select>
 	</div>
 {/if}
    <input type="hidden" name="mode" value="{$mode}" />
 <div class="column3">
  <ul class="clearfix">
   <li>
    <h2 class="htype01">年代名</h2>
    <div class="indent">
     <input type="text" class="text w01" name="name" value="{$data.name}" />
     <p class="error" htmlfor="name">年代名を入力してください。</p>
    </div>
   </li>
   <li>
    <h2 class="htype01">年齢層</h2>
    <div class="indent">
      <select name="generation[]">
      {foreach from=$age_option item="age"}
   	{if $age eq $data.generation.0}
   		{$selected = {$smarty.const._SELECTED_CODE}}
   	{else}
   		{$selected = ""}
   	{/if}
      <option value="{$age}"{$selected}>{$age}</option>
      {/foreach}
      </select>
      歳～
      <select name="generation[]">
      {foreach from=$age_option item="age"}
   	{if $age eq $data.generation.1}
   		{$selected = {$smarty.const._SELECTED_CODE}}
   	{else}
   		{$selected = ""}
   	{/if}
      <option value="{$age}"{$selected}>{$age}</option>
      {/foreach}
      </select>
      歳
    </div>
   </li>
  </ul>
 </div>
 <h2 class="htype01">年代の説明</h2>
 <div class="indent">
  <textarea class="type01" name="explanation">{$data.explanation}</textarea>
  <p class="error" htmlfor="explanation">年代の説明を入力してください。</p>
 </div>
 <!-- /[[nendai]] -->
 {else}
 <!-- [[others]] -->
 <form method="post" action="bunrui_confirm.php" id="others_edit">
 {if $edit_id}
 	{$mode = 'update_bunrui'}
 {else}
 	{$mode = 'regist_bunrui'}
 	<h2 class="htype01">{$bunrui_name}名ID</h2>
 	<div class="indent">
  	<select name="id">
   {foreach from=$bunrui_id_options item="options"}
   {$options}
   {/foreach}
   </select>
 	</div>
 {/if}
    <input type="hidden" name="mode" value="{$mode}" />
 <h2 class="htype01">{$bunrui_name}名</h2>
 <div class="indent">
 <input type="text" class="text w01" name="name" value="{$data.name}" />
 <p class="error" htmlfor="name">{$bunrui_name}名を入力してください。</p>
 </div>
 <!-- /[[others]] -->
 {/if}
  <div class="submit">
   <input name="imageField" type="image" id="imageField" src="img/btn_confirm.gif" alt="確認画面へ" />
   <div class="backstep"><a href="bunrui_index.php?bid={$bid}"><img src="img/btn_back.gif" width="71" height="24" alt="戻る" /></a></div>
  </div>
 </form>
 {if $edit_id}
 <form action="process_bunrui.php" method="post" class="delete_bunrui">
  <div class="submit delete">
   <input name="imageField" type="image" id="imageField" src="img/btn_koumoku_delete.gif" alt="項目を削除する" />
   <input type="hidden" name="mode" value="delete_bunrui" />
   <input type="hidden" name="id" value="{$edit_id}" />
  </div>
 </form>
 {/if}
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
  {if $edit_id}
  <a href="index.php">{$bunrui_name}の一覧・編集</a> ＞ <strong>ID：{$edit_id}　の{$bunrui_name}編集</strong>
  {else}
  <strong>{$bunrui_name}の新規作成</strong>
  {/if}
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
