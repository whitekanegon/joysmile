{include file="{$smarty.const._SITE_ROOT}case/admin/include/html_header.inc"}
<script type="text/javascript">
 {if isset($kiji_delete)}
{literal}
$(function(){
	$(".tablesorter").tablesorter({
		widgets: ['zebra'],
		sortList: [[12,1]],
		headers: { 0: { sorter: false} }
	});
});
{/literal}
	{else}
{literal}
$(function(){
	$(".tablesorter").tablesorter({
		widgets: ['zebra'],
		sortList: [[11,1]]
	});
});
{/literal}
{/if}
</script>
</head>
<body>
<!--[HEADER]-->
{include file="{$smarty.const._SITE_ROOT}case/admin/include/header.inc"}
<!--/[HEADER]-->
<div id="contents" class="admin_top"> 
 <!--[TOPICPATH]-->
 <div id="topicpath">
  <p>記事の追加・編集 ＞ 
 {if isset($kiji_delete)}
  <strong>記事の一括削除</strong>
 {else}
  <strong>記事の一覧・編集</strong>
  {/if}
  </p>
 </div>
 <!--/[TOPICPATH]-->
 <!--[CONTENTS]--> 
 <h2 class="htype01">記事一覧</h2>
 {if isset($kiji_delete)}
 <form action="process.php" method="post" class="delete">
 <p>チェックしたものを一括で削除します。</p>
 <p class="text11 b_m10">（ID列をクリックすると編集画面にジャンプします）</p>
 {$tbl_class = 'delete'}
 {else}
 <p class="b_m10">各項目をクリックすると、昇順降順に並び替えることができます。</p>
 <p class="b_m10">薄い茶色の行は、下書き状態の記事です。</p>
 {$tbl_class = 'trlink'}
 {/if}
 {if isset($db_msg)}
 <p class="DB_massage">{$db_msg}</p>
 {* <p>insert_id = {$insert_id}</p> *}
 {/if}
 <table border="0" cellspacing="0" cellpadding="0" class="type01 tablesorter {$tbl_class}">
 <thead>
 <tr>
 {if isset($kiji_delete)}
 <th class="C">削除</th>
 {/if}
  <th>ID</th>
  <th>年齢</th>
  <th>性別</th>
  <th>診断名</th>
  <th>歯列</th>
  <th>治療方針</th>
  <th>感想</th>
  <th>コメント</th>
  <th>患者写真</th>
  <th>治療区分</th>
  <!--<th>Case</th>-->
  <!--<th>担当医</th>-->
  <th>カルテ</th>
  <th>更新日</th>
 </tr>
 </thead>
{foreach from=$data item="value"}
{if $value.id eq $insert_id}
	<tr class="db_mark">
{elseif $value.shitagaki}
	<tr class="shitagaki">
{else}
 <tr>
{/if}
 {if isset($kiji_delete)}
 <td class="C"><input type="checkbox" name="id[]" value="{$value.id}" /></td>
 {$ikkatsu = 'ikkatsu=1'}
 {/if}
  <td><a href="kiji_confirm.php?id={$value.id}&{$ikkatsu}">{$value.id}</a></td>
  <td>{$value.age}歳</td>
  <td>{$value.sex}{$value.sex_ex}</td>
  <td>{$value.shindan}</td>
  <td>{$value.shiretsu}</td>
  <td>{$value.basshi}</td>
  <td class="C">{$value.kansou}</td>
  <td class="C">{$value.comment}</td>
  <td class="C">{if $value.photo_patient}★{/if}</td>
  <td class="C">{if $value.kubun eq 1}前期のみ{/if}</td>
  <!--<td class="C">{$value.case_num}</td>-->
  <!--<td class="C">{$value.tantou}</td>-->
  <td class="C">{$value.karte_num}</td>
  <td class="C">{$value.date}</td>
  </tr>
 {/foreach}
 </table>
 {if isset($kiji_delete)}
  <div class="submit">
   <input type="hidden" name="mode" value="delete" />
   <input type="hidden" name="ikkatsu" value="1" />
   <input name="imageField" type="image" id="imageField" src="img/btn_delete.gif" alt="記事を削除する" />
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
 {if isset($kiji_delete)}
  <strong>記事の一括削除</strong>
 {else}
  <strong>記事の一覧・編集</strong>
  {/if}
  </p>
 </div>
</div>
{include file="{$smarty.const._SITE_ROOT}case/admin/include/footer.inc"}
<!--[FOOTER]-->
</body>
</html>
