
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	// получение текущего пользователя
	//ТекущийПользователь = Пользователи.АвторизованныйПользователь();	
	
	// <название настройки>
	//<РеквизитФормы> = ХранилищеОбщихНастроек.Загрузить("<КлючОбъекта>", "<КлючНастроек>");
	//Если <РеквизитФормы> = Неопределено Тогда
	//	<РеквизитФормы> = <ЗначениеПоУмолчанию>;
	//	ХранилищеОбщихНастроек.Сохранить("<КлючОбъекта>", "<КлючНастроек>", <РеквизитФормы>);
	//КонецЕсли;
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	МассивСтруктур = Новый Массив;
	
	// <название настройки>
	Элемент = Новый Структура;
	//Элемент.Вставить("Объект", "<КлючОбъекта>");
	//Элемент.Вставить("Настройка", "<КлючНастроек>");
	//Элемент.Вставить("Значение", <РеквизитФормы>);
	МассивСтруктур.Добавить(Элемент);
	
	
	//ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекСохранитьМассив(МассивСтруктур);
	Закрыть();
	
	ОбновитьПовторноИспользуемыеЗначения();
		
КонецПроцедуры

&НаКлиенте
Процедура СведенияОПользователе(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПоказатьЗначениеЗавершение", ЭтаФорма);
	ПоказатьЗначение(ОписаниеОповещения, ТекущийПользователь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьЗначениеЗавершение(ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаКлиенте
Функция ОписаниеНастройки(Объект, Настройка, Значение)
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", Объект);
	Элемент.Вставить("Настройка", Настройка);
	Элемент.Вставить("Значение", Значение);
	
	Возврат Элемент;
	
КонецФункции

#КонецОбласти

#КонецОбласти
