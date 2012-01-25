# Seed with dummy deletions.

5.times do
  Deletion.create!(:name => "Seeder", :fbid => "1234567890", :user_id => "1")
end


5.times do
  Deletion.create!(:name => "Seeder", :fbid => "1234567890", :user_id => "20")
end


