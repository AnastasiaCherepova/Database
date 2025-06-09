-- Управление проектами:
-- 1.	Создание нового: 
INSERT INTO Project (Name, Priority, Genre, Recording_ID, Client_ID, Actor_ID, SoundEngineer_ID, Administrator_ID)  
VALUES ('Новый Альбом', 'Высокая', 'Рок', 1, 2, 3, 4, 5);

-- 2.	Редактировать существующих:
UPDATE Project  
SET Name = 'Обновленный Альбом', Genre = 'Поп'  
WHERE ID = 1;

-- 3.	Удаление проектов:
DELETE FROM Payment WHERE Project_ID = 10;
DELETE FROM Project WHERE ID = 10;

-- Управление записями:
-- 4.	Создание записей:
INSERT INTO Recording (Duration, Quality)  
VALUES (240, 'Высокое');

-- 5.	Редактирование записей:
UPDATE Recording  
SET Quality = 'Среднее'  
WHERE ID = 5;

-- Управление сессиями:
-- 6.	Создание сессий записи:
INSERT INTO Session (Date, Duration, Project_ID)  
VALUES ('2024-07-15', '3 часа', 2);

-- 7.	Управление временем и участниками:
INSERT INTO Session_Actor (Session_ID, Actor_ID)  
VALUES (1, 3);

-- Управление оборудованием:
-- 8.	Получение списка оборудования студии:
SELECT Name, Type, Purpose  
FROM Equipment  
WHERE Studio_ID = 1;

-- Управление платежами:
-- 9.	Создание платежа:
INSERT INTO Payment (Method, Client_ID, Project_ID)  
VALUES ('Карта', 2, 3);

-- 10.	 Получение списка платежей клиента:
SELECT Payment.ID, Payment.Method, Project.Name  
FROM Payment  
INNER JOIN Project ON Payment.Project_ID = Project.ID  
WHERE Payment.Client_ID = 2;

-- 11.	 Исправление ошибочного контакта клиента:
UPDATE Client  
SET Contact = 'anna.smirnova@mail.ru'  
WHERE ID = 2;  

-- 12.	 Исправление роли актёра:
UPDATE Actor  
SET Role = 'Диктор аудиокниг'  
WHERE ID = 5;

-- 13.	Исправление названия студии:
UPDATE Studio  
SET Name = 'Echo Sound Records'  
WHERE Name = 'Echo Records';

-- 14.	 Изменение срока сдачи проекта:
UPDATE Requirements  
SET Deadlines = '2024-06-20'  
WHERE Project_ID = 2;

-- 15.	 Коррекция способа оплаты:
UPDATE Payment  
SET Method = 'Перевод'  
WHERE Client_ID = 5 AND Project_ID = 5;

-- 16.	 Удаление клиента с неверными данными:
-- Проверка:
SELECT * FROM Administrator WHERE Client_ID = (SELECT ID FROM Client WHERE FullName = 'Иван Иванов' AND Contact IS NULL);
SELECT * FROM Project WHERE Client_ID = (SELECT ID FROM Client WHERE FullName = 'Иван Иванов' AND Contact IS NULL);
SELECT * FROM Payment WHERE Client_ID = (SELECT ID FROM Client WHERE FullName = 'Иван Иванов' AND Contact IS NULL);

-- Удаление зависимых записей:
DELETE FROM Administrator WHERE Client_ID = (SELECT ID FROM Client WHERE FullName = 'Иван Иванов' AND Contact IS NULL);
DELETE FROM Project WHERE Client_ID = (SELECT ID FROM Client WHERE FullName = 'Иван Иванов' AND Contact IS NULL);
DELETE FROM Payment WHERE Client_ID = (SELECT ID FROM Client WHERE FullName = 'Иван Иванов' AND Contact IS NULL);

-- Удаление:
DELETE FROM Client WHERE FullName = 'Иван Иванов' AND Contact IS NULL;

-- 17.	Удаление ошибочно созданного проекта:
-- Проверка зависимостей:
SELECT * FROM Payment WHERE Project_ID = (SELECT ID FROM Project WHERE Name = 'Тестовый проект');
SELECT * FROM Requirements WHERE Project_ID = (SELECT ID FROM Project WHERE Name = 'Тестовый проект');
SELECT * FROM Session WHERE Project_ID = (SELECT ID FROM Project WHERE Name = 'Тестовый проект');

-- Удаление зависимых записей
DELETE FROM Payment WHERE Project_ID = (SELECT ID FROM Project WHERE Name = 'Тестовый проект');
DELETE FROM Requirements WHERE Project_ID = (SELECT ID FROM Project WHERE Name = 'Тестовый проект');
DELETE FROM Session WHERE Project_ID = (SELECT ID FROM Project WHERE Name = 'Тестовый проект');

-- Удаление проекта
DELETE FROM Project WHERE Name = 'Тестовый проект';

-- 18.	Удаление записи с некорректной продолжительностью:
-- Проверка зависимостей:
SELECT * FROM SoundEngineer WHERE Recording_ID IN (SELECT ID FROM Recording WHERE Duration <= 0);
SELECT * FROM Project WHERE Recording_ID IN (SELECT ID FROM Recording WHERE Duration <= 0);

-- Удаление зависимых записей:
DELETE FROM SoundEngineer WHERE Recording_ID IN (SELECT ID FROM Recording WHERE Duration <= 0);
DELETE FROM Project WHERE Recording_ID IN (SELECT ID FROM Recording WHERE Duration <= 0);

-- Удаление записи:
DELETE FROM Recording WHERE Duration <= 0;

-- 19.	 Удаление ненужного оборудования:
DELETE FROM Equipment  
WHERE Name = 'Старый микрофон' AND Studio_ID = 3;

-- 20.	 Удаление оплаты с некорректным методом:
-- Проверка зависимостей (опционально):
SELECT * FROM Client WHERE ID IN (SELECT Client_ID FROM Payment WHERE Method = 'Оплата по бартеру');
SELECT * FROM Project WHERE ID IN (SELECT Project_ID FROM Payment WHERE Method = 'Оплата по бартеру');

-- Удаление оплаты:
DELETE FROM Payment WHERE Method = 'Оплата по бартеру';

-- 21.	 Получение всех проектов с высокой приоритетностью:
SELECT *  
FROM Project  
WHERE Priority = 'Высокая';

-- 22.	 Получение уникальных жанров проектов:
SELECT DISTINCT Genre  
FROM Project;

-- 23.	 Поиск клиентов по определённому списку имён (IN):
SELECT FullName, Contact  
FROM Client  
WHERE FullName IN ('Иван Петров', 'Анна Смирнова', 'Сергей Иванов');

-- 24.	 Поиск записей со средним или высоким качеством (OR):
SELECT *  
FROM Recording  
WHERE Quality = 'Высокое' OR Quality = 'Среднее';

-- 25.	 Поиск проектов, у которых цена выше 30,000 и дедлайн после 1 июня 2024 (AND):
SELECT *  
FROM Requirements  
WHERE Price > 30000 AND Deadlines > '2024-06-01';

-- 26.	 Поиск оборудования, кроме микрофонов (NOT):
SELECT *  
FROM Equipment  
WHERE NOT Type = 'Звукоулавливающее';

-- 27.	 Поиск клиентов, у которых контактные данные не указаны (IS NULL)
SELECT FullName  
FROM Client  
WHERE Contact IS NULL;

-- 28.	 Поиск студий, расположенных в Москве или Санкт-Петербурге (IN):
SELECT Name  
FROM Studio  
WHERE Location IN ('Москва', 'Санкт-Петербург');

-- 29.	 Поиск проектов, у которых дедлайн между 1 июня и 1 октября 2024 (BETWEEN):
SELECT *  
FROM Requirements  
WHERE Deadlines BETWEEN '2024-06-01' AND '2024-10-01';

-- 30.	 Поиск записей, у которых продолжительность больше 2 минут (преобразование в секунды):
SELECT *  
FROM Recording  
WHERE Duration * 60 > 120;

-- 31.	 Вывод проектов с изменённым названием столбца (AS):
SELECT Name AS Название_проекта, Genre AS Жанр  
FROM Project;

-- 32.	 Получение всех платёжных методов без дубликатов (DISTINCT):
SELECT DISTINCT Method  
FROM Payment;

-- 33.	 Поиск проектов, в которых задействован конкретный актёр:
SELECT Project.Name  
FROM Project  
JOIN Actor ON Project.Actor_ID = Actor.ID  
WHERE Actor.FullName = 'Алексей Сидоров';

-- 34.	 Поиск актёров, работающих в студии с названием "VoiceArt Studio":
SELECT Actor.FullName  
FROM Actor  
JOIN Studio ON Actor.Studio_ID = Studio.ID  
WHERE Studio.Name = 'VoiceArt Studio';

-- 35.	 Поиск студий, у которых есть определённое оборудование:
SELECT Studio.Name  
FROM Studio  
JOIN Equipment ON Studio.ID = Equipment.Studio_ID  
WHERE Equipment.Name = 'Микрофон';

-- 36.	 Поиск клиентов, у которых фамилия начинается на "Ива" (LIKE):
SELECT FullName  
FROM Client  
WHERE FullName LIKE 'Ива%';

-- 37.	 Поиск проектов, в названии которых есть слово "Музыка" (LIKE c %):
SELECT Name  
FROM Project  
WHERE Name LIKE '%Музыка%';

-- 38.	 Поиск студий, названия которых заканчиваются на "Studio" (LIKE):
SELECT Name  
FROM Studio  
WHERE Name LIKE '%Studio';

-- 39.	 Поиск актёров, у которых в фамилии есть "ов" (LIKE):
SELECT FullName  
FROM Actor  
WHERE FullName LIKE '%ов%';

-- 40.	 Поиск клиентов с контактными данными, начинающимися с +7 (поиск по номеру телефона):
SELECT FullName, Contact  
FROM Client  
WHERE Contact LIKE '+7%';

-- 41.	 Объединение имени и фамилии с контактной информацией клиента в одно поле (CONCAT):
SELECT CONCAT(FullName, ' (', Contact, ')') AS КлиентИКонтакт
FROM Client;

-- 42.	Преобразование названий студий в верхний регистр (UPPER):
SELECT UPPER(Name) AS Название_в_верхнем_регистре  
FROM Studio;

-- 43.	 Создание таблицы с актерами, работающими в определенной студии:
-- Создание пустой таблицы
CREATE TABLE ActorsInStudioA (
ID INT,
FullName VARCHAR(255),
Role VARCHAR(255),
StudioName VARCHAR(255)
);

-- Вставка данных
INSERT INTO ActorsInStudioA (ID, FullName, Role, StudioName)
SELECT a.ID, a.FullName, a.Role, s.Name AS StudioName
FROM Actor a
JOIN Studio s ON a.Studio_ID = s.ID
WHERE s.Name = 'Golden Note';

-- Просмотр результата
SELECT * FROM ActorsInStudioA; 

-- 44.	 Создание таблицы с проектами высокого приоритета

CREATE TABLE HighPriorityProjects (
ID INT,
Name VARCHAR(255),
Priority VARCHAR(50),
Genre VARCHAR(100),
ClientName VARCHAR(255)
);

-- Вставка данных
INSERT INTO HighPriorityProjects (ID, Name, Priority, Genre, ClientName)
SELECT p.ID, p.Name, p.Priority, p.Genre, c.FullName AS ClientName
FROM Project p
JOIN Client c ON p.Client_ID = c.ID
WHERE p.Priority = 'Высокая';

-- Просмотр результата
SELECT * FROM HighPriorityProjects; 

-- 45.	 Создание таблицы со звукорежиссерами и их оборудованием

-- Создание пустой таблицы
CREATE TABLE SoundEngineersSpecialty (
ID INT,
FullName VARCHAR(255),
Specialty VARCHAR(255),
EquipmentName VARCHAR(255)
);

-- Вставка данных
INSERT INTO SoundEngineersSpecialty (ID, FullName, Specialty, EquipmentName)
SELECT se.ID, se.FullName, se.Specialty, e.Name AS EquipmentName
FROM SoundEngineer se
LEFT JOIN Equipment e ON se.Studio_ID = e.Studio_ID;

-- Просмотр результата
SELECT * FROM SoundEngineersSpecialty; 

-- 46.	 INNER JOIN (Внутреннее соединение) – клиенты и их проекты:
SELECT Client.FullName, Project.Name AS Project_Name  
FROM Client  
INNER JOIN Project ON Client.ID = Project.Client_ID;

-- 47.	 LEFT JOIN (Левое соединение) – студии и редакторы:
SELECT Studio.Name AS Studio_Name, Editor.FullName AS Editor_Name  
FROM Studio  
LEFT JOIN Editor ON Studio.ID = Editor.Studio_ID;

-- 48.	 RIGHT JOIN (Правое соединение) – студии и редакторы:
SELECT Studio.Name AS Studio_Name, Editor.FullName AS Editor_Name  
FROM Studio  
RIGHT JOIN Editor ON Studio.ID = Editor.Studio_ID;

-- 49.	 FULL OUTER JOIN (Полное соединение (эмуляция)) – студии и оборудование:
SELECT Studio.Name AS Studio_Name, Equipment.Name AS Equipment_Name
FROM Studio
LEFT JOIN Equipment ON Studio.ID = Equipment.Studio_ID
UNION
SELECT Studio.Name AS Studio_Name, Equipment.Name AS Equipment_Name
FROM Studio
RIGHT JOIN Equipment ON Studio.ID = Equipment.Studio_ID;
 
-- 50.	 CROSS JOIN (Декартово произведение) – сочетания актёров и студий:
SELECT Actor.FullName, Studio.Name  
FROM Actor  
CROSS JOIN Studio;

-- 51.	 NATURAL JOIN (Соединение по одинаковым столбцам) – проект и запись:
SELECT *  
FROM Project  
NATURAL JOIN Recording;

-- 52.	 INNER JOIN с двумя JOIN – проекты, актёры и студии:
SELECT Project.Name AS Project_Name, Actor.FullName AS Actor_Name, Studio.Name AS Studio_Name  
FROM Project  
INNER JOIN Actor ON Project.Actor_ID = Actor.ID  
INNER JOIN Studio ON Actor.Studio_ID = Studio.ID;

-- 53.	 LEFT JOIN с двумя JOIN – звукорежиссёры и их студии и редакторы:
SELECT SoundEngineer.FullName AS Engineer_Name, Studio.Name AS Studio_Name, Editor.FullName AS Editor_Name  
FROM SoundEngineer  
LEFT JOIN Studio ON SoundEngineer.Studio_ID = Studio.ID  
LEFT JOIN Editor ON SoundEngineer.Editor_ID = Editor.ID;

-- 54.	 RIGHT JOIN с двумя JOIN – актёры, проекты и администраторы:
SELECT Actor.FullName AS Actor_Name, Project.Name AS Project_Name, Administrator.FullName AS Admin_Name  
FROM Project  
RIGHT JOIN Actor ON Project.Actor_ID = Actor.ID  
RIGHT JOIN Administrator ON Project.Administrator_ID = Administrator.ID;

-- 55.	 Соединение с BETWEEN – платежи за период:
SELECT Payment.Method, Client.FullName, Project.Name  
FROM Payment  
INNER JOIN Client ON Payment.Client_ID = Client.ID  
INNER JOIN Project ON Payment.Project_ID = Project.ID  
WHERE Payment.ID BETWEEN 2 AND 5;

-- 56.	 Соединение с IN – проекты с определёнными приоритетами:
SELECT Project.Name, Project.Priority, Client.FullName  
FROM Project  
INNER JOIN Client ON Project.Client_ID = Client.ID  
WHERE Project.Priority IN ('Высокая', 'Средняя');

-- 57.	 Соединение "многие ко многим" – актёры и их сессии:
SELECT Actor.FullName AS Actor_Name, Session.ID AS Session_Name  
FROM Session_Actor  
INNER JOIN Actor ON Session_Actor.Actor_ID = Actor.ID  
INNER JOIN Session ON Session_Actor.Session_ID = Session.ID; 

-- 58.	 LEFT JOIN с NULL – актёры, которые не участвуют не в одной сессии:
SELECT Actor.FullName
FROM Actor
LEFT JOIN Session_Actor ON Actor.ID = Session_Actor.Actor_ID
WHERE Session_Actor.Session_ID IS NULL;

-- 59.	FULL OUTER JOIN через UNION – администраторы и клиенты:
SELECT Administrator.FullName AS Name, 'Администратор' AS Role  
FROM Administrator  
UNION  
SELECT Client.FullName AS Name, 'Client' AS Role  
FROM Client;

-- 60.	 CROSS JOIN с фильтрацией – тестирование всех комбинаций: 
SELECT SoundEngineer.FullName, Equipment.Name  
FROM SoundEngineer  
CROSS JOIN Equipment  
WHERE Equipment.Type = 'Запись';

-- 61.	 Подсчёт количества проектов в каждом жанре:
SELECT Genre, COUNT(*) AS Project_Count
FROM Project
GROUP BY Genre
ORDER BY Project_Count DESC;

-- 62.	 Найти студии с наибольшим количеством актёров:
SELECT Studio.Name AS Studio_Name, COUNT(Actor.ID) AS Actor_Count
FROM Studio
JOIN Actor ON Studio.ID = Actor.Studio_ID
GROUP BY Studio.ID
ORDER BY Actor_Count DESC
LIMIT 5;

-- 63.	 Средняя продолжительность записей по качеству:
SELECT Quality, AVG(Duration) AS Avg_Duration
FROM Recording
GROUP BY Quality
ORDER BY Avg_Duration DESC;

-- 64.	 Определение минимальной и максимальной стоимости проектов:
SELECT MIN(Price) AS Min_Price, MAX(Price) AS Max_Price
FROM Requirements;

-- 65.	 Общая сумма платежей по каждому методу оплаты:
SELECT Method, SUM(Price) AS Total_Sum
FROM Payment
JOIN Requirements ON Payment.Project_ID = Requirements.Project_ID
GROUP BY Method
ORDER BY Total_Sum DESC;

-- 66.	 Сумма требований по клиентам:
SELECT Client_ID, SUM(Price) AS TotalRequirementsCost
FROM Project
JOIN Requirements ON Project.ID = Requirements.Project_ID
GROUP BY Client_ID
ORDER BY TotalRequirementsCost DESC
LIMIT 10;

-- 67.	Найти студии с наибольшим количеством оборудования:
SELECT Studio.Name, COUNT(Equipment.ID) AS Equipment_Count
FROM Studio
JOIN Equipment ON Studio.ID = Equipment.Studio_ID
GROUP BY Studio.ID
ORDER BY Equipment_Count DESC
LIMIT 3;

-- 68.	 Количество клиентов, оплативших проекты через определённые методы:
SELECT Method, COUNT(DISTINCT Client_ID) AS Unique_Clients
FROM Payment
GROUP BY Method
HAVING Unique_Clients > 2;

-- 69.	 Количество проектов по каждому администратору:
SELECT Administrator.FullName, COUNT(Project.ID) AS Project_Count
FROM Administrator
JOIN Project ON Administrator.ID = Project.Administrator_ID
GROUP BY Administrator.ID
ORDER BY Project_Count DESC;

-- 70.	 Минимальное количество актёров, задействованных в сессиях проекта:
SELECT s.Project_ID, COUNT(DISTINCT sa.Actor_ID) AS ActorCount
FROM Session s
JOIN Session_Actor sa ON s.ID = sa.Session_ID
GROUP BY s.Project_ID
HAVING ActorCount >= 2
ORDER BY ActorCount ASC;
 
-- 71.	Топ-3 проекта с самой высокой стоимостью:
SELECT Project.Name, Requirements.Price
FROM Project
JOIN Requirements ON Project.ID = Requirements.Project_ID
ORDER BY Requirements.Price DESC
LIMIT 3;

-- 72.	 Сколько актёров работает в каждой студии, но только если больше 2-х:
SELECT Studio.Name, COUNT(Actor.ID) AS Actor_Count
FROM Studio
JOIN Actor ON Studio.ID = Actor.Studio_ID
GROUP BY Studio.ID
HAVING Actor_Count > 2;

-- 73.	 Средняя стоимость проектов в жанре "Озвучка":
SELECT AVG(Requirements.Price) AS Avg_Price
FROM Requirements
JOIN Project ON Requirements.Project_ID = Project.ID
WHERE Project.Genre = 'Озвучка';

-- 74.	 Количество записей в каждом качестве звука:
SELECT Quality, COUNT(*) AS Recording_Count
FROM Recording
GROUP BY Quality;

-- 75.	 Средняя длительность записи по качеству:
SELECT Quality, COUNT(*) AS Recording_Count
FROM Recording
GROUP BY Quality;

-- 76.	 Объединение списков клиентов и актёров (UNION):
SELECT ID, FullName, 'Клиент' AS Role FROM Client
UNION
SELECT ID, FullName, 'Актёр' AS Role FROM Actor;

-- 77.	 Найти проекты, у которых есть платежи, но у них низкий приоритет (UNION):
SELECT Project_ID FROM Payment
UNION 
SELECT ID FROM Project WHERE Priority = 'Низкий';

-- 78.	Найти клиентов, которые одновременно являются актёрами (UNION): 
SELECT FullName FROM Client
UNION
SELECT FullName FROM Actor;

-- 79.	Список всех пользователей системы: клиенты, актёры, администраторы (UNION ALL):
SELECT FullName, 'Клиент' AS UserType FROM Client
UNION ALL
SELECT FullName, 'Актёр' AS UserType FROM Actor
UNION ALL
SELECT FullName, 'Администратор' AS UserType FROM Administrator;
 
-- 80.	 Найти оборудование, которое используется в студиях, но не сдано в аренду (UNION):
SELECT FullName FROM Actor
UNION
SELECT FullName FROM Editor;

-- 81.	 Найти студии, в которых есть актёры (EXISTS):
SELECT Name, Location 
FROM Studio S
WHERE EXISTS (
    SELECT 1 FROM Actor A WHERE A.Studio_ID = S.ID
);

-- 82.	 Найти клиентов, оплативших все свои проекты (ALL):
SELECT FullName 
FROM Client C
WHERE C.ID = ALL (
    SELECT Client_ID FROM Payment
);

-- 83.	 Найти актёров, которые участвовали хотя бы в одной сессии (EXISTS + вложенный JOIN):
SELECT FullName 
FROM Actor A
WHERE EXISTS (
    SELECT 1 FROM Session_Actor SA
    JOIN Session S ON SA.Session_ID = S.ID
    WHERE SA.Actor_ID = A.ID
);

-- 84.	 Вывести типы оборудования, у которых количество оборудования больше, чем у любого другого типа, находящегося в студии с ID = 1 (ANY + GROUP BY): 
SELECT E.Type
FROM Equipment E
GROUP BY E.Type
HAVING COUNT(*) > ANY (
    SELECT COUNT(*)
    FROM Equipment
    WHERE Studio_ID = 1
    GROUP BY Type
);

-- 85.	Найти клиентов, у которых есть хотя бы один проект с бюджетом выше среднего (ANY + AVG + GROUP BY):
SELECT C.FullName 
FROM Client C
WHERE C.ID = ANY (
    SELECT P.Client_ID
    FROM Project P
    JOIN Requirements R ON R.Project_ID = P.ID
    WHERE R.Price > (SELECT AVG(Price) FROM Requirements)
);

-- 86.	 Получить список актёров в каждой студии (GROUP_CONCAT):
SELECT S.Name AS Студия, 
       GROUP_CONCAT(A.FullName SEPARATOR ', ') AS Актёры
FROM Studio S
LEFT JOIN Actor A ON S.ID = A.Studio_ID
GROUP BY S.Name;

-- 87.	 Найти среднюю продолжительность записей для каждого качества (AVG, ROUND):
SELECT Quality AS Качество, 
       ROUND(AVG(Duration), 2) AS Средняя_длительность 
FROM Recording
GROUP BY Quality;

-- 88.	 Найти клиентов и список их оплаченных проектов (GROUP_CONCAT, JOIN):
SELECT C.FullName AS Клиент, 
       GROUP_CONCAT(P.Name ORDER BY P.Name SEPARATOR ', ') AS Оплаченные_проекты
FROM Client C
JOIN Payment Pay ON C.ID = Pay.Client_ID
JOIN Project P ON Pay.Project_ID = P.ID
GROUP BY C.FullName;

-- 89.	 Найти среднюю продолжительность сессий по проектам:
WITH SessionDurations AS (
    SELECT Project_ID, 
           AVG(CAST(SUBSTRING_INDEX(Duration, ' ', 1) AS DECIMAL(10,2))) AS AvgDuration
    FROM Session
    GROUP BY Project_ID
)
SELECT P.Name AS Проект, 
       SD.AvgDuration AS Средняя_длительность
FROM SessionDurations SD
JOIN Project P ON SD.Project_ID = P.ID
ORDER BY SD.AvgDuration DESC;
 
-- 90.	 Найти топ-3 студии по количеству актёров:
WITH StudioActors AS (
    SELECT Studio_ID, COUNT(*) AS Количество_актёров
    FROM Actor
    GROUP BY Studio_ID
)
SELECT S.Name AS Студия, SA.Количество_актёров
FROM StudioActors SA
JOIN Studio S ON SA.Studio_ID = S.ID
ORDER BY SA.Количество_актёров DESC
LIMIT 3;
 
-- 91.	 Найти клиентов, оплативших больше 1 проекта:
WITH ClientPayments AS (
    SELECT Client_ID, COUNT(*) AS Количество_проектов
    FROM Payment
    GROUP BY Client_ID
    HAVING COUNT(*) > 1
)
SELECT C.FullName AS Клиент, CP.Количество_проектов
FROM ClientPayments CP
JOIN Client C ON CP.Client_ID = C.ID
ORDER BY CP.Количество_проектов DESC;

-- 92.	 Приведение имен клиентов к верхнему регистру (UPPER):
SELECT FullName AS Оригинал, 
       UPPER(FullName) AS В_верхнем_регистре
FROM Client;

-- 93.	 Извлечение года и месяца из даты платежа (YEAR, MONTH):
SELECT P.ID AS Платёж_ID, 
       C.FullName AS Клиент, 
       YEAR(PM.Deadlines) AS Год_платежа, 
       MONTH(PM.Deadlines) AS Месяц_платежа
FROM Payment P
JOIN Requirements PM ON P.Project_ID = PM.Project_ID
JOIN Client C ON P.Client_ID = C.ID;

-- 94.	 Форматирование дат (DATE_FORMAT):
SELECT Date AS Оригинальная_дата, 
       DATE_FORMAT(Date, '%d.%m.%Y') AS Отформатированная_дата
FROM Session;

-- 95.	 Вычисление разницы между текущей датой и дедлайном проекта (DATEDIFF):
SELECT P.Name AS Проект, 
       R.Deadlines AS Дедлайн, 
       DATEDIFF(R.Deadlines, CURDATE()) AS Дней_до_дедлайна
FROM Requirements R
JOIN Project P ON R.Project_ID = P.ID;

-- 96.	Конкатенация строк (CONCAT):
SELECT CONCAT('Проект "', Name, '" имеет приоритет ', Priority) AS Описание
FROM Project;

-- 97.	 Список актёров с количеством записанных сессий, упорядоченный по количеству сессий (INNER JOIN, GROUP BY, ORDER BY, LIMIT):
SELECT A.FullName AS Актёр, 
       COUNT(SA.Session_ID) AS Количество_сессий
FROM Actor A
JOIN Session_Actor SA ON A.ID = SA.Actor_ID
JOIN Session S ON SA.Session_ID = S.ID
GROUP BY A.ID
ORDER BY Количество_сессий DESC
LIMIT 10;
 
-- 98.	 Топ клиентов по общей сумме платежей (JOIN, SUM, GROUP BY, ORDER BY, LIMIT):
SELECT C.FullName AS Клиент,
       SUM(R.Price) AS Общая_сумма_платежей
FROM Client C
JOIN Project P ON C.ID = P.Client_ID
JOIN Requirements R ON P.ID = R.Project_ID
GROUP BY C.ID
ORDER BY Общая_сумма_платежей DESC
LIMIT 5;
 
-- 99.	 Количество проектов с приближающимся дедлайном (DATEDIFF, WHERE, GROUP BY, HAVING):
SELECT P.Priority AS Приоритет, 
       COUNT(R.ID) AS Количество_проектов
FROM Requirements R
JOIN Project P ON R.Project_ID = P.ID
WHERE DATEDIFF(R.Deadlines, CURDATE()) <= 7
GROUP BY P.Priority
HAVING COUNT(R.ID) > 0
ORDER BY P.Priority ASC;
 
-- 100.	Использование оборудования (JOIN, ORDER BY):
SELECT E.Name AS Оборудование,
       S.Name AS Студия,
       E.Type AS Тип,
       E.Purpose AS Назначение
FROM Equipment E
JOIN Studio S ON E.Studio_ID = S.ID
ORDER BY S.Name, E.Name;
 
-- 101.	Средняя длительность сессий по каждому проекту, с фильтрацией по активным проектам (JOIN, AVG, GROUP BY, HAVING, ORDER BY):
SELECT P.Name AS Проект, 
       AVG(S.Duration) AS Средняя_длительность_сессий
FROM Project P
JOIN Session S ON P.ID = S.Project_ID
GROUP BY P.ID
HAVING AVG(S.Duration) > 2
ORDER BY Средняя_длительность_сессий DESC;

 
