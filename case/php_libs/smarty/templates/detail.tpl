{include file="{$smarty.const._SITE_ROOT}case/include/html_header.html"}
<body>
{include file="{$smarty.const._SITE_ROOT}lib/ssi/header.html"}
<div id="topicpath"><a href="/">トップページ</a> &gt; <a href="/case/">症例紹介</a> &gt; {$data.kansou_mark}{$data.age}歳　{$data.sex}{$data.sex_ex}　{$data.shiretsu}　{$data.basshi}{if $data.basshi_bui}　<span class="bui">（抜歯部位：{$data.basshi_bui}）</span>{/if}</div>
<div id="container">
	<div id="contents" class="wide">
<!--[contents]-->
{if $admin_mode}
<div class="admin_header">
<dl class="clearfix">
<dt>【管理モード】</dt>
<dd class="editbtn"><a href="/case/admin/kiji_confirm.php?id={$main_id}" target="_blank"><img src="/case/img/btn_case_edit.gif" width="176" height="34" alt="この症例を修正する" /></a></dd>
<dd class="logout"><a href="/case/admin/admin_mode_logout.php"><img src="/case/img/btn_logout.gif" width="70" height="22" alt="ログアウト" /></a></dd>
</dl>
</div>
{/if}
   <!--[cont_header]-->
   <div class="titlebox">
   <h1 class="htype01">{$data.kansou_mark}{$data.age}歳　{$data.sex}{$data.sex_ex}　{$data.shiretsu}　{$data.basshi}{if $data.basshi_bui}　<span class="bui">（抜歯部位：{$data.basshi_bui}）</span>{/if}</h1>
			<p class="karte">ID：{$data.id}</p>
			</div>
   <div class="shindan_title clearfix">
   <p class="notice_category"><strong>{$data.shindan}</strong></p>
   {if $data.shindan_sub}
   <div class="sub clearfix">
   {foreach from=$data.shindan_sub item="val"}
   <p>{$val}</p>
   {/foreach}
   </div>
   {/if}
   </div>
   <!--/[cont_header]-->
   {* 担当医は非表示
			<div class="doctor clearfix">
   {if $data.tantou}
			<dl>
			<dt>担当医：</dt>
   {foreach from=$data.tantou item="val" name="tantou"}
   <dd>{if $smarty.foreach.tantou.index > 0}／{/if}{$val}</dd>
   {/foreach}
			</dl>
   {/if}
			</div>
   *}
   <div class="lead_entry clearfix">
    <div class="image"><img src="{$data.photo_header}.jpg" width="180" height="120" alt="" /></div>
    <p>{*Case{$data.case_num}<br />*}
{$data.thisinfo}</p>
   </div>
   {if $data.kansou}
   <h2 class="htype02">患者さんからの感想</h2>
   <div class="indent">
   {if $data.photo_patient}
			<div class="photo_patient"><a href="{$data.photo_patient}.jpg"><img src="{$data.photo_patient}.jpg" alt=""></a></div>
			{/if}
   <p>{$data.kansou}</p>
   </div>
   {/if}
   {if $data.comment}
   <h2 class="htype02">クリニックコメント</h2>
   <div class="indent">
   <p>{$data.comment}</p>
   </div>
   {/if}
			{*
   {if $data.souchi || $data.tantou}
   <div class="sub_data">
   <ul class="clearfix">
   {if is_array($data.souchi)}
   <li>
   <h2 class="htype02">装置</h2>
   <ul class="listtype01 fixHeight">
   {foreach from=$data.souchi item="val"}
   <li>{$val}</li>
   {/foreach}
   </ul>
   </li>
   {/if}
   </ul>
   </div>
   {/if}
			*}
   <div class="shourei_detail">
   <h2 class="htype02">症例画像</h2>
   {foreach from=$photo item="status"}
   {$photo_name = $status.title.name}
   {if $data.$photo_name.0}
   	<h3 class="h_status">{$status.title.header}</h3>
    	<ul>
     {foreach from=$data.$photo_name key="key" item="photo_path" name="photos"}
     {if $photo_path}
     	<li><a href="{$photo_path}.jpg" title="{$status.title.header}　{$smarty.foreach.photos.iteration} / {$data.$photo_name|@count}"><img src="{$photo_path}.jpg" width="156" height="104" alt="" /></a></li>
      {/if}
     {/foreach}
    	</ul>
   {/if}
   {/foreach}
   </div>
   {* 印刷なし その他なし
			<p class="print_detail"><a href="#" onclick="window.print();return false;"><img src="/case/img/btn_print.gif" width="200" height="35" alt="この症例を印刷する" /></a></p>
			<p class="copyright">医療法人　ほてい矯正歯科クリニック<br />
Copyright © 2012 Hotei Clinic. All rights reserved.</p>
   {if $related_count > 1}
			<div class="related">
   <h2 class="htype03">【{$data.shindan}】{if $nendai_name}　【{$nendai_name}】{elseif $tantou_name}　【担当医：{$tantou_name}】{/if}　その他の症例</h2>
   <ul class="kanren clearfix">
   {foreach from=$related_data item="row"}
   {if $row.id != $main_id}
    <li>
     <dl>
      <dt><a href="detail.php?id={$row.id}"><img src="{$row.photo_header}_thumb.jpg" width="118" height="78" alt="" /></a></dt>
      <dd><a href="detail.php?id={$row.id}">{$row.kansou_mark}{$row.age}歳　{$row.sex}{$row.sex_ex}<br />
       <span>{$row.shiretsu}　{$row.basshi}</span></a></dd>
     </dl>
    </li>
    {/if}
    {/foreach}
   </ul>
			</div>
   {/if}
   			*}

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
