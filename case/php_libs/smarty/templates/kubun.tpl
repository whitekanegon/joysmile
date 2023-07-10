{include file="{$smarty.const._SITE_ROOT}case/include/html_header.html"}
<body>
{include file="{$smarty.const._SITE_ROOT}lib/ssi/header.html"}
<div id="topicpath"><a href="/">トップページ</a> &gt; <a href="/case/">症例紹介</a> &gt; 前期のみ</div>
<div id="container">
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
   <h1 class="htype01">前期のみ</h1>
   <!--/[cont_header]-->
   <div class="lead_category clearfix">
   <p>前期とは歯列の中に乳歯と永久歯の混じった時期（混合歯列期）であり、小学生の矯正治療と考えて下さい。この時期には、身体が大きくなりますので、顎の成長も期待できます。矯正装置で成長を助け、歯列の拡大や顎の成長の促進・抑制が可能です。永久歯を抜かなくても全ての歯がキレイに並ぶことを目指します（非抜歯矯正治療）。通常、後期治療をスムーズに進めるための前段階として行いますが、なかには、前期治療のみで終えられる場合もあります。</p>
   </div>
   {$shindan_cate_flag = 0}
   {$shindan_cate_others_flag = 0}
   {foreach from=$shindan_cate key="key" item="row_cate"}
   	{if $row_cate}{$shindan_cate_flag = 1}{/if}
   {/foreach}
   {foreach from=$shindan_cate_others key="key" item="row_cate"}
   	{if $row_cate}{$shindan_cate_others_flag = 1}{/if}
   {/foreach}
   {if $shindan_cate_flag || $shindan_cate_others_flag}
   <h2 class="htype02">症例</h2>
   <dl class="categoy_entries clearfix">
   {foreach from=$shindan_cate key="key" item="row_cate"}
   {if $row_cate}
    <dt data-key="{$shindan_keys.$key}">【{$category_title.$key.name}】</dt>
    <dd>
     <ul class="clearfix">
       {foreach from=$row_cate item="row"}
      <li>
      <dl class="kubun">
						<dt>{$row.sex}{$row.sex_ex}<br>
						治療開始年齢：{$row.age}歳</dt>
					<dd class="start">
      {if $row.photo_first[0]}
						<img src="{$row.photo_first[0]}.jpg">
						{/if}
					</dd>
					<dd class="end">
      {if $row.photo_mdl[0]}
						<img src="{$row.photo_mdl[0]}.jpg">
						{else if $row.photo_end[0]}
						<img src="{$row.photo_end[0]}.jpg">
						{/if}
					</dd>
						</dl>
      </li>
       {/foreach}
     </ul>
    </dd>
				{/if}
    {/foreach}
   {if $shindan_cate_others_flag}
    	<dt data-key="others">【その他】</dt>
    <dd>
     <ul class="clearfix">
    	{foreach from=$shindan_cate_others key="key" item="row_cate"}
    {if $row_cate}
     {foreach from=$row_cate item="row"}
      <li>
      <dl class="kubun">
						<dt>{$row.sex}{$row.sex_ex}<br>
治療開始年齢：{$row.age}歳</dt>
					<dd class="start">
      {if $row.photo_first[0]}
						<img src="{$row.photo_first[0]}.jpg">
						{/if}
					</dd>
					<dd class="end">
      {if $row.photo_mdl[0]}
						<img src="{$row.photo_mdl[0]}.jpg">
						{else if $row.photo_end[0]}
						<img src="{$row.photo_end[0]}.jpg">
						{/if}
					</dd>
						</dl>
      </li>
       {/foreach}
    {/if}
    	{/foreach}
    {/if}
  </dl>
  {else}
		<p class="posC">ただいま準備中です。</p>
  {/if}
<!--/[contents]-->
</div>

<div id="bnavi">
<!--[side]-->
{include file="{$smarty.const._SMARTY_TEMPLATES_DIR}sidemenu.tpl"}
<!--/[side]-->
</div>
</div>
</div>
<!--/[container]-->
<!--[footer]-->
{include file="{$smarty.const._SITE_ROOT}lib/ssi/footer.html"}
<!--/[footer]-->
</body>
</html>































