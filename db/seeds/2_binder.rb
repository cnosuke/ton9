#coding:utf-8
binder_sets = ["has-key","shacho","opentaka.binder","mikusan"]
user_sets = ['moosan','cnosuke','wishid','rkmathi']
doc_sets = ["アジャイルサムライ","リーダブルコード","ノンデザイナーズ・デザインブック","真夏の夜の淫夢","百年法","シフト表"]

binder_sets.each do |binder|
  puts "binder sets create"
  binder = Binder.new(:name => binder)
  User.all.each do |user|
    binder.users << user
  end
  
  Document.where(:user_id => User.where(:name => 'moosan' )).each do |document|
    binder.documents << document
  end
  
  binder.save
end
puts "binder sets created"
