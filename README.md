Установка:
  bundle
  rake db:create
  rake db:migrate
  rake db:seed

Теперь открываем в браузере http://localhost:3000 и вводим:
  Имя: admin
  Пароль: admin

Тестируем так:
  rake db:migrate RAILS_ENV=test
  rake test