{include file="{$smarty.const._SITE_ROOT}case/admin/include/html_header.inc"}
</head>
<body>
<!--[HEADER]-->
{include file="{$smarty.const._SITE_ROOT}case/admin/include/header.inc"}
<!--/[HEADER]-->
<div id="contents"> 
 <!--[TOPICPATH]-->
 <div id="topicpath">
 <p>記事の追加・編集 ＞ 
  {if $edit_id}
  <a href="index.php">記事の一覧・編集</a> ＞ <a href="kiji_edit.php?id={$edit_id}">ID：{$edit_id}　の記事編集</a> ＞ <strong>症例画像の編集</strong>
  {else}
  	<a href="{$backurl}">記事の新規追加</a> ＞ <strong>症例画像の登録</strong>
  {/if}
  </p>
 </div>
 <!--/[TOPICPATH]--> 
 <!--[CONTENTS]-->
 {*
 {foreach from=$session key="key" item="value"}
 <p>{$key} = {$value}</p>
 {/foreach}
 *}
  <h2 class="htype01" id="photo_patient">患者さんの写真</h2>
	  <div class="indent">
	 <div class="uploadimg">
		  <ul class="clearfix heading">
		   <li>
		    <form action="#" method="post" enctype="multipart/form-data">
		     <dl>
		      <dt>
		       <div class="fileinputs">
		        <input type="file" name="photo_patient" class="file" />
		        <input type="hidden" name="delete" value="photo_patient" />
		        <div class="fakefile">
		         <input class="inputfake" />
		         <img src="img/btn_sansho.gif" width="45" height="23" alt="選択" /></div>
		       </div>
		      </dt>
		      <dd><a href="#" class="upload_btn"><img src="img/btn_upload.gif" width="100" height="23" alt="アップロード"></a></dd>
		      {if $session.photo_patient}
		      <dd class="upimage"><img src="../{$session.photo_patient}_thumb.jpg" width="180" height="120" alt=""></dd>
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
  </div>
 <h2 class="htype01" id="photo_header">症例画像　見出し用</h2>
 <div class="uploadimg">
  <ul class="clearfix heading">
   <li>
    <form action="#" method="post" enctype="multipart/form-data">
     <dl>
      <dt>
       <div class="fileinputs">
        <input type="file" name="photo_header" class="file" />
        <input type="hidden" name="delete" value="photo_header" />
        <div class="fakefile">
         <input class="inputfake" />
         <img src="img/btn_sansho.gif" width="45" height="23" alt="選択" /></div>
       </div>
      </dt>
      <dd><a href="#" class="upload_btn"><img src="img/btn_upload.gif" width="100" height="23" alt="アップロード"></a></dd>
      {if $session.photo_header}
      <dd class="upimage"><img src="../{$session.photo_header}_thumb.jpg" width="180" height="120" alt=""></dd>
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
 {foreach from=$photo item="val"}
 <h2 class="htype01" id="{$val.title.name}">症例画像　{$val.title.header}</h2>
 <div class="uploadimg">
  <ul class="clearfix chiryo">
  {foreach from=$val.nmb item="nmb"}
  {$form_nmb = $nmb - 1}
  {$name = $val.title.name|cat:"-"|cat:$form_nmb}
   <li>
    <form action="#" method="post" enctype="multipart/form-data">
     <dl>
      <dt class="nmb">{$nmb}.</dt>
      <dd>
       <div class="fileinputs">
        <input type="file" name="{$name}" class="file" />
        <input type="hidden" name="delete" value="{$name}" />
        <div class="fakefile">
         <input class="inputfake" />
         <img src="img/btn_sansho.gif" width="45" height="23" alt="選択" /> </div>
       </div>
      </dd>
      <dd><a href="#" class="upload_btn"><img src="img/btn_upload.gif" width="100" height="23" alt="アップロード"></a></dd>
      {$session_name = $val.title.name}
      {if $session.$session_name.$form_nmb}
      <dd class="upimage"><img src="../{$session.$session_name.$form_nmb}_thumb.jpg" width="156" height="104" alt=""></dd>
      {else}
      <dd class="upimage"><img src="{$smarty.const._PHOTO_DUMMY}.gif" width="156" height="104" alt=""></dd>
      {/if}
      <dd class="delete"><a href="#" class="photo_delete_btn"><img src="img/btn_photo_delete.gif" width="90" height="24" alt="削除する"></a></dd>
      <dd class="msg"></dd>
     </dl>
    </form>
   </li>
   {/foreach}
  </ul>
 </div>
 {/foreach}
  <div class="submit">
  	<a href="kiji_confirm.php"><img src="img/btn_confirm.gif" width="145" height="31" alt="確認画面へ"></a>
{if $edit_id}
	{$backurl = 'kiji_edit.php?id='|cat:$edit_id}
{else}
	{$backurl = 'kiji_edit.php'}
{/if}
   <div class="backstep"><a href="{$backurl}"><img src="img/btn_back.gif" width="71" height="24" alt="戻る" /></a></div>
  </div>
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
 <p>記事の追加・編集 ＞ 
  {if $edit_id}
  <a href="index.php">記事の一覧・編集</a> ＞ <a href="kiji_edit.php?id={$edit_id}">「{$session.age}歳　{$session.sex}{$session.sex_ex}」 の記事編集</a> ＞ <strong>症例画像の編集</strong>
  {else}
  	<a href="{$backurl}">記事の新規追加</a> ＞ <strong>症例画像の登録</strong>
  {/if}
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
