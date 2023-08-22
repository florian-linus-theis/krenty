require 'faker'

puts 'deleting all products from DB...'
Product.destroy_all

puts 'deleting all pruchases from DB...'
Purchase.destroy_all

puts 'Creating 10 new products...'

10.times do
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
end

puts 'finished'
