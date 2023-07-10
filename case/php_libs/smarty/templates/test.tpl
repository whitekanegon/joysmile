{include file="{$smarty.const._SITE_ROOT}case/admin/include/html_header.inc"}
</head>
<body>
<!--[HEADER]-->
<div id="header_container">
 <div id="header">
  <div id="logo"><a href="index.php"><img src="/case/admin/img/logo.gif" width="329" height="18" alt="ほてい矯正歯科　症例システム 管理画面" /></a>
{if !$search}
<div id="search_free">
<form method="get" action="search_result.php" name="search_word">
<div class="freeword clearfix">
<input type="text" name="freeword" value="{$sword}" class="text freeword" />
<input type="image" src="/case/img/btn_case_search_small.gif" alt="検索" />
<input type="hidden" name="s_con" value="AND" />
</div>
</form>
</div>
{/if}
  </div>
  <div id="gnavi">
   <ul class="clearfix">
    <li class="gn01"><a href="#">記事の追加・編集</a>
     <div class="sub">
      <ul class="clearfix">
       <li><a href="kiji_edit.php">記事の新規追加</a></li>
       <li><a href="index.php">記事の一覧・編集</a></li>
       <li><a href="kiji_delelte.php">記事の一括削除</a></li>
      </ul>
     </div>
    </li>
    <li class="gn02"><a href="#">分類項目の一覧・編集</a>
     <div class="sub">
      <ul class="clearfix">
       <li><a href="bunrui_index.php?bid=shindan">診断名</a></li>
       <li><a href="bunrui_index.php?bid=nendai">年代</a></li>
       <li><a href="bunrui_index.php?bid=shiretsu">歯列</a></li>
       <li><a href="bunrui_index.php?bid=basshi">治療方針</a></li>
       <li><a href="bunrui_index.php?bid=basshi_bui">抜歯部位</a></li>
       <li><a href="bunrui_index.php?bid=souchi">装置</a></li>
       <li><a href="bunrui_index.php?bid=tantou">担当医</a></li>
      </ul>
     </div>
    </li>
   </ul>
  </div>
 </div>
</div>
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
