■ サービス概要
- 誰にも褒められないから家事をやる気が出ない主婦(夫)や、お小遣いを増やしたい学生などに
- お小遣いの取り合いを通じて努力を続けつつ、互いに認め合うきっかけを作るために
- それぞれの頑張りを見える化し、モチベーションの維持をお手伝いするサービスです。

■ユーザーが抱える課題
- 仕事や家事をいくら頑張っても身内から評価されない(会社での仕事の評価とは別)
  - 結果、モチベーションが低下する
- 本当は色々考えて頑張っているのに、家で何もしていないと思われがち

■課題に対する仮説
- それぞれが何を頑張っていて、どんな成果が上がったのか周りから見えづらい
  - 明確な報酬がないためモチベーションが続かない

■解決方法
- その月の予算からお小遣いの総額を決めておいて、努力に応じて振り分ける
  - メンバーの合意の元、ポイント制で誰が何をすると何ポイントもらえるかを決める
    - (例：夕食の皿洗いなら20pt、それを子供が行った場合は30pt、会社や学校に行ったら50pt、残業や部活は1hごとに10ptなど)
  - ポイントを履歴に残した上でその割合をお小遣いの振り分けとすることで、目に見えない努力の見える化と明確な報酬を設ける

■メインのターゲットユーザー
- 中高生のいる家庭、主婦
  - 自分の夢のため、あるいは家族のために頑張るモチベーションを上げるお手伝いをする

■実装予定の機能
- 登録済みのユーザーは同居している家族やパートナーをユーザーとして招待・登録できる
    - デフォルトのタスクおよびポイントの設定
        - 主な家事(掃除、洗濯、皿洗い、買い物、etc...)や会社での仕事、登校などをデフォルトで設定しておく
        - 話し合いによってポイントは自由に変えられるようにする
    - 各ユーザーは新しいタスクとそのpt数を設定できる
        - そのタスクについて連携しているユーザー(家族)に承認依頼が送られる
        - 全員の承認が通れば新しいタスクとして登録される
            - 承認しない場合、理由をコメントできる
        - 同じタスクでも人によって取得ptを変えたい場合、ユーザーに紐づいたタスクとして登録できる
            - 共通タスクと個別タスクの二つが存在し、記録時に選択できるようにする(本番リリース時実装予定)

- メニューバーをアプリ画面下部に設置
    - ホーム：今月のお小遣い総額やメンバーの現時点でのポイント取得状況(割合：円グラフ)、お小遣い(額：棒グラフ、1,000円単位)を表示
    - 履歴　：「誰が」「いつ」「何を」して「何pt」取得したか日付・時間順に表示
    - 記録　：各ユーザーが行ったタスクをDBに保存
    - 登録　：各ユーザーは新しいタスクを登録するための承認申請ができる。また、登録済みのタスクの中から日常的に行うタスク(出勤や登校など)を登録できる
    　　　　　→毎回記録する手間を省くため
    - 設定　：家族の招待や通知、当月のお小遣いに関する設定

■なぜこのサービスを作りたいのか？
- それぞれの頑張りが見えづらく、頑張っても「(社会人・主婦・学生なら)当たり前だ」として評価されない家庭がある
  - それぞれのやったことを見える化することで、評価される仕組みを作る
- 報酬をお小遣いとすることで具体性を出し、モチベーションを高める

■スケジュール
- 企画〜技術調査：5/31〆切
- README〜ER図作成：6/5 〆切
- メイン機能実装：6/6 - 7/30
- β版をRUNTEQ内リリース（MVP）：8/1〆切
- 本番リリース：8/15

■技術選定(暫定)
- 開発環境
  - Docker
- サーバーサイド
  - Ruby3.1.4
  - Rails7.0.4(Ruby3.1をサポートし、HotWireが標準で入っている)
- データベース
  - MySQL2
- 描画
  - JavaScript
  - HotWire
- デプロイ関係
  - heroku
  - PWA(RailsのWebアプリをネイティブアプリ風に表示)
