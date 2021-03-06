
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
				
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЛоготипНажатие(Элемент)
	
	ПерейтиПоНавигационнойСсылке("http://" + Элементы.СайтЗначение.Заголовок);
	
КонецПроцедуры

&НаКлиенте
Процедура СайтЗначениеНажатие(Элемент)
	
	ПерейтиПоНавигационнойСсылке("http://" + Элементы.СайтЗначение.Заголовок);
	
КонецПроцедуры

&НаКлиенте
Процедура ТелефонЗначениеНажатие(Элемент)
	
	НомерТелефона = Элементы.ТелефонЗначение.Заголовок;
	ЗаменяемыеСимволы = "()_- ";
	СимволыЗамены ="";
	Для НомерСимвола = 1 По СтрДлина(ЗаменяемыеСимволы) Цикл
		НомерТелефона = СтрЗаменить(НомерТелефона, Сред(ЗаменяемыеСимволы, НомерСимвола, 1), Сред(СимволыЗамены, НомерСимвола, 1));
	КонецЦикла;
	
	ИмяПротокола = "tel";
	
	СтрокаЗапуска = ИмяПротокола + ":" + НомерТелефона;
	
	Оповещение = Новый ОписаниеОповещения("ПослеЗапускаПриложения", ЭтотОбъект);
	НачатьЗапускПриложения(Оповещение, СтрокаЗапуска);
		
КонецПроцедуры

Процедура ПослеЗапускаПриложения(ВыбранныйЭлемент, Параметры) Экспорт
	// Процедура заглушка, т.к. НачатьЗапускПриложения требуется наличие обработчика оповещения.
КонецПроцедуры

&НаКлиенте
Процедура ЭлектроннаяПочтаЗначениеНажатие(Элемент)
	
	
	ТемаПисьма = "Тема письма";
	ТекстПисьма = "Текст письма";
	СтрокаКоманды = "mailto:" + Элементы.ЭлектроннаяПочтаЗначение.Заголовок + "?subject=" + ТемаПисьма + "&body=" + ТекстПисьма;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗапуститьПочтовыйКлиентПослеЗапускаПриложения", ЭтаФорма);
	
	НачатьЗапускПриложения(ОписаниеОповещения, СтрокаКоманды);
	
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапуститьПочтовыйКлиентПослеЗапускаПриложения(КодВозврата, ДополнительныеПараметры) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#Область Коннект

&НаКлиенте
Процедура ОнлайнПоддержка(Команда)
	
	Если НЕ ЭтоWindowsКлиент() Тогда
		ПоказатьПредупреждение(,НСтр("ru = 'Для работы с приложением 1С-Бухфон необходима операционная система Microsoft Windows.'"));
		Возврат
	КонецЕсли;
	
	ПутьИзРеестра = ПутьКИсполняемомуФайлуИзРеестраWindows();

	ПараметрыЗапуска1СБухфон = " /StartedFrom1CConf";
	
	Оповещение = Новый ОписаниеОповещения("Запустить1СБухфонПослеЗапускаПриложения", ЭтотОбъект);
	
	НачатьЗапускПриложения(Оповещение, ПутьИзРеестра + ПараметрыЗапуска1СБухфон);

КонецПроцедуры

&НаКлиенте
// Продолжение процедуры (см. выше).
Процедура Запустить1СБухфонПослеЗапускаПриложения(КодВозврата, ДополнительныеПараметры) Экспорт 
	// Обработка не требуется.
КонецПроцедуры

&НаКлиенте
// Возвращает путь файла 1С-Бухфон в реестре Windows.
// 
Функция ПутьКИсполняемомуФайлуИзРеестраWindows() 
	
	Значение = "";
	
	Если НЕ ЭтоWindowsКлиент() Тогда
		Возврат Значение;
	КонецЕсли;
	
#Если ВебКлиент Тогда
	ЗначениеИзРеестра = "";
#Иначе
	RegProv = ПолучитьCOMОбъект("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv");
	RegProv.GetStringValue("2147483649","Software\Buhphone","ProgramPath",Значение);
	
	Если Значение = "" Или  Значение = NULL Тогда
		ЗначениеИзРеестра = "";
	Иначе
		ЗначениеИзРеестра = Значение;
	КонецЕсли;
	
	Возврат ЗначениеИзРеестра;
#КонецЕсли
	
КонецФункции

&НаКлиенте
// Возвращает Истина, если клиентское приложение запущено под управлением ОС Windows.
//
// Возвращаемое значение:
//  Булево. Если нет клиентского приложения, возвращается Ложь.
//
Функция ЭтоWindowsКлиент() 
	
	СистемнаяИнформация = Новый СистемнаяИнформация;
	
	ЭтоWindowsКлиент = СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86
	ИЛИ СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86_64;
	
	Возврат ЭтоWindowsКлиент;
	
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыИмяТаблицыФормы
#КонецОбласти

#Область ОбработчикиКомандФормы
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
#КонецОбласти