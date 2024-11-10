﻿
&НаСервере
Процедура Стартовать()
	
	ГСЧ = Новый ГенераторСлучайныхЧисел;
	
	Для y = 1 По 9 Цикл
		
		горГруппа = Элементы.Добавить("горГруппа" + y, Тип("ГруппаФормы"), Элементы.ГлавнаяГруппа);
		горГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		горГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
		горГруппа.ОтображатьЗаголовок = Ложь;
		
		Для x = 1 По 9 Цикл
			
			ИмяРеквизита = "X" + x + "Y" + y;
			
			ДобавляемыеРеквизиты = Новый Массив;
			НовРеквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("Число", Новый КвалификаторыЧисла(1,0,ДопустимыйЗнак.Неотрицательный)));
			ДобавляемыеРеквизиты.Добавить(НовРеквизит);
			
			ЭтаФорма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
			
			НовЭлемент = Элементы.Добавить(ИмяРеквизита, Тип("ПолеФормы"), горГруппа);
			НовЭлемент.Вид = ВидПоляФормы.ПолеВвода;
			НовЭлемент.ПутьКДанным = ИмяРеквизита;
			НовЭлемент.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
			НовЭлемент.Ширина = 5;
			НовЭлемент.Высота = 2;
			НовЭлемент.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента.Центр;
			
			НовЭлемент.Шрифт = Новый Шрифт(,11,Истина);
			НовЭлемент.ЦветТекста = WebЦвета.Черный;
			
			НовЭлемент.УстановитьДействие("ПриИзменении", "ИзменениеПоля");
			
			Если ((x <= 3 или x >= 7) и (y <= 3 или y >= 7)) или ((x >= 4 и x <= 6) и (y >= 4 и y <= 6)) Тогда
				НовЭлемент.ЦветФона = WebЦвета.СветлоЖелтыйЗолотистый;
			Иначе
				НовЭлемент.ЦветФона = WebЦвета.БледноБирюзовый;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Ур = 15 - УровеньЗаполненностиПоля;
	
	Для y = 1 По 9 Цикл
		
		Для x = 1 По 9 Цикл
			
			ИмяРеквизита = "X" + x + "Y" + y;
			
			СЧ = ГСЧ.СлучайноеЧисло(1,Ур);
			Если СЧ = 1 Тогда
				
				ЭтаФорма[ИмяРеквизита] = ГСЧ.СлучайноеЧисло(1,9);
				РеквизитФормы = ЭтаФорма[ИмяРеквизита];
				
				ЗаполнитьТаблицаЗначениямиСтрок(Строка(x),Строка(y));
				ЗаполнитьТаблицуЗначениямиБлока(x,y);
				
				Если ТаблицаЗначенийОтY.НайтиСтроки(Новый Структура("Значение", РеквизитФормы)).Количество() > 1
					Или ТаблицаЗначенийОтX.НайтиСтроки(Новый Структура("Значение", РеквизитФормы)).Количество() > 1
					Или  ТаблицаЗначенийОтБлока.НайтиСтроки(Новый Структура("Значение", РеквизитФормы)).Количество() > 1 Тогда
					
					ЭтаФорма[ИмяРеквизита] = 0;
					
				Иначе
					
					СтрокаТЧ = ТаблицаЗаполненных.Добавить();
					СтрокаТЧ.ИмяЭлемента = ИмяРеквизита;
					СтрокаТЧ.Значение = РеквизитФормы;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеПоля(Элемент)
	
	ОчиститьСообщения();
	
	ИзменениеПоляНаСервере(Элемент.Имя, ЭтаФорма[Элемент.Имя]);
	
КонецПроцедуры

&НаСервере
Процедура ИзменениеПоляНаСервере(ИмяЭлемента, ЗначениеЭлемента)
	
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

Функция ЭтоПобеда()
		
	Для y = 1 По 9 Цикл
		
		Для x = 1 По 9 Цикл
			
			ЗначениеЭлемента = ЭтаФорма["X" + x + "Y" + y];
			Если ЗначениеЭлемента = 0 Тогда
				Возврат Ложь;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Процедура ЗаполнитьТаблицаЗначениямиСтрок(x, y)
		
	ТаблицаЗначенийОтX.Очистить();
	ТаблицаЗначенийОтY.Очистить();
	
	Для i = 1 По 9 Цикл
		
		ЗначениеПоY = ЭтаФорма["X" + i + "Y" + y];
		Если ЗначениеПоY = 0 Тогда
			Продолжить;
		КонецЕсли;

		СтрокаТЧ = ТаблицаЗначенийОтY.Добавить();
		СтрокаТЧ.Значение = ЗначениеПоY;
		
	КонецЦикла;
	
	Для i = 1 По 9 Цикл
		
		ЗначениеПоX = ЭтаФорма["X" + x + "Y" + i];
		Если ЗначениеПоX = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаТЧ = ТаблицаЗначенийОтX.Добавить();
		СтрокаТЧ.Значение = ЗначениеПоX;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуЗначениямиБлока(x, y)

	ТаблицаЗначенийОтБлока.Очистить();
	
	Если x <= 3 Тогда
		МножительX = 1;
	ИначеЕсли x <= 6 Тогда
		МножительX = 2;
	ИначеЕсли x <= 9 Тогда
		МножительX = 3;
	КонецЕсли;
	
	Если y <= 3 Тогда
		МножительY = 1;
	ИначеЕсли y <= 6 Тогда
		МножительY = 2;
	ИначеЕсли y <= 9 Тогда
		МножительY = 3;
	КонецЕсли;
	
	Для ЗначениеX = 1 + ((МножительX-1)*3) По 3 * МножительX Цикл
		
		Для ЗначениеY = 1 + ((МножительY-1)*3) По 3 * МножительY Цикл
			
			ЗначениеБлока = ЭтаФорма["X" + ЗначениеX + "Y" + ЗначениеY];
			
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
	// Ты че такой крутой
	
КонецПроцедуры
















