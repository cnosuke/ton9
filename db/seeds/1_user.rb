#coding:utf-8
name_sets = ['moosan','cnosuke','wishid','rkmathi','opentaka']
doc_sets = ["アジャイルサムライ","リーダブルコード","ノンデザイナーズ・デザインブック","真夏の夜の淫夢","百年法","シフト表","おーぷんたかのひとりごと"]

name_sets.each do |name|
  puts "creating #{name} data sets"
   user = User.new({ 
             "email"=>"#{name}@example.com",
             "password"=>"foofoo",
             "password_confirmation"=>"foofoo",
             "name"=>"#{name}"
           })

  doc_sets.each do |doc|
    user.documents << Document.new( :title => doc )
  end

  user.save
end
puts 'created all user data sets'
