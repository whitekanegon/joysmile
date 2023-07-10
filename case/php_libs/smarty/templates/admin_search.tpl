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
  <strong>記事詳細検索</strong>
  </p>
 </div>
 <!--/[TOPICPATH]-->
 <!--[CONTENTS]--> 
   <h2 class="htype01">フリーワード検索</h2>
   <div class="indent">
   <form method="get" action="search_result.php" name="search_word">
   <div class="freeword clearfix">
   <input type="text" name="freeword" value="" class="text w01" />
   <input type="image" src="/case/img/btn_case_search_small.gif" alt="検索" />
<ul class="con clearfix b_m0">
<li><label for="s_con_and"><input type="radio" name="s_con" value="AND" id="s_con_and" checked="checked" />AND</label></li>
<li><label for="s_con_or"><input type="radio" name="s_con" value="OR" id="s_con_or" />OR</label></li>
</ul>
   </div>
   </form>
   </div>
   <h2 class="htype01">分類項目を指定して検索</h2>
    <div class="reset_btn"><a href="#"><img src="/case/img/btn_case_reset.gif" alt="チェックを全てはずす" width="125" height="23" /></a></div>
  <form method="get" action="search_result.php" name="search_item" class="search_item">
   <h3 class="htype02">診断名</h3>
   <div class="indent">
   <ul class="shindan clearfix">
   {foreach from=$data.shindan item="value"}
    <li>
     <label for="shindan{$value.id}">
      <input type="checkbox" value="{$value.id}" name="shindan[]" id="shindan{$value.id}" />
      {$value.name}</label>
    </li>
   {/foreach}
   </ul>
   </div>
   <h3 class="htype02">歯列</h3>
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
   <h3 class="htype02">治療方針</h3>
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
   <h3 class="htype02">年代</h3>
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
   <h3 class="htype02">性別</h3>
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
   <h3 class="htype02">装置</h3>
   <div class="indent">
   <ul class="shindan clearfix fixHeight">
   {foreach from=$data.souchi item="value"}
    <li>
     <label for="souchi{$value.id}">
      <input type="checkbox" value="{$value.id}" name="souchi[]" id="souchi{$value.id}"{$checked} />
      {$value.name}</label>
      </li>
   {/foreach}
   </ul>
   </div>
   <h3 class="htype02">担当医</h3>
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
   <h3 class="htype02">患者さんの感想</h3>
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
   <div class="reset_btn"><a href="#"><img src="/case/img/btn_case_reset.gif" alt="チェックを全てはずす" width="125" height="23" /></a></div>
   <div class="submit">
   <input type="image" src="/case/img/btn_case_search.gif" alt="検索" />
   </div>
   </form>
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
  <strong>記事詳細検索</strong>
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
