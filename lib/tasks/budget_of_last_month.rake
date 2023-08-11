namespace :budget_of_last_month do
  desc '先月末のお小遣い総額を保存しておくよ。毎月末に定期実行するつもりだよ。'
  task get: :environment do
    families = Family.all
    families.each do |family|
      family.update_column(:budget_of_last_month, family.budget)
    end
  end
end
