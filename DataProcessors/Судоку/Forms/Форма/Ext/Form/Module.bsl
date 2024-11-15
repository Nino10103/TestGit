﻿
&НаСервере
Процедура Стартовать()
	
	СоздатьГруппыНаФорме();
	
	ГСЧ = Новый ГенераторСлучайныхЧисел;
	Ур = Константы.МаксимальныйУровеньЗаполненностиПоля.Получить() - УровеньЗаполненностиПоля;
	Если Ур <= Константы.МинимальнаяЗаполненностьПоля.Получить() Тогда
		Ур = Константы.МинимальнаяЗаполненностьПоля.Получить();	
	КонецЕсли;
	
	КоличествоЯчеекВОднуСторону = 9;
	
	Для y = 1 По КоличествоЯчеекВОднуСторону Цикл
		
		Для x = 1 По КоличествоЯчеекВОднуСторону Цикл
			
			ИмяРеквизита = "X" + x + "Y" + y;
			
			СЧ = ГСЧ.СлучайноеЧисло(1,Ур);
			Если СЧ = 1 Тогда
				
				ЭтотОбъект[ИмяРеквизита] = ГСЧ.СлучайноеЧисло(1,КоличествоЯчеекВОднуСторону);
				РеквизитФормы = ЭтотОбъект[ИмяРеквизита];
				
				ЗаполнитьТаблицаЗначениямиСтрок(Строка(x),Строка(y));
				ЗаполнитьТаблицуЗначениямиБлока(x,y);
				
				СтруктураОтбора = Новый Структура("Значение", РеквизитФормы);
				Если ТаблицаЗначенийОтY.НайтиСтроки(СтруктураОтбора).Количество() > 1
					Или ТаблицаЗначенийОтX.НайтиСтроки(СтруктураОтбора).Количество() > 1
					Или  ТаблицаЗначенийОтБлока.НайтиСтроки(СтруктураОтбора).Количество() > 1 Тогда
					
					ЭтотОбъект[ИмяРеквизита] = 0;
					
				Иначе
					
					СтрокаТЧ = ТаблицаЗаполненных.Добавить();
					СтрокаТЧ.ИмяЭлемента = ИмяРеквизита;
					СтрокаТЧ.Значение = РеквизитФормы;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьГруппыНаФорме()
	
	Для y = 1 По 9 Цикл
		
		горГруппа = Элементы.Добавить("горГруппа" + y, Тип("ГруппаФормы"), Элементы.ГлавнаяГруппа);
		горГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		горГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
		горГруппа.ОтображатьЗаголовок = Ложь;
		
		СоздатьЯчейкиНаФорме(y, горГруппа);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьЯчейкиНаФорме(y, горГруппа)
	
	Для x = 1 По 9 Цикл
		
		ИмяРеквизита = "X" + x + "Y" + y;
		
		ДобавляемыеРеквизиты = Новый Массив;
		НовРеквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(1,0,ДопустимыйЗнак.Неотрицательный)));
		ДобавляемыеРеквизиты.Добавить(НовРеквизит);
		
		ЭтотОбъект.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
		
		НовЭлемент = Элементы.Добавить(ИмяРеквизита, Тип("ПолеФормы"), горГруппа);
		НовЭлемент.Вид = ВидПоляФормы.ПолеВвода;
		НовЭлемент.ПутьКДанным = ИмяРеквизита;
		НовЭлемент.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
		НовЭлемент.Ширина = 5;
		НовЭлемент.Высота = 2;
		НовЭлемент.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента.Центр;
		
		НовЭлемент.Шрифт = ШрифтыСтиля.Цифры;
		НовЭлемент.ЦветТекста = WebЦвета.Черный;
		
		НовЭлемент.УстановитьДействие("ПриИзменении", "ИзменениеПоля");

		УстановитьЦветЭлементу(x, y, НовЭлемент);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЦветЭлементу(x, y, НовЭлемент)
	
	Если ((x <= 3 или x >= 7) и (y <= 3 или y >= 7)) или ((x >= 4 и x <= 6) и (y >= 4 и y <= 6)) Тогда
		НовЭлемент.ЦветФона = WebЦвета.СветлоЖелтыйЗолотистый;
	Иначе
		НовЭлемент.ЦветФона = WebЦвета.БледноБирюзовый;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеПоля(Элемент)
	
	ОчиститьСообщения();
	
	ИзменениеПоляНаСервере(Элемент.Имя, ЭтотОбъект[Элемент.Имя]);
	
КонецПроцедуры

&НаСервере
Процедура ИзменениеПоляНаСервере(Знач ИмяЭлемента, ЗначениеЭлемента)
	
	МассивЗаполненного = ТаблицаЗаполненных.НайтиСтроки(Новый Структура("ИмяЭлемента", ИмяЭлемента));
	Если МассивЗаполненного.Количество() > 0 Тогда
		ЗначениеЭлемента = МассивЗаполненного[0].Значение;
		Сообщить("Нельзя изменять сгенерированное значение");
		Возврат;
	КонецЕсли;
	
	x = Сред(ИмяЭлемента, 2, 1);
	y = Сред(ИмяЭлемента, 4, 1);
	
	Отказ = Ложь;
	
	// Проверка по строке/колонке
	ЗаполнитьТаблицаЗначениямиСтрок(x, y);
	
	Если ТаблицаЗначенийОтY.НайтиСтроки(Новый Структура("Значение", ЗначениеЭлемента)).Количество() > 1
		Или ТаблицаЗначенийОтX.НайтиСтроки(Новый Структура("Значение", ЗначениеЭлемента)).Количество() > 1 Тогда
		
		Сообщить("" + ЗначениеЭлемента + " уже есть в пересечении");
		ЗначениеЭлемента = 0;
		Отказ = Истина;
		
	КонецЕсли;
	
	// Проверка в блоке
	ЗаполнитьТаблицуЗначениямиБлока(Число(x), Число(y));
	Если ТаблицаЗначенийОтБлока.НайтиСтроки(Новый Структура("Значение", ЗначениеЭлемента)).Количество() > 1 Тогда
		
		Сообщить("" + ЗначениеЭлемента + " уже есть в этом блоке");
		ЗначениеЭлемента = 0;
		Отказ = Истина;
		
	КонецЕсли;
	
	Если не Отказ Тогда
		Если ЭтоПобеда() Тогда
			Сообщить("Вы победили");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЭтоПобеда()
	
	Для y = 1 По 9 Цикл
		
		Для x = 1 По 9 Цикл
			
			ЗначениеЭлемента = ЭтотОбъект["X" + x + "Y" + y];
			Если ЗначениеЭлемента = 0 Тогда
				Возврат Ложь;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьТаблицаЗначениямиСтрок(x, y)
	
	ТаблицаЗначенийОтX.Очистить();
	ТаблицаЗначенийОтY.Очистить();
	
	Для i = 1 По 9 Цикл
		
		ЗначениеПоY = ЭтотОбъект["X" + i + "Y" + y];
		Если ЗначениеПоY = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаТЧ = ТаблицаЗначенийОтY.Добавить();
		СтрокаТЧ.Значение = ЗначениеПоY;
		
	КонецЦикла;
	
	Для i = 1 По 9 Цикл
		
		ЗначениеПоX = ЭтотОбъект["X" + x + "Y" + i];
		Если ЗначениеПоX = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаТЧ = ТаблицаЗначенийОтX.Добавить();
		СтрокаТЧ.Значение = ЗначениеПоX;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуЗначениямиБлока(x, y)
	
	ТаблицаЗначенийОтБлока.Очистить();
	
	Если x <= 3 Тогда
		МножительX = 1;
	ИначеЕсли x <= 6 Тогда
		МножительX = 2;
	Иначе
		МножительX = 3;
	КонецЕсли;
	
	Если y <= 3 Тогда
		МножительY = 1;
	ИначеЕсли y <= 6 Тогда
		МножительY = 2;
	Иначе 
		МножительY = 3;
	КонецЕсли;
	
	Для ЗначениеX = 1 + ((МножительX-1)*3) По 3 * МножительX Цикл
		
		Для ЗначениеY = 1 + ((МножительY-1)*3) По 3 * МножительY Цикл
			
			ЗначениеБлока = ЭтотОбъект["X" + ЗначениеX + "Y" + ЗначениеY];
			
			Если ЗначениеБлока = 0 Тогда
				Продолжить;	
			КонецЕсли;
			
			СтрокаТЧ = ТаблицаЗначенийОтБлока.Добавить();
			СтрокаТЧ.Значение = ЗначениеБлока;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Старт(Команда)
	Стартовать();
	Элементы.Старт.Доступность = Ложь;
КонецПроцедуры

&НаСервере
Процедура НоваяПроцедураДляGit()
	
	Сообщить("Привет, мир");
	
КонецПроцедуры
















