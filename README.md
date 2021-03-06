# PhotoBucket

 

## Технологии

```ruby
UIKit
```
```ruby
UICollectionView
```
```ruby
UITableView
```
```ruby
Realm
```

## Установка

### CocoaPods

```ruby
pod 'RealmSwift', '~>10'
```

## Описание 

Стартовый экран — таббар с двумя вкладками.

На первой вкладке — коллекция случайных фотографий с Unsplash. Вверху строка поиска по фотографиям с Unsplash. При нажатии на ячейку пользователь попадает на экран подробной информации.

На второй вкладке — таблица со списком любимых фотографий,
в ячейке миниатюрка фотографии и имя автора. При нажатии на ячейку — переход в экран подробной информации.

Экран подробной информации содержит в себе:
- количество лайков
- фотографию
- имя автора
- местоположение
- дату создания

Также экран содержит кнопку, нажатие на которую может добавить фотографию в список любимых фотографий и удалить из него. 
При нажатии вызывается Алерт подтверждающий запрос.
И кнопку выхода экрана.

## API

https://unsplash.com/documentation

## Примеры

![Simulator Screen Shot - iPhone 8 - 2022-05-19 at 13 04 37](https://user-images.githubusercontent.com/79254522/169286231-f7e4e879-e915-41eb-9525-18e5869bc7d4.png)



![Simulator Screen Shot - iPhone 8 - 2022-05-19 at 13 05 00](https://user-images.githubusercontent.com/79254522/169286226-86d61f9f-22bb-427d-adc8-1d4a00edeb05.png)




![Simulator Screen Shot - iPhone 8 - 2022-05-19 at 13 04 56](https://user-images.githubusercontent.com/79254522/169286208-ce2f0540-0b3f-487e-a931-10e07835d486.png)


![Simulator Screen Shot - iPhone 8 - 2022-05-19 at 13 05 07](https://user-images.githubusercontent.com/79254522/169286221-2a31372b-a0b8-4db4-a0ea-1489a9e7b348.png)
