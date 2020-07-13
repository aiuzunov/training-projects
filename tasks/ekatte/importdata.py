import pandas
import psycopg2

connection = psycopg2.connect(
    database='ekatte',
    user='ekatte',
    password='randompassword1234',
    host='127.0.0.1',
    port='5432'
)

sql = connection.cursor()

oblasti = pandas.read_excel(r'/home/auzunov/Downloads/Ekatte/Ekatte_xlsx/Ek_obl.xlsx')
obshtini = pandas.read_excel(r'/home/auzunov/Downloads/Ekatte/Ekatte_xlsx/Ek_obst.xlsx')
ekatte = pandas.read_excel(r'/home/auzunov/Downloads/Ekatte/Ekatte_xlsx/Ek_atte.xlsx')

oblasti_result = 'INSERT INTO oblasti VALUES '
obshtini_result = 'INSERT INTO obshtini VALUES '
ekatte_result = 'INSERT INTO ekatte VALUES '

broi_oblasti = oblasti['oblast'].count()
broi_obshtini = obshtini['obstina'].count()
broi_ekatte = ekatte['ekatte'].count()

oblastiqueries = int(broi_oblasti / 100)
oblastiostatuk = broi_oblasti % 100

obshtiniqueries = int(broi_obshtini / 100)
obshtiniostatuk = broi_obshtini % 100

ekattequeries = int(broi_ekatte / 100)
ekatteostatuk = broi_ekatte % 100

x = 0

for j in range(oblastiqueries):
    oblasti_result = 'INSERT INTO oblasti VALUES '
    for i in range(x, x + 100):
        oblasti_result = oblasti_result + "('%s','%s')," % (oblasti['oblast'][i], oblasti['name'][i])
    oblasti_result = oblasti_result[:-1]
    oblasti_result += ' ON CONFLICT (oblast) DO UPDATE SET oblast = oblasti.oblast'
    sql.execute(oblasti_result)
    x = x + 100
oblasti_result = 'INSERT INTO oblasti VALUES '
for i in range(broi_oblasti - oblastiostatuk, broi_oblasti):
    oblasti_result = oblasti_result + "('%s','%s')," % (oblasti['oblast'][i], oblasti['name'][i])
oblasti_result = oblasti_result[:-1]
oblasti_result += ' ON CONFLICT (oblast) DO UPDATE SET oblast = oblasti.oblast'
sql.execute(oblasti_result)

x = 0

for j in range(obshtiniqueries):
    obshtini_result = 'INSERT INTO obshtini VALUES '
    for i in range(x, x + 100):
        temp = obshtini['obstina'][i][:3]
        obshtini_result = obshtini_result + "('%s','%s',(SELECT oblast FROM oblasti WHERE oblast ='%s'))," % (
        obshtini['obstina'][i], obshtini['name'][i], temp)
    obshtini_result = obshtini_result[:-1]
    obshtini_result += ' ON CONFLICT (obshtina) DO UPDATE SET obshtina = obshtini.obshtina'
    sql.execute(obshtini_result)
    x = x + 100

obshtini_result = 'INSERT INTO obshtini VALUES '
for i in range(broi_obshtini - obshtiniostatuk, broi_obshtini):
    temp = obshtini['obstina'][i][:3]
    obshtini_result = obshtini_result + "('%s','%s',(SELECT oblast FROM oblasti WHERE oblast ='%s'))," % (
    obshtini['obstina'][i], obshtini['name'][i], temp)
obshtini_result = obshtini_result[:-1]
obshtini_result += ' ON CONFLICT (obshtina) DO UPDATE SET obshtina = obshtini.obshtina'
sql.execute(obshtini_result)

x = 1

for j in range(ekattequeries):
    ekatte_result = 'INSERT INTO ekatte VALUES '
    for i in range(x, x + 100):
        ekatte_result = ekatte_result + "('%s', '%s', '%s','%s')," % (
        ekatte['ekatte'][i], ekatte['t_v_m'][i], ekatte['name'][i], ekatte['obstina'][i])
    ekatte_result = ekatte_result[:-1]
    ekatte_result += ' ON CONFLICT (ekatte) DO UPDATE SET ekatte = ekatte.ekatte'
    sql.execute(ekatte_result)
    x = x + 100
ekatte_result = 'INSERT INTO ekatte VALUES '
for i in range(broi_ekatte - ekatteostatuk, broi_ekatte):
    ekatte_result = ekatte_result + "('%s', '%s', '%s','%s')," % (
    ekatte['ekatte'][i], ekatte['t_v_m'][i], ekatte['name'][i], ekatte['obstina'][i])
ekatte_result = ekatte_result[:-1]
ekatte_result += ' ON CONFLICT (ekatte) DO UPDATE SET ekatte = ekatte.ekatte'
sql.execute(ekatte_result)

connection.commit()

sql.close()
connection.close()