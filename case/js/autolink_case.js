$.fn.addlink = function(baseURL){
	var dict = [
				"エッジワイズ装置","/chiryo/souchi/edgewise.html",
				"エッジワイズ治療","/chiryo/souchi/edgewise.html",
				"拡大床","/chiryo/souchi/kadou.html#s01",
				"アクティブプレート","/chiryo/souchi/kadou.html#s01",
				"咬合挙上床","/chiryo/souchi/kadou.html#s02",
				"ジャンピングプレート","/chiryo/souchi/kadou.html#s02",
				"FKO","/chiryo/souchi/kadou.html#s03",
				"エフカーオー","/chiryo/souchi/kadou.html#s03",
				"フレンケル","/chiryo/souchi/kadou.html#s03",
				"ビムラー","/chiryo/souchi/kadou.html#s03",
				"リップバンパー","/chiryo/souchi/kadou.html#s04",
				"インビザライン","/chiryo/invisalign.html",
				"クリアライナー","/chiryo/invisalign.html",
				"アソアライナー","/chiryo/invisalign.html",
				"マウスピース","/chiryo/invisalign.html",
				"リンガルアーチ","/chiryo/souchi/kotei.html#s01",
				"舌側弧線装置","/chiryo/souchi/kotei.html#s01",
				"3Dリンガルアーチ","/chiryo/souchi/kotei.html#s01",
				"クワッドヘリックス","/chiryo/souchi/kotei.html#s02",
				"クオードヘリックス","/chiryo/souchi/kotei.html#s02",
				"クォードヘリックス","/chiryo/souchi/kotei.html#s02",
				"QH","/chiryo/souchi/kotei.html#s02",
				"BH","/chiryo/souchi/kotei.html#s02",
				"バイヘリックス","/chiryo/souchi/kotei.html#s02",
				"パラタルアーチ","/chiryo/souchi/kotei.html#s03",
				"パラタルボタン","/chiryo/souchi/kotei.html#s03",
				"タングクリブ","/chiryo/souchi/kotei.html#s04",
				"GMD","/chiryo/souchi/kotei.html#s05",
				"ディスタルジェット","/chiryo/souchi/kotei.html#s05",
				"ペンデュラム","/chiryo/souchi/kotei.html#s05",
				"急速拡大装置","/chiryo/souchi/kotei.html#s06",
				"ヘッドギアー","/chiryo/souchi/ago.html#s01",
				"チンキャップ","/chiryo/souchi/ago.html#s02",
				"プロトラクター","/chiryo/souchi/ago.html#s03",
				"メタルブラケット","/chiryo/souchi/edgewise.html#s01",
				"セラミックブラケット","/chiryo/souchi/edgewise.html",
				"コーティングワイヤー","/chiryo/souchi/edgewise.html",
				"リンガルブラケット","/chiryo/souchi/edgewise.html#s04",
				"ボンデッドワイヤー","/chiryo/souchi/hotei.html#s01",
				"ワイヤーボンディング","/chiryo/souchi/hotei.html#s01",
				"G-Arch","/chiryo/souchi/hotei.html#s01",
				"顎間ゴム","/chiryo/edgewise.html",
				"リテーナー","/chiryo/souchi/hotei.html#s02",
				"ベッグタイプ","/chiryo/souchi/hotei.html#s02",
				"ホーレータイプ","/chiryo/souchi/hotei.html#s02",
				"スプリングリテーナー","/chiryo/souchi/hotei.html#s03",
				"エシックス","/chiryo/souchi/hotei.html#s04",
				"インビジブルタイプ","/chiryo/souchi/hotei.html#s04",
				"デーモンシステム","/chiryo/damon.html",
				"デーモンブラケット","/chiryo/damon.html",
				"クリアスナップ","/chiryo/clearsnap",
				"STB","/chiryo/stb-lingual.html",
				"クリッピー","/chiryo/stb-lingual.html",
				"インプラントアンカー","/chiryo/stb-lingual.html",
				"ミニスクリュー","/chiryo/stb-lingual.html",
				"ミニインプラント","/chiryo/stb-lingual.html",
				"TAD","/chiryo/stb-lingual.html"
			];
	return this.each(function(){
		var srcText = this.innerHTML;
		for (var i=0; i<dict.length; i+=2){
			srcText = srcText.replace( eval("/"+dict[i]+"/g"),"<a href='"+dict[i+1]+"' target='_blank'>"+dict[i]+"</a>");
		}
		this.innerHTML = srcText;
	});
}

$(function () {
				$("#contents").addlink();
});
