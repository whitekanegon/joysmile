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
  <a href="index.php">記事の一覧・編集</a> ＞ <strong>ID：{$edit_id}　の記事編集</strong>
  {else}
  <strong>記事の新規追加</strong>
  {/if}
  </p>
 </div>
 <!--/[TOPICPATH]--> 
 <!--[CONTENTS]-->
 {* !for check
 {foreach from=$session key="key" item="value"}
 <p>{$key} = {$value}</p>
 {/foreach}
 *}
 <form method="post" action="kiji_img.php" id="kiji_edit">
 {if $edit_id}
 	{$mode = 'update'}
 {else}
 	{$mode = 'regist'}
 {/if}
     <h2 class="htype01">治療区分</h2>
     <div class="indent">
     <ul class="koumoku clearfix">
    <li>
   	{if $main_kubun eq 1}
   		{$checked_kubun = {$smarty.const._CHECKED_CODE}}
   	{else}
   		{$checked_kubun = ""}
   	{/if}
      <label>
       <input name="kubun" type="checkbox" value="1"{$checked_kubun}>
       前期のみ</label>
       </li>
   </ul>
     </div>
 <input type="hidden" name="mode" value="{$mode}" />
  <div class="column3">
   <ul class="clearfix fixHeight">
    <li>
     <h2 class="htype01">年齢</h2>
     <div class="indent">
      <select name="age">
      {foreach from=$age_option item="age"}
   	{if $age eq $main_age}
   		{$selected = {$smarty.const._SELECTED_CODE}}
   	{else}
   		{$selected = ""}
   	{/if}
      <option value="{$age}"{$selected}>{$age}</option>
      {/foreach}
      </select>
      歳 </div>
    </li>
    <li class="long">
     <h2 class="htype01">性別</h2>
     <div class="indent">
   	{if $main_sex eq "男"}
   		{$checked_male = {$smarty.const._CHECKED_CODE}}
   	{elseif $main_sex eq "女"}
   		{$checked_female = {$smarty.const._CHECKED_CODE}}
   	{/if}
      <label for="male">
       <input name="sex" type="radio" id="male" value="男"{$checked_male} />
       男　 </label>
      <label for="female">
       <input type="radio" name="sex" id="female" value="女"{$checked_female} />
       女 </label>
       <p class="error" htmlfor="sex">性別を選択してください。</p>
     </div>
    </li>
    </ul>
    </div>
     <h2 class="htype01">歯列</h2>
     <div class="indent">
     <ul class="koumoku clearfix">
   {foreach from=$shiretsu item="value"}
   	{if $value.id eq $main_shiretsu}
   		{$checked = {$smarty.const._CHECKED_CODE}}
   	{else}
   		{$checked = ""}
   	{/if}
    <li>
      <label for="shiretsu{$value.id}">
       <input name="shiretsu" type="radio" id="shiretsu{$value.id}" value="{$value.id}"{$checked} />
       {$value.name}　 </label>
       </li>
   {/foreach}
   </ul>
       <p class="error" htmlfor="shiretsu">歯列を選択してください。</p>
     </div>
     <h2 class="htype01">治療方針</h2>
     <div class="indent">
     <ul class="koumoku clearfix">
   {foreach from=$basshi item="value"}
   	{if $value.id eq $main_basshi}
   		{$checked = {$smarty.const._CHECKED_CODE}}
   	{else}
   		{$checked = ""}
   	{/if}
    <li>
      <label for="basshi{$value.id}">
       <input name="basshi" type="radio" id="basshi{$value.id}" value="{$value.id}"{$checked} />
       {$value.name}　 </label>
       </li>
   {/foreach}
   </ul>
        <p class="error" htmlfor="basshi">治療方針を選択してください。</p>
    </div>
     <h2 class="htype01">抜歯部位</h2>
     <div class="indent">
     <ul class="koumoku clearfix ktype02">
     {$check_flag = 0}
   {foreach from=$basshi_bui item="value"}
   	{if $value.id eq $main_basshi_bui}
   		{$checked = {$smarty.const._CHECKED_CODE}}
     {$check_flag = 1}
   	{else}
   		{$checked = ""}
   	{/if}
    <li>
      <label for="basshi_bui{$value.id}">
       <input name="basshi_bui" type="radio" id="basshi_bui{$value.id}" value="{$value.id}"{$checked} />
       {$value.name}　 </label>
       </li>
   {/foreach}
   {if !$check_flag}
   	{$checked_noselect = {$smarty.const._CHECKED_CODE}}
   {/if}
    <li>
      <label for="basshi_bui_noselect">
       <input name="basshi_bui" type="radio" id="basshi_bui_noselect" value=""{$checked_noselect} />
       選択なし　 </label>
       </li>
   </ul>
     </div>
  <h2 class="htype01">診断名　メイン</h2>
  <div class="indent">
   <ul class="shindan clearfix">
   {foreach from=$shindan_main item="value"}
   	{if $value.id eq $main_shindan}
   		{$checked = {$smarty.const._CHECKED_CODE}}
   	{else}
   		{$checked = ""}
   	{/if}
    <li>
     <label for="shindan{$value.id}">
      <input type="radio" value="{$value.id}" name="shindan" id="shindan{$value.id}"{$checked} />
      {$value.name}</label>
    </li>
   {/foreach}
   </ul>
        <p class="error" htmlfor="shindan">診断名　メインを選択してください。</p>
  </div>
  <h2 class="htype01">診断名　サブ</h2>
  <div class="indent">
  <p class="b_m10">（複数選択可）</p>
   <ul class="shindan clearfix">
   {foreach from=$shindan item="value"}
	   {$checked = ""}
	   {foreach from=$main_shindan_sub item="shindan_sub_id"}
	   	{if $value.id eq $shindan_sub_id}
	   		{$checked = {$smarty.const._CHECKED_CODE}}
	   	{/if}
	   {/foreach}
    <li>
     <label for="subshin{$value.id}">
      <input type="checkbox" value="{$value.id}" name="shindan_sub[]" id="subshin{$value.id}"{$checked} />
      {$value.name}</label>
    </li>
   {/foreach}
   </ul>
  </div>
     <h2 class="htype01">装置</h2>
     <div class="indent">
  <p class="b_m10">（複数選択可）</p>
   <ul class="shindan clearfix fixHeight">
   {foreach from=$souchi item="value"}
	   {$checked = ""}
	   {foreach from=$main_souchi item="souchi_id"}
	   	{if $value.id eq $souchi_id}
	   		{$checked = {$smarty.const._CHECKED_CODE}}
	   	{/if}
	   {/foreach}
    <li>
     <label for="souchi{$value.id}">
      <input type="checkbox" value="{$value.id}" name="souchi[]" id="souchi{$value.id}"{$checked} />
      {$value.name}</label>
      </li>
   {/foreach}
   </ul>
     </div>
     <section id="sec_tantou">
     <h2 class="htype01">担当医</h2>
     <div class="indent">
     {$check_flag = 0}
   {foreach from=$tantou item="value"}
	   {$checked = ""}
	   {if $value.id eq 3}
	   {$checked = {$smarty.const._CHECKED_CODE}}
	   {/if}
	   {foreach from=$main_tantou item="tantou_id"}
	   	{if $value.id eq $tantou_id}
	   		{$checked = {$smarty.const._CHECKED_CODE}}
	   	{/if}
	   {/foreach}
      <label for="tantou{$value.id}">
       <input name="tantou[]" type="checkbox" id="tantou{$value.id}" value="{$value.id}"{$checked} />
       {$value.name}　 </label>
   {/foreach}
     </div>
					</section>
					<!--
  <h2 class="htype01">症例ケース番号</h2>
  <div class="indent">
  <p>Case 
   <input type="text" class="text w01" name="case_num" value="{$main_case_num}" /></p>
        <p class="error" htmlfor="case_num">症例ケース番号を半角数字で入力してください。</p>
  </div>
		-->
		<input type="hidden" name="case_num" value="{$main_case_num}" />
  <h2 class="htype01">カルテ番号</h2>
  <div class="indent">
  <p>
   <input type="text" class="text w01" name="karte_num" value="{$main_karte_num}" /></p>
  </div>
  <h2 class="htype01">症例の説明</h2>
  <div class="indent">
   <textarea class="type01" name="thisinfo">{$main_thisinfo}</textarea>
        <p class="error" htmlfor="thisinfo">症例の説明を入力してください。</p>
  </div>
  <h2 class="htype01">患者さんの感想</h2>
  <div class="indent">
   <textarea class="type01" name="kansou">{$main_kansou}</textarea>
  </div>
  <h2 class="htype01">クリニックコメント</h2>
  <div class="indent">
   <textarea class="type01" name="comment">{$main_comment}</textarea>
  </div>
  <h2 class="htype01">記事公開</h2>
  <div class="indent">
  {$checked = ""}
	   	{if $main_shitagaki}
	   		{$checked = {$smarty.const._CHECKED_CODE}}
	   	{/if}
   <p class="b_m5">公開せずに下書き状態にする場合は、チェックをいれてください。</p>
   <label for="shitagaki">
      <input type="checkbox" value="1" name="shitagaki" id="shitagaki"{$checked} />
      下書き</label>
  </div>
  <div class="submit">
 {if $edit_id}
   <input name="imageField" type="image" id="imageField" src="img/btn_editimg.gif" alt="画像の編集へ" />
  <input type="hidden" name="edit_id" value="{$edit_id}" />
   <div class="backstep"><a href="kiji_confirm.php?id={$edit_id}"><img src="img/btn_backedit.gif" width="165" height="24" alt="編集前のデータに戻る" /></a></div>
 {else}
   <input name="imageField" type="image" id="imageField" src="img/btn_registimg.gif" alt="画像の登録へ" />
   <div class="backstep"><a href="index.php"><img src="img/btn_back.gif" width="71" height="24" alt="戻る" /></a></div>
 {/if}
  </div>
 </form>
 {if $edit_id}
 <form action="process.php" method="post" class="delete">
  <div class="submit delete">
   <input name="imageField" type="image" id="imageField" src="img/btn_delete.gif" alt="記事を削除する" />
   <input type="hidden" name="mode" value="delete" />
   <input type="hidden" name="id[]" value="{$edit_id}" />
   {if isset($ikkatsu)}
   <input type="hidden" name="ikkatsu" value="1" />
   {/if}
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
  <p>記事の追加・編集 ＞ 
  {if $edit_id}
  <a href="index.php">記事の一覧・編集</a> ＞ <strong>「{$main_age}歳　{$main_sex}{$main_sex_ex}」 の記事編集</strong>
  {else}
  <strong>記事の新規追加</strong>
  {/if}
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
