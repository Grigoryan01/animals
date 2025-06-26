from datetime import datetime

class Zhivotnoe:
    def __init__(self, name, birth_date):
        self._name = name
        self._birth_date = birth_date
        self._commands = []

    def get_name(self):
        return self._name

    def get_birth_date(self):
        return self._birth_date

    def get_commands(self):
        return self._commands

    def learn_command(self, command):
        if command not in self._commands:
            self._commands.append(command)


class DomashnieZhivotnoe(Zhivotnoe):
    def __init__(self, name, birth_date, vid):
        super().__init__(name, birth_date)
        self.vid = vid  # Собака, Кошка и т.д.


class VyuchnoeZhivotnoe(Zhivotnoe):
    def __init__(self, name, birth_date, vid):
        super().__init__(name, birth_date)
        self.vid = vid  # Лошадь, Осёл и т.д.


class CounterException(Exception):
    pass

class Counter:
    def __init__(self):
        self.value = 0
        self._open = False

    def __enter__(self):
        self._open = True
        return self

    def add(self):
        if not self._open:
            raise CounterException("Счётчик используется вне контекстного менеджера")
        self.value += 1

    def __exit__(self, exc_type, exc_val, exc_tb):
        self._open = False
        if self.value == 0:
            raise CounterException("Животное не добавлено — счётчик остался 0")




animals = []

def create_animal():
    name = input("Введите имя животного: ")
    birth_str = input("Введите дату рождения (ГГГГ-ММ-ДД): ")
    birth_date = datetime.strptime(birth_str, "%Y-%m-%d").date()
    category = input("Категория (домашнее/вьючное): ").lower()
    vid = input("Введите вид животного (собака, кошка, лошадь и т.д.): ")

    with Counter() as counter:
        if category == "домашнее":
            animal = DomashnieZhivotnoe(name, birth_date, vid)
        else:
            animal = VyuchnoeZhivotnoe(name, birth_date, vid)
        animals.append(animal)
        counter.add()
        print("✅ Животное добавлено!")


def show_commands():
    name = input("Введите имя животного: ")
    for a in animals:
        if a.get_name() == name:
            print(f"Команды: {a.get_commands()}")
            return
    print("⚠ Животное не найдено")


def train_animal():
    name = input("Введите имя животного: ")
    for a in animals:
        if a.get_name() == name:
            command = input("Введите новую команду: ")
            a.learn_command(command)
            print("✅ Команда добавлена!")
            return
    print("⚠ Животное не найдено")


def menu():
    while True:
        print("\n=== МЕНЮ ===")
        print("1. Завести новое животное")
        print("2. Посмотреть команды животного")
        print("3. Обучить животное")
        print("4. Выйти")

        choice = input("Выбор: ")

        if choice == "1":
            try:
                create_animal()
            except CounterException as e:
                print(f"❌ Ошибка: {e}")
        elif choice == "2":
            show_commands()
        elif choice == "3":
            train_animal()
        elif choice == "4":
            break
        else:
            print("Неверный выбор. Попробуйте снова.")


if __name__ == "__main__":
    menu()
