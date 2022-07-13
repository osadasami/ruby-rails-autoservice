data = {
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

['Ширяев Вадим Даниилович', 'Виноградова Арина Германовна', 'Кондрашов Марк Семёнович'].each do |item|
  Worker.create(name: item)
end

data.each do |category, services|
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

1.upto(100).each do |n|
  Order.create(
    created_at: Time.at(rand * Time.now.to_i),
    customer_name: customer_names.sample,
    worker: workers.sample,
    services: services.sample(rand(1..3))
  )
end
