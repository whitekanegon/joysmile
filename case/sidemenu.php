<?php

list($shindan,$shindan_count) = side_shindan($conn);
list($nendai,$nendai_count) = side_nendai($conn);
list($tantou,$tantou_count) = side_tantou($conn);
$smarty -> assign('all_count',side_all_count($conn));
$smarty -> assign('shindan',$shindan);
$smarty -> assign('shindan_count',$shindan_count);
$smarty -> assign('nendai',$nendai);
$smarty -> assign('nendai_count',$nendai_count);
$smarty -> assign('tantou',$tantou);
$smarty -> assign('tantou_count',$tantou_count);

?>

