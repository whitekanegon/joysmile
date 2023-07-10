{include file="{$smarty.const._SITE_ROOT}case/include/html_header.html"}
<body>
{include file="{$smarty.const._SITE_ROOT}lib/ssi/header.html"}
<div id="topicpath"><a href="/">トップページ</a> &gt; <a href="/case/">症例紹介</a> &gt; 症例詳細検索</div>
<div id="container" class="search">
	<div id="contents" class="wide">
<!--[contents]-->
{if $admin_mode}
<div class="admin_header">
<dl class="clearfix">
<dt>【管理モード】</dt>
<dd class="logout"><a href="/case/admin/admin_mode_logout.php"><img src="/case/img/btn_logout.gif" width="70" height="22" alt="ログアウト" /></a></dd>
</dl>
</div>
{/if}
   <!--[cont_header]-->
   <h1 class="htype01">症例詳細検索</h1>
   <!--/[cont_header]-->
   <h2 class="htype02">フリーワード検索</h2>
   <form method="get" action="search_result.php" name="search_word">
   <div class="freewords">
   <input type="text" name="freeword" value="" class="text w01" />
   <input type="submit" value="検索" />
<ul class="con b_m0">
<li><label for="s_con_and"><input type="radio" name="s_con" value="AND" id="s_con_and" checked="checked" />AND</label></li>
<li><label for="s_con_or"><input type="radio" name="s_con" value="OR" id="s_con_or" />OR</label></li>
</ul>
   </div>
   </form>
   <div class="titlebox">
   <h2 class="htype02">分類項目を指定して検索</h2>
    <div class="reset_btn"><a href="#" onclick="document.search_item.reset(); return false;">チェックを全てはずす</a></div>
				</div>
  <form method="get" action="search_result.php" name="search_item" class="search_item">
   <section>
   <h3 class="htype04">診断名</h3>
   <ul class="shindan">
   {foreach from=$data.shindan item="value"}
    <li>
     <label for="shindan{$value.id}">
      <input type="checkbox" value="{$value.id}" name="shindan[]" id="shindan{$value.id}" />
      {$value.name}</label>
    </li>
   {/foreach}
   </ul>
   </section>
   <section>
   <h3 class="htype04">歯列</h3>
     <ul class="koumoku">
   {foreach from=$data.shiretsu item="value"}
    <li>
      <label for="shiretsu{$value.id}">
       <input name="shiretsu[]" type="checkbox" id="shiretsu{$value.id}" value="{$value.id}" />
       {$value.name}</label>
       </li>
   {/foreach}
   </ul>
   </section>
   <section>
   <h3 class="htype04">治療方針</h3>
     <ul class="koumoku">
   {foreach from=$data.basshi item="value"}
    <li>
      <label for="basshi{$value.id}">
       <input name="basshi[]" type="checkbox" id="basshi{$value.id}" value="{$value.id}" />
       {$value.name}</label>
       </li>
   {/foreach}
   </ul>
   </section>
   <section>
   <h3 class="htype04">年代</h3>
     <ul class="koumoku02">
   {foreach from=$data.nendai item="value"}
    <li>
      <label for="nendai{$value.id}">
       <input name="nendai[]" type="checkbox" id="nendai{$value.id}" value="{$value.id}" />
       {$value.name}</label>
       </li>
   {/foreach}
   </ul>
   </section>
   <section>
   <h3 class="htype04">性別</h3>
     <ul class="koumoku02">
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
   </section>
   <section>
   <h3 class="htype04">装置</h3>
   <ul class="souchi">
   {foreach from=$data.souchi item="value"}
    <li>
     <label for="souchi{$value.id}">
      <input type="checkbox" value="{$value.id}" name="souchi[]" id="souchi{$value.id}"{$checked} />
      {$value.name}</label>
      </li>
   {/foreach}
   </ul>
   </section>
   {* 担当医　非表示
   <section>
   <h3 class="htype04">担当医</h3>
     <ul class="koumoku">
   {foreach from=$data.tantou item="value"}
    <li>
      <label for="tantou{$value.id}">
       <input name="tantou[]" type="checkbox" id="tantou{$value.id}" value="{$value.id}" />
       {$value.name}</label>
       </li>
   {/foreach}
   </ul>
   </section>
   *}
   <section>
   <h3 class="htype04">患者さんの感想</h3>
     <ul class="koumoku02">
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
   </section>
   <div class="reset_btn btm"><a href="#" onclick="document.search_item.reset(); return false;">チェックを全てはずす</a></div>
   <div class="submit">
   <input type="submit" class="cmnbtn03" value="検索">
   </div>
   </form>
<!--/[contents]-->
</div>

<div id="bnavi">
<!--[side]-->
{include file="{$smarty.const._SMARTY_TEMPLATES_DIR}sidemenu.tpl"}
<!--/[side]-->
</div>
</div>
<!--/[container]-->
<!--[footer]-->
{include file="{$smarty.const._SITE_ROOT}lib/ssi/footer.html"}
<!--/[footer]-->
</body>
</html>































