{include file="{$smarty.const._SITE_ROOT}case/admin/include/html_header.inc"}
<script type="text/javascript" src="/case/js/jquery.lightbox_cross.js" charset="utf-8"></script>
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
  <a href="index.php">記事の一覧・編集</a> ＞ <strong>ID：{$edit_id}　の記事詳細</strong>
  {elseif $session.mode eq 'update'}
  <a href="index.php">記事の一覧・編集</a> ＞ <a href="kiji_edit.php?id={$session.edit_id}">ID：{$session.edit_id}　の記事編集</a> ＞ <a href="kiji_img.php">症例画像の編集</a> ＞ <strong>登録内容確認</strong>
  {else}
  <a href="kiji_edit.php">記事の新規追加</a> ＞ <a href="kiji_img.php">症例画像の登録</a> ＞ <strong>登録内容確認</strong></p>
  {/if}
  </p>
 </div>
 <!--/[TOPICPATH]--> 
 <!--[CONTENTS]-->
 {*
 {foreach from=$session_real key="key" item="value"}
 <p>{$key} = {$value}</p>
 {/foreach}
 *}
	{if $edit_id}
	<p class="preview"><a href="/case/detail.php?id={$edit_id}" target="_blank">⇒ 表示画面を確認する</a></p>
	{/if}
 <h2 class="htype01" id="img_heading">基本項目</h2>
 <div class="indent">
  <table border="0" cellspacing="0" cellpadding="0" class="type01 kihon">
   <tr>
    <th scope="row">治療区分</th>
   	{if $session.kubun eq 1}
   		<td>前期のみ</td>
   	{else}
   		<td>－</td>
   	{/if}
   </tr>
   <tr>
    <th scope="row">年齢</th>
    <td>{$session.age}歳</td>
   </tr>
   <tr>
    <th scope="row">性別</th>
    <td>{$session.sex}{{$session.sex_ex}}</td>
   </tr>
   <tr>
    <th scope="row">歯列</th>
    <td>{$session.shiretsu}</td>
   </tr>
   <tr>
    <th scope="row">抜歯</th>
    <td>{$session.basshi}</td>
   </tr>
   <tr>
    <th scope="row">抜歯部位</th>
    <td>{$session.basshi_bui}</td>
   </tr>
   <tr>
    <th scope="row">診断名　メイン</th>
    <td>{$session.shindan}</td>
   </tr>
   <tr>
    <th scope="row">診断名　サブ</th>
    <td>{$session.shindan_sub}</td>
   </tr>
   <tr>
    <th scope="row">装置</th>
    <td>{$session.souchi}</td>
   </tr>
   {*
   <tr>
    <th scope="row">担当医</th>
    <td>{$session.tantou}</td>
   </tr>
   *}
			<!--
   <tr>
    <th scope="row">症例ケース番号</th>
    <td>Case {$session.case_num}</td>
   </tr>
			-->
   <tr>
    <th scope="row">カルテ番号</th>
    <td>{$session.karte_num}</td>
   </tr>
   <tr>
    <th scope="row">症例の説明</th>
    <td>{$session.thisinfo}</td>
   </tr>
   <tr>
    <th scope="row">患者さんの感想</th>
    <td>{$session.kansou}</td>
   </tr>
   <tr>
    <th scope="row">クリニックコメント</th>
    <td>{$session.comment}</td>
   </tr>
   <tr>
    <th scope="row">記事公開</th>
    <td>{if $session.shitagaki}公開しない（下書き）{else}公開する{/if}</td>
   </tr>
  </table>
  {if not $edit_id}
  {if $session.mode eq 'update'}
  	{$backurl = 'kiji_edit.php?id='|cat:$session.edit_id}
  {else}
  	{$backurl = 'kiji_edit.php'}
  {/if}
  <div class="backstep"><a href="{$backurl}"><img src="img/btn_shusei.gif" width="100" height="23" alt="修正する" /></a></div>
  {/if}
 </div>
 <h2 class="htype01" id="photo_patient">患者さんの写真</h2>
 <div class="uploadimg confirm">
  <ul class="clearfix heading">
   {if $session.photo_patient}
   <li><img src="../{$session.photo_patient}_thumb.jpg" width="180" height="120" /></li>
   {else}
   <li><img src="{$smarty.const._PHOTO_HEADER_DUMMY}.gif" width="180" height="120" /></li>
   {/if}
  </ul>
  {if not $edit_id}
  <div class="backstep"><a href="kiji_img.php#photo_patient"><img src="img/btn_shusei.gif" width="100" height="23" alt="修正する" /></a></div>
  {/if}
 </div>
 <h2 class="htype01" id="photo_header">症例画像　見出し用</h2>
 <div class="uploadimg confirm">
  <ul class="clearfix heading">
   {if $session.photo_header}
   <li><img src="../{$session.photo_header}_thumb.jpg" width="180" height="120" /></li>
   {else}
   <li><img src="{$smarty.const._PHOTO_HEADER_DUMMY}.gif" width="180" height="120" /></li>
   {/if}
  </ul>
  {if not $edit_id}
  <div class="backstep"><a href="kiji_img.php#photo_header"><img src="img/btn_shusei.gif" width="100" height="23" alt="修正する" /></a></div>
  {/if}
 </div>
 {foreach from=$photo item="val"}
  {$photo_name = $val.title.name}
 <div id="{$photo_name}">
 <h2 class="htype01">症例画像　{$val.title.header}</h2>
 <div class="uploadimg">
  <ul class="clearfix chiryo">
  {foreach from=$val.nmb item="nmb" name=photo_inner}
  {$form_nmb = $nmb - 1}
  <li>
   <dl>
   <dt class="nmb">{$nmb}.</dt>
   {if $session.$photo_name.$form_nmb}
   <dd class="upimage"><a href="../{$session.$photo_name.$form_nmb}.jpg" rel="lightbox" name='{$session.crossLink.$photo_name.$form_nmb}'><img src="../{$session.$photo_name.$form_nmb}_thumb.jpg" width="156" height="104" /></a></dd>
   {else}
   <dd class="upimage"><img src="{$smarty.const._PHOTO_DUMMY}.gif" width="156" height="104" /></dd>
   {/if}
   </dl>
   </li>
  {/foreach}
  </ul>
  {if not $edit_id}
  <div class="backstep"><a href="kiji_img.php#{$photo_name}"><img src="img/btn_shusei.gif" width="100" height="23" alt="修正する" /></a></div>
  {/if}
 </div>
 </div>
 {/foreach}
  <div class="submit">
  {if $edit_id}
  {if $ikkatsu eq 1}
  	{$backurl2 = 'kiji_delelte.php'}
  {else}
  	{$backurl2 = 'index.php'}
  {/if}
  	<a href="kiji_edit.php?id={$edit_id}"><img src="img/btn_edit.gif" width="145" height="31" alt="記事を編集する"></a>
   <div class="backstep"><a href="{$backurl2}"><img src="img/btn_back.gif" width="71" height="24" alt="戻る" /></a></div>
  {elseif $session.mode eq 'update'}
  	<a href="process.php"><img src="img/btn_update.gif" width="145" height="31" alt="編集を適用する"></a>
   <div class="backstep"><a href="kiji_img.php"><img src="img/btn_back.gif" width="71" height="24" alt="戻る" /></a></div>
  {else}
  	<a href="process.php"><img src="img/btn_regist_kiji.gif" width="145" height="31" alt="記事を追加する"></a>
  {/if}
</div>
  {if !$edit_id}
   <div class="submit delete"><a href="index.php"><img src="img/btn_edit_cancel.gif" width="145" height="31" alt="編集を取り消す" /></a></div>
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
  <p>記事の追加・編集 ＞ 
  {if $edit_id}
  <a href="index.php">記事の一覧・編集</a> ＞ <strong>「{$session.age}歳　{$session.sex}{$session.sex_ex}」の記事詳細</strong>
  {elseif $session.mode eq 'update'}
  <a href="index.php">記事の一覧・編集</a> ＞ <a href="kiji_edit.php?id={$session.edit_id}">「{$session.age}歳　{$session.sex}{$session.sex_ex}」 の記事編集</a> ＞ <a href="kiji_img.php">症例画像の編集</a> ＞ <strong>登録内容確認</strong>
  {else}
  <a href="{$backurl}">記事の新規追加</a> ＞ <a href="kiji_img.php">症例画像の登録</a> ＞ <strong>登録内容確認</strong></p>
  {/if}
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
