# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# coding: utf-8

# カテゴリ一覧データだよ。ここから各タスクをグループ化してカテゴリとして仕分けるよ。
Category.create!(name: '家事')
Category.create!(name: '仕事')
Category.create!(name: '勉強(仕事・資格)')
Category.create!(name: '学校')
Category.create!(name: '勉強(学校)')
Category.create!(name: 'ペット')
Category.create!(name: 'その他', created_at: 'Fri, 31 Dec 9999 23:59:59.999999999')

# 具体的な家事のタスクにはこんなものがあるよ。もちろん暫定だよ。
Task.create(title: '朝食の用意', category_name: :housework, points: 30)
Task.create(title: '昼食の用意', category_name: :housework, points: 25)
Task.create(title: '夕食の用意', category_name: :housework, points: 40)
Task.create(title: '食事の後片付け', category_name: :housework, points: 20)
Task.create(title: '買い出し', description: '目安として3〜4日分の食料品、生活必需品等の買い出し', category_name: :housework, points: 50)
Task.create(title: 'ゴミ出し', category_name: :housework, points: 10)
Task.create(title: '掃除機がけ', description: 'コロコロなども含む', category_name: :housework, points: 30)
Task.create(title: '洗濯', category_name: :housework, points: 25)

# 仕事にはとりあえずこんなのが考えられるかな。
Task.create(title: '出社・勤務開始', category_name: :work, points: 50)
Task.create(title: '業務', category_name: :work, points: 10)
Task.create(title: '残業', category_name: :work, points: 20)
Task.create(title: '会議出席', category_name: :work, points: 20)
Task.create(title: '会議発表', category_name: :work, points: 50)
Task.create(title: '出張', category_name: :work, points: 50)

# 仕事や資格に繋がる勉強の項目だよ。多すぎて書けないよ。好きに作ってもらうよ。
Task.create(title: '英語(TOEIC等)', category_name: :study_work, points: 15)
Task.create(title: '資格の勉強', category_name: :study_work, points: 20)
Task.create(title: '仕事の勉強', category_name: :study_work, points: 20)

# 学校に関するタスクの初期データだよ。
Task.create(title: '登校', category_name: :school, points: 30)
Task.create(title: '授業1コマ', category_name: :school, points: 10)
Task.create(title: 'テスト1教科', category_name: :school, points: 20)
Task.create(title: '部活：練習1時間', category_name: :school, points: 10)
Task.create(title: '部活：大会', category_name: :school, points: 100)
Task.create(title: '部活：合宿', category_name: :school, points: 200)

# 勉強はこれでどうかな？重要科目っぽいのは高得点にするよ。
Task.create(title: '英語', category_name: :study, points: 20)
Task.create(title: '数学', category_name: :study, points: 20)
Task.create(title: '国語', category_name: :study, points: 15)
Task.create(title: '理科(中学)', category_name: :study, points: 10)
Task.create(title: '物理', category_name: :study, points: 15)
Task.create(title: '化学', category_name: :study, points: 15)
Task.create(title: '生物', category_name: :study, points: 15)
Task.create(title: '地学', category_name: :study, points: 10)
Task.create(title: '社会(中学)', category_name: :study, points: 10)
Task.create(title: '現代社会', category_name: :study, points: 15)
Task.create(title: '日本史', category_name: :study, points: 15)
Task.create(title: '世界史', category_name: :study, points: 15)
Task.create(title: '地理', category_name: :study, points: 15)
Task.create(title: '倫理社会', category_name: :study, points: 20)
Task.create(title: 'テスト勉強', description: '教科に関わらず定期試験に関わる勉強はこちら。頑張れ！', category_name: :study, points: 20)
Task.create(title: '受験勉強', description: '教科に関わらず入学試験に関わる勉強はこちら。めっちゃ頑張れ！', category_name: :study, points: 30)

# ペットのお世話は色々あるけど、代表的なものを書いていくね。
Task.create(title: 'ご飯・水の用意', category_name: :pet, points: 10)
Task.create(title: '散歩', category_name: :pet, points: 30)
Task.create(title: 'トイレシーツの交換', category_name: :pet, points: 10)
Task.create(title: '玩具で遊ぶ', category_name: :pet, points: 15)

# その他デフォルトで登録しときたいデータだよ。
Task.create(title: '虫退治', category_name: :extra, points: 50)
Task.create(title: '筋トレ', category_name: :extra, points: 20)