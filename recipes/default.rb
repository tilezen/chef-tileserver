%w(
  tileserver::setup
  tileserver::deploy
).each do |r|
  include_recipe r
end
