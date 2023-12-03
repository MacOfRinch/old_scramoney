# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# coding: utf-8

# カテゴリ一覧データだよ。ここから各タスクをグループ化してカテゴリとして仕分けるよ。
Category.find_or_create_by(name: '家事')
Category.find_or_create_by(name: '仕事')
Category.find_or_create_by(name: '勉強(仕事・資格)')
Category.find_or_create_by(name: '学校')
Category.find_or_create_by(name: '勉強(学校)')
Category.find_or_create_by(name: 'ペット')
Category.find_or_create_by(name: 'その他', created_at: 'Fri, 31 Dec 9999 23:59:59.999999999')

# 具体的な家事のタスクにはこんなものがあるよ。もちろん暫定だよ。
Task.find_or_create_by(title: '朝食の用意', category_name: :housework, points: 30)
Task.find_or_create_by(title: '昼食の用意', category_name: :housework, points: 25)
Task.find_or_create_by(title: '夕食の用意', category_name: :housework, points: 40)
Task.find_or_create_by(title: '食事の後片付け', category_name: :housework, points: 20)
Task.find_or_create_by(title: '買い出し', description: '目安として3〜4日分の食料品、生活必需品等の買い出し', category_name: :housework, points: 50)
Task.find_or_create_by(title: 'ゴミ出し', category_name: :housework, points: 10)
Task.find_or_create_by(title: '掃除機がけ', description: 'コロコロなども含む', category_name: :housework, points: 30)
Task.find_or_create_by(title: '洗濯', category_name: :housework, points: 25)

# 仕事にはとりあえずこんなのが考えられるかな。
Task.find_or_create_by(title: '出社・勤務開始', category_name: :work, points: 50)
Task.find_or_create_by(title: '業務', category_name: :work, points: 20)
Task.find_or_create_by(title: '残業', category_name: :work, points: 20)
Task.find_or_create_by(title: '会議出席', category_name: :work, points: 20)
Task.find_or_create_by(title: '会議発表', category_name: :work, points: 50)
Task.find_or_create_by(title: '出張', category_name: :work, points: 50)

# 仕事や資格に繋がる勉強の項目だよ。多すぎて書けないよ。好きに作ってもらうよ。
Task.find_or_create_by(title: '英語(TOEIC等)', category_name: :study_work, points: 20)
Task.find_or_create_by(title: '資格の勉強', category_name: :study_work, points: 30)
Task.find_or_create_by(title: '仕事の勉強', category_name: :study_work, points: 30)

# 学校に関するタスクの初期データだよ。
Task.find_or_create_by(title: '登校', category_name: :school, points: 30)
Task.find_or_create_by(title: '授業1コマ', category_name: :school, points: 10)
Task.find_or_create_by(title: 'テスト1教科', category_name: :school, points: 20)
Task.find_or_create_by(title: '部活：練習1時間', category_name: :school, points: 10)
Task.find_or_create_by(title: '部活：大会', category_name: :school, points: 100)
Task.find_or_create_by(title: '部活：合宿', category_name: :school, points: 200)

# 勉強はこれでどうかな？重要科目っぽいのは高得点にするよ。
Task.find_or_create_by(title: '英語', category_name: :study, points: 20)
Task.find_or_create_by(title: '数学', category_name: :study, points: 20)
Task.find_or_create_by(title: '国語', category_name: :study, points: 15)
Task.find_or_create_by(title: '理科(中学)', category_name: :study, points: 10)
Task.find_or_create_by(title: '物理', category_name: :study, points: 15)
Task.find_or_create_by(title: '化学', category_name: :study, points: 15)
Task.find_or_create_by(title: '生物', category_name: :study, points: 15)
Task.find_or_create_by(title: '地学', category_name: :study, points: 10)
Task.find_or_create_by(title: '社会(中学)', category_name: :study, points: 10)
Task.find_or_create_by(title: '現代社会', category_name: :study, points: 15)
Task.find_or_create_by(title: '日本史', category_name: :study, points: 15)
Task.find_or_create_by(title: '世界史', category_name: :study, points: 15)
Task.find_or_create_by(title: '地理', category_name: :study, points: 15)
Task.find_or_create_by(title: '倫理社会', category_name: :study, points: 20)
Task.find_or_create_by(title: 'テスト勉強', description: '教科に関わらず定期試験に関わる勉強はこちら。頑張れ！', category_name: :study, points: 20)
Task.find_or_create_by(title: '受験勉強', description: '教科に関わらず入学試験に関わる勉強はこちら。めっちゃ頑張れ！', category_name: :study, points: 30)

# ペットのお世話は色々あるけど、代表的なものを書いていくね。
Task.find_or_create_by(title: 'ご飯・水の用意', category_name: :pet, points: 10)
Task.find_or_create_by(title: '散歩', category_name: :pet, points: 30)
Task.find_or_create_by(title: 'トイレシーツの交換', category_name: :pet, points: 10)
Task.find_or_create_by(title: '玩具で遊ぶ', category_name: :pet, points: 15)

# その他デフォルトで登録しときたいデータだよ。
Task.find_or_create_by(title: '虫退治', category_name: :extra, points: 50)
Task.find_or_create_by(title: '筋トレ', category_name: :extra, points: 20)

# ゲストログイン用のダミー家族を作成するよ。
Family.find_or_create_by(id: 0000000000000000, family_name: 'ゲスト', family_nickname: 'ゲストファミリー', budget: 100_000, budget_of_last_month: 75_000)

users = [
  {family_id: 0000000000000000, name: 'ゲス太郎', nickname: 'パパ', email: 'papa@example.com', password: "#{ENV['GUEST_PASSWORD']}", password_confirmation: "#{ENV['GUEST_PASSWORD']}"},
  {family_id: 0000000000000000, name: 'ゲス華子', nickname: 'ママ', email: 'mama@example.com', password: "#{ENV['GUEST_PASSWORD']}", password_confirmation: "#{ENV['GUEST_PASSWORD']}"},
  {family_id: 0000000000000000, name: 'ゲスト', nickname: 'ゲスト', email: 'guestuser@example.com', password: "#{ENV['GUEST_PASSWORD']}", password_confirmation: "#{ENV['GUEST_PASSWORD']}"}, 
  {family_id: 0000000000000000, name: 'ゲス弟', nickname: '次郎', email: 'ramenjiro@example.com', password: "#{ENV['GUEST_PASSWORD']}", password_confirmation: "#{ENV['GUEST_PASSWORD']}"}
]
users.each do |user|
  User.create!(user)
end

# papa = User.find_by(family_id: 0000000000000000, email: 'papa@example.com')
# mom = User.find_by(family_id: 0000000000000000, email: 'mama@example.com')
# guest = User.find_by(family_id: 0000000000000000, email: 'guestuser@example.com')
# bros = User.find_by(family_id: 0000000000000000, email: 'ramenjiro@example.com')