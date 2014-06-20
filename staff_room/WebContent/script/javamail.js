/**
 * メーラーを起動してメールを送信する
 */

window.onload = function() {

    /**
   * メールに記載する情報を格納する変数
   */
    var address, ccAddress, subject, body, hiddenData;
    var sendmail = document.getElementById('mail');

    sendmail.onclick = function() {

        // メールに記載したい情報をhiddenタグから取得
        hiddenData = document.getElementById('hidden_data').value;
        address = 'na-akiyama@lucentsquare.co.jp; h-azuma@lucentsquare.co.jp; h-abe@lucentsquare.co.jp; y-arai@lucentsquare.co.jp; m-arase@lucentsquare.co.jp; k-ieta@lucentsquare.co.jp; a-ishii@lucentsquare.co.jp; a-ishioka@lucentsquare.co.jp; h-ishigamori@lucentsquare.co.jp; s-ide@lucentsquare.co.jp; a-inoue@lucentsquare.co.jp; n-inomata@lucentsquare.co.jp; t-imai@lucentsquare.co.jp; n-iwai@lucentsquare.co.jp; n-iwasaki@lucentsquare.co.jp; h-iwashina@lucentsquare.co.jp; s-iwamoto@lucentsquare.co.jp; j-ueda@lucentsquare.co.jp; t-uchiumi@lucentsquare.co.jp; t-umejima@lucentsquare.co.jp; k-ohshima@lucentsquare.co.jp; k-ohyama@lucentsquare.co.jp; a-ogasawara@lucentsquare.co.jp; y-okajima@lucentsquare.co.jp; k-okabe@lucentsquare.co.jp; k-ogawa@lucentsquare.co.jp; t-okuhira@lucentsquare.co.jp; k-ozawa@lucentsquare.co.jp; t-obara@lucentsquare.co.jp; m-katakura@lucentsquare.co.jp; y-katoh@lucentsquare.co.jp; r-katoh@lucentsquare.co.jp; t-kamei@lucentsquare.co.jp; r-kawata@lucentsquare.co.jp; k-kawahashi@lucentsquare.co.jp; y-kawabata@lucentsquare.co.jp; s-kawamura@lucentsquare.co.jp; j-kikuchi@lucentsquare.co.jp; h-kumoda@lucentsquare.co.jp; n-kuroda@lucentsquare.co.jp; a-kuwajima@lucentsquare.co.jp; k-kouma@lucentsquare.co.jp; s-gotoh@lucentsquare.co.jp; m-gotoh@lucentsquare.co.jp; ke-kobayashi@lucentsquare.co.jp; m-kobayashi@lucentsquare.co.jp; f-komatsu@lucentsquare.co.jp; to-saitoh@lucentsquare.co.jp; tomoyoshi@lucentsquare.co.jp; s-sakamoto@lucentsquare.co.jp; o-sasaki@lucentsquare.co.jp; k-sasaki@lucentsquare.co.jp; m-sasaki@lucentsquare.co.jp; y-sasayama@lucentsquare.co.jp; e-satoh@lucentsquare.co.jp; t-satoh@lucentsquare.co.jp; n-satoh@lucentsquare.co.jp; m-satoh@lucentsquare.co.jp; y-satoh@lucentsquare.co.jp; n-sano@lucentsquare.co.jp; m-shiina@lucentsquare.co.jp; t-shibaki@lucentsquare.co.jp; m-kurosaki@lucentsquare.co.jp; e-shibamura@lucentsquare.co.jp; h-shibui@lucentsquare.co.jp; t-shimada@lucentsquare.co.jp; m-shimizu@lucentsquare.co.jp; m-shimohara@lucentsquare.co.jp; m-shiraga@lucentsquare.co.jp; t-shirase@lucentsquare.co.jp; m-sugawara@lucentsquare.co.jp; yuk-suzuki@lucentsquare.co.jp; r-suzuki@lucentsquare.co.jp; k-seto';
        ccAddress = 'sub@co.jp';
        subject = '件名';
        body = '本文' + '%0D%0A' + hiddenData; // 「'%0D%0A'」を入れて改行

        // 「'?cc='」部分でCC追加
        location.href = 'mailto:' + address + '?cc=' + ccAddress + '&subject=' + subject + '&body=' + body;
    };

};
