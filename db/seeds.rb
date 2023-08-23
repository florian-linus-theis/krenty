require 'faker'

puts 'deleting all product photos...'
Product.all.each do |product|
  product.photos.each(&:purge) if product.photos.attached?
end

puts 'deleting all products from DB...'
Product.destroy_all

puts 'deleting all pruchases from DB...'
Purchase.destroy_all

puts 'Creating 5 new products...'

5.times do
  product = Product.new(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price,
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    category: 'accessories',
    user_id: 1
  )
  product.photos.attach(
    io: File.open(Rails.root.join('app/assets/images/bugaboo.jpg')),
    filename: 'kinderwagen',
    content_type: 'image/jpg'
  )
  product.photos.attach(
    io: File.open(Rails.root.join('app/assets/images/der-kinderwagen.jpg')),
    filename: 'kinderwagen 2',
    content_type: 'image/jpg'
  )
  product.save
end

puts 'finished'
