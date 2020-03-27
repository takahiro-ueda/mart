document.addEventListener(
  'DOMContentLoaded', (e) => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_43e2e13c79bc27b1ce6ee5f3"); //ここに公開鍵を直書き
      var btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
      btn.addEventListener('click', function(e) { //ボタンが押されたときに作動します
        e.preventDefault(); //ボタンを一旦無効化します
        var card = {
          number: document.getElementById('card_number').value,
          cvc: document.getElementById('cvc').value,
          exp_month: document.getElementById('exp_month').value,
          exp_year: document.getElementById('exp_year').value
        }; //入力されたデータを取得します。
        // Payjp.createToken(card, function(s, response) {
        //   document.getElementById('result').innerText = 'Token = ' + response.id;
        // });

        console.log("OK 2回目");
        Payjp.createToken(card, function(status, response) {
          // document.getElementById('result').innerText = 'Token = ' + response.id;
          console.log(response);
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#card_token").append(
              $('<input type="hidden" name="payjp_token">').val(response.id)
            ); //取得したトークンを送信できる状態にします
            document.inputForm.submit();
            alert("登録が完了しました"); //確認用
          } else {
            alert("カード情報が正しくありません。"); //確認用
          }
        });
      });
    }
  },
  false
);




// $(function() {
//   var form = $("#charge-form");
//   Payjp.setPublicKey('pk_test_43e2e13c79bc27b1ce6ee5f3'); //(自身の公開鍵)

//   $("#charge-form").on("click", "#token_submit", function(e) {
//     console.log("fire1");
//     e.preventDefault();
//     form.find("input[type=submit]").prop("disabled", true);
//     var card = {
//         number: parseInt($("#number").val()),
//         cvc: parseInt($("#cvc").val()),
//         exp_month: parseInt($("#exp_month").val()),
//         exp_year: parseInt($("#exp_year").val())
        
//     };
//     console.log(card);


//     Payjp.createToken(card, function(status, response) {
//                 console.log("fire2");
//                 if (status === 200) { //成功した場合
//                   $("#number").removeAttr("name");
//                   $("#cvc").removeAttr("name");
//                   $("#exp_month").removeAttr("name");
//                   $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
//                   $("#token_submit").append(
//                     $('<input type="hidden" name="payjp-token">').val(response.id)
//                   ); //取得したトークンを送信できる状態にします
//                   console.log(response.id);
//                   $("#charge-form").get(0).submit();
//                   // document.inputForm.submit();
//                   alert("登録が完了しました"); //確認用
//                 } else {
//                   alert("カード情報が正しくありません。"); //確認用
//                 }
//               });

//   });
// });