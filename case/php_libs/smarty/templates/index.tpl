{include file="{$smarty.const._SITE_ROOT}case/include/html_header.html"}
<body class="case_top">
{include file="{$smarty.const._SITE_ROOT}lib/ssi/header.html"}
<div id="topicpath"><a href="/">トップページ</a> &gt; 症例紹介</div>
<div id="container">
	<div id="contents" class="wide">
{if $admin_mode}
<div class="admin_header">
<dl class="clearfix">
<dt>【管理モード】</dt>
<dd class="logout"><a href="/case/admin/admin_mode_logout.php"><img src="/case/img/btn_logout.gif" width="70" height="22" alt="ログアウト" /></a></dd>
</dl>
</div>
{/if}
<!--[cont_header]-->
<!--/[cont_header]-->
<h1 class="htype01">症例紹介（{$all_count.0}）</h1>
<p>代表的な不正咬合をご紹介いたします。その分類ごとに、混合歯列期（小学校のお子様）、永久歯列期（中学生以上）にわけ、それぞれで抜歯ケース、非抜歯ケースでの治療例を紹介いたしております。ただし、症例によっては、「叢生」、「前歯部交叉咬合」など、厳密には分けがたい場合もありますが、ご覧頂きやすい方に分類しております</p>
<p>当院で矯正歯科治療を終了された患者さんのなかから、許可を頂いている方を載せさせていただいております。もし不都合が生じました際は、ご連絡下さい。すぐに削除させていただきます。</p>
<h2 class="htype02">診断別</h2>
<ul class="caselist">
{foreach from=$shindan item="row"}
<li>
<div class="img"><a href="shindan.php?id={$row.id}"><img src="{$row.photo_header}.jpg" alt="{$row.name}" /></a></div>
<dl>
<dt><a href="shindan.php?id={$row.id}">{$row.name}</a></dt>
<dd class="txt">{$row.explanation_short}</dd>
</dl>
</li>
{/foreach}
</ul>
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































