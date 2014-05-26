/**
 * 
 */

$(function() {

	$(document).ready(
			function() {
				/* チェックボックスにチェックがついたかを判別する */
				$('[name="delete_check"]').click(
						function() {
							var checkbox = $("#" + $(this).attr("id"));
							if (checkbox.attr("flag") === "0") {
								checkbox.attr("flag", "1");
								$("#" + checkbox.attr("id")).attr("class",
										"uk-icon-check-square-o");
							} else {
								checkbox.attr("flag", "0");
								$("#" + checkbox.attr("id")).attr("class",
										"uk-icon-square-o");
							}
						});

				/* 記事を削除するdeleteNews.jspに記事にIDを渡す関数 */
				$("#delete_button").click(
						function() {
							// 削除をクリックされると確認ダイヤログを表示するOKが押されるとif文の中を実行
							if (confirm('選択された記事をすべて削除してもいいですか?')) {
								var f = -1;
								var ids = [];
								// class=delete_checkのついてるタグをすべて取得
								var news = $('[name="delete_check"]');
								// 削除する記事のIDを格納した配列を生成
								for (var n = 0; n < news.length; n++) {
									// チェックボックスにチェックがついていたらIDを配列に格納
									if (news[n].getAttribute("flag") == "1") {
										ids.push(news[n].getAttribute("id"));
										f = 1;
										// 削除する記事を隠す
										$("#row" + news[n].getAttribute("id"))
												.fadeOut();
									}
								}

								if (f == -1) {
									notif({
										type: "error",
										  msg: "記事が選択されていません!",
										  position: "center",
										  width: 500,
										  height: 60,
										  timeout: 2000
									});
								} else {
									// IDを格納した配列をdeleteNews.jspにPOST送信
									$.ajax({
										type : "POST",
										url : "deleteNews.jsp",
										data : {
											// 配列を区切り文字","の文字列に変換
											// 例:[1,2,3,]→"1,2,3"
											"del_id" : "" + ids
										}
									}).done(function() {
										notif({
											type: "success",
											  msg: "削除しました!",
											  position: "center",
											  width: 500,
											  height: 60,
											  timeout: 2000
										});
									});
								}
							}
						});
				$(".body-text").css("display", "none");
				$(".body-title").click(function() {
					$("#text"+$(this).attr("t_id")).toggle();
				});
			});

});