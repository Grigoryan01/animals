CREATE DATABASE Друзья_человека CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Друзья_человека;


CREATE TABLE Животные (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    тип_животного VARCHAR(50), -- Домашнее или Вьючное
    класс VARCHAR(50), -- Собака, Кошка, Лошадь и т.д.
    дата_рождения DATE
);
--Собаки
CREATE TABLE Собаки (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE
);

INSERT INTO Собаки (имя, команды, дата_рождения) VALUES
('Шарик', 'сидеть, лежать', '2021-04-15'),
('Бобик', 'апорт, голос', '2020-08-10');

--Кошки
CREATE TABLE Кошки (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE
);

INSERT INTO Кошки (имя, команды, дата_рождения) VALUES
('Мурка', 'ко мне, прыгнуть', '2021-03-08'),
('Барсик', 'дай лапу', '2020-09-15'),
('Снежок', 'сидеть', '2022-12-01');

--Хомяки
CREATE TABLE Хомяки (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE
);

INSERT INTO Хомяки (имя, команды, дата_рождения) VALUES
('Пушистик', 'бегать в колесе', '2023-04-10'),
('Сэм', 'прятаться', '2022-08-20'),
('Милка', 'крутиться', '2021-06-15');


--Лошади
CREATE TABLE Лошади (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE
);

INSERT INTO Лошади (имя, команды, дата_рождения) VALUES
('Буцефал', 'вперед, шагом, рысью', '2019-10-10'),
('Гром', 'стоять, поворот', '2020-01-05'),
('Тайфун', 'галоп, назад', '2021-02-22');


--Верблюды
CREATE TABLE Верблюды (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE
);

INSERT INTO Верблюды (имя, команды, дата_рождения) VALUES
('Али', 'вперед, сесть, встать', '2020-04-14'),
('Касим', 'поворот, стоп', '2019-11-11'),
('Сахара', 'идти, лечь', '2021-08-30');

--Ослы
CREATE TABLE Ослы (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE
);

INSERT INTO Ослы (имя, команды, дата_рождения) VALUES
('Ослик Иа', 'стоять, вперед', '2022-01-01'),
('Макс', 'нести груз, поворот', '2021-04-21'),
('Джек', 'остановка, назад', '2020-07-12');

DELETE FROM Верблюды;

CREATE TABLE Лошади_Ослы (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE
);
	

INSERT INTO Лошади_Ослы (имя, команды, дата_рождения)
SELECT имя, команды, дата_рождения FROM Лошади;

INSERT INTO Лошади_Ослы (имя, команды, дата_рождения)
SELECT имя, команды, дата_рождения FROM Ослы;

--Молодые животные
CREATE TABLE Молодые_животные AS
SELECT
    id,
    имя,
    команды,
    дата_рождения,
    TIMESTAMPDIFF(MONTH, дата_рождения, CURDATE()) AS возраст_в_месяцах
FROM (
    SELECT * FROM Собаки
    UNION ALL
    SELECT * FROM Кошки
    UNION ALL
    SELECT * FROM Хомяки
    UNION ALL
    SELECT * FROM Лошади_Ослы
) AS Все_животные
WHERE TIMESTAMPDIFF(YEAR, дата_рождения, CURDATE()) BETWEEN 1 AND 3;



CREATE TABLE Все_Животные_Объединенные (
    id INT AUTO_INCREMENT PRIMARY KEY,
    имя VARCHAR(50),
    команды TEXT,
    дата_рождения DATE,
    источник VARCHAR(50)
);


INSERT INTO Все_Животные_Объединенные (имя, команды, дата_рождения, источник)
SELECT имя, команды, дата_рождения, 'Собаки' FROM Собаки;

INSERT INTO Все_Животные_Объединенные (имя, команды, дата_рождения, источник)
SELECT имя, команды, дата_рождения, 'Кошки' FROM Кошки;

INSERT INTO Все_Животные_Объединенные (имя, команды, дата_рождения, источник)
SELECT имя, команды, дата_рождения, 'Хомяки' FROM Хомяки;

INSERT INTO Все_Животные_Объединенные (имя, команды, дата_рождения, источник)
SELECT имя, команды, дата_рождения, 'Лошади' FROM Лошади;

INSERT INTO Все_Животные_Объединенные (имя, команды, дата_рождения, источник)
SELECT имя, команды, дата_рождения, 'Верблюды' FROM Верблюды;

INSERT INTO Все_Животные_Объединенные (имя, команды, дата_рождения, источник)
SELECT имя, команды, дата_рождения, 'Ослы' FROM Ослы;


