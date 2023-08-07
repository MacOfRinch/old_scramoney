# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# coding: utf-8

# カテゴリ一覧データだよ。ここから各タスクをグループ化、カテゴリに仕分けるよ。
Category.create!(name: '家事')
Category.create!(name: '仕事')
Category.create!(name: '学校')
Category.create!(name: '勉強(科目ごと)')
Category.create!(name: 'ペット')
Category.create!(name: 'その他')

# 具体的な家事のタスクにはこんなものがあるよ。
Task.create!(title: '夕食の用意', category_name: :housework, points: 100)

# 仕事にはこんなのが考えられるよ。
Task.create(title: '出社・勤務開始', category_name: :work, points: 50)
Task.create(title: '業務', category_name: :work, points: 30)
Task.create(title: '残業', category_name: :work, points: 40)
Task.create(title: '会議出席', category_name: :work, points: 20)
Task.create(title: '会議発表', category_name: :work, points: 60)

# 学校に関するタスクの初期データだよ。
Task.create!(title: '登校', category_name: :school, points: 30)
Task.create!(title: '授業', category_name: :school, points: 20)
Task.create!(title: '部活：練習', category_name: :school, points: 20)
Task.create!(title: '部活：大会', category_name: :school, points: 100)
Task.create!(title: '部活：合宿', category_name: :school, points: 50)

# 勉強はこれでどうかな？
Task.create(title: '英語', category_name: :study, points: 30)
Task.create(title: '数学', category_name: :study, points: 40)
Task.create(title: '国語', category_name: :study, points: 30)
Task.create(title: '理科(中学)', category_name: :study, points: 20)
Task.create(title: '物理', category_name: :study, points: 30)
Task.create(title: '化学', category_name: :study, points: 25)
Task.create(title: '生物', category_name: :study, points: 30)
Task.create(title: '地学', category_name: :study, points: 15)
Task.create(title: '社会(中学)', category_name: :study, points: 20)
Task.create(title: '現代社会', category_name: :study, points: 25)
Task.create(title: '日本史', category_name: :study, points: 25)
Task.create(title: '世界史', category_name: :study, points: 30)
Task.create(title: '地理', category_name: :study, points: 30)
Task.create(title: '倫理社会', category_name: :study, points: 30)

# ペットのお世話は色々あるけど、代表的なものを書いていくね。
Task.create(title: 'ご飯・水の用意', category_name: :pet, points: 10)
Task.create(title: '散歩', category_name: :pet, points: 30)
Task.create(title: 'トイレシーツの交換', category_name: :pet, points: 10)
Task.create(title: '遊んであげる', category_name: :pet, points: 15)

# その他デフォルトで登録しときたいデータだよ。
