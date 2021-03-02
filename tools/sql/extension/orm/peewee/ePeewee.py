# -*- coding: utf-8 -*-
import os
from peewee import *
db = SqliteDatabase('people.db')

class Person(Model):
    name = CharField()
    birthday = DateField()
    is_relative = BooleanField() 
    class Meta:
        database = db #  这个模型使用 "people.db"数据库

class Pet(Model):

    owner = ForeignKeyField(Person, related_name='pets')
    name = CharField()
    animal_type = CharField()

    class Meta:
        database = db # 这个模型使用"people.db"数据库


def main():
    from datetime import date
    uncle_bob = Person(name='Bob', birthday=date(1960, 1, 15), is_relative=True)
    uncle_bob.save()  # bob 现在被存储在数据库内

    grandma = Person.create(name='Grandma', birthday=date(1935, 3, 1), is_relative=True)
    herb = Person.create(name='Herb', birthday=date(1950, 5, 5), is_relative=False)
    print(grandma.name, grandma.birthday)
    grandma.name = 'Grandma L.'
    grandma.save()  # 在数据库更新Grandma的名字

    print(grandma.name, grandma.birthday)

    bob_kitty = Pet.create(owner=uncle_bob, name='Kitty', animal_type='cat')
    herb_fido = Pet.create(owner=herb, name='Fido', animal_type='dog')
    herb_mittens = Pet.create(owner=herb, name='Mittens', animal_type='cat')
    herb_mittens_jr = Pet.create(owner=herb, name='Mittens Jr', animal_type='cat')
    herb_mittens.delete_instance()  # 它拥有伟大的一生

    grandma = Person.select().where(Person.name == 'Grandma L.').get()
    # grandma = Person.get(Person.name == ‘Grandma L.’)

    for person in Person.select():
        print(person.name, person.is_relative)

    query = (Pet.select(Pet, Person).join(Person).where(Pet.animal_type == 'cat'))
    for pet in query:
        print(pet.name, pet.owner.name)


if __name__ == "__main__":
    print(db.connect())
    db.create_tables([Person, Pet])
    main()
    db.close()
    #python -m pwiz -e postgresql test > blog_models.py