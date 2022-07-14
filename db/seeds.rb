category_service = {
  'Техническое обслуживание': [
    'Замена моторного масла',
    'Техническое обслуживание "ТО Стандарт"',
    'Техническое обслуживание "ТО Оптима"',
  ],
  'Ремонт тормозной системы': [
    'ДИАГНОСТИКА ТОРМОЗНОЙ СИСТЕМЫ БЕСПЛАТНО',
    'Замена передних тормозных колодок',
    'Замена задних тормозных колодок',
  ],
  'Ремонт подвески': [
    'ДИАГНОСТИКА ПОДВЕСКИ БЕСПЛАТНО',
    'Замена втулок стабилизатора',
    'Замена задних амортизаторов',
  ],
}

[
  'Ширяев Вадим Даниилович',
  'Виноградова Арина Германовна',
  'Кондрашов Марк Семёнович',
  'Колесников Даниил Артёмович',
  'Васильева Анастасия Николаевна',
  'Черный Александр Демидович',
].each do |item|
  Worker.create(name: item)
end

category_service.each do |category, services|
  new_category = Category.create(name: category)

  services.each do |service|
    Service.create(name: service, category: new_category)
  end
end

customer_names = [
  'Кузьмина Варвара Ивановна',
  'Попова Ксения Денисовна',
  'Егорова Вероника Демидовна',
  'Агафонов Сергей Кириллович',
  'Максимов Никита Андреевич',
  'Волкова Кира Егоровна',
]

workers = Worker.all
services = Service.all.shuffle

1.upto(20).each do |n|
  Order.create(
    created_at: Time.at(rand * Time.now.to_i),
    customer_name: customer_names.sample,
  )
end

orders = Order.all

orders.each do |order|
  1.upto(rand(1..3)).each do |_|
    order_item = OrderItem.create(
      worker: workers.sample,
      service: services.sample
    )
    order.order_items.push(order_item)
  end
end
