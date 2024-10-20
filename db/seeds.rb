# 管理者ユーザーを作成するためのシードデータ
User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "admin"
  user.password = "admin1234" 
  user.password_confirmation = "admin1234"
  user.role = 1  
end
