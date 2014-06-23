/**
 * writeNewsのJavaScript。記事を削除するときにdeleteNews.jspにデータを送信する処理と
 * 記事の表示非表示の処理を記述している。
 */

$(function() {

	$(document).ready(
			function() {
				/* チェックボックスにチェックがついたかを判別する */
				// 記事が選択されていない時は削除ボタンを押せないようにする。
				$("table :checkbox").click(function(){
					if($(".uk-table :checked").length > 0){
						$("#delete_button").prop('disabled', false);
					}else{
						$("#delete_button").prop('disabled', true);
					}
				});
				
				/* 記事を削除するdeleteNews.jspに記事にIDを渡す関数 */
				$("#delete_button").click(
						function() {
							// 削除をクリックされると確認ダイヤログを表示するOKが押されるとif文の中を実行
							if (confirm('選択された記事をすべて削除してもいいですか?')) {
								var ids = [];
								// 削除する記事のIDを格納した配列を生成
								$("table :checked").each(function(){
									ids.push($(this).attr("id"));
								});
								if ($(".uk-table :checked").length == 0) {
									// 記事が選択されていない場合にエラーメッセージを表示する
									notif({
										type : "error",
										msg : "記事が選択されていません!",
										position : "center",
										width : 500,
										height : 60,
										timeout : 2000
									});
								} else {
									// IDを格納した配列をDeleteNewsにPOST送信
									$.ajax({
										type : "POST",
										url : "/staff_room/DeleteNews",
										cache: false,
										data : {
											// 配列を区切り文字","の文字列に変換
											// 例:[1,2,3,]→"1,2,3"
											"del_id" : "" + ids
										}
									// 送信に成功した時にする処理
									}).done(function() {
										notif({
											type : "success",
											msg : "削除しました!",
											position : "center",
											width : 500,
											height : 60,
											timeout : 2000
										});
										for(var i = 0; i < ids.length; i++){
											$("#row" + ids[i]).remove();
										}
										$("#delete_button").prop('disabled', true);
									});
								}
							}
						});
			});

});