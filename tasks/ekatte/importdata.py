import pandas
import psycopg2

oblasti = pandas.read_excel(r'/home/auzunov/excel/Ek_obl.xlsx')
obshtini = pandas.read_excel(r'/home/auzunov/excel/Ek_obst.xlsx')
ekatte = pandas.read_excel(r'/home/auzunov/excel/Ek_atte.xlsx')

oblasti_result = 'INSERT INTO oblasti VALUES '
obshtini_result = 'INSERT INTO obshtini VALUES '
ekatte_result = 'INSERT INTO selishta VALUES '

broi_oblasti = oblasti['oblast'].count()
broi_obshtini = obshtini['obstina'].count()
broi_ekatte = ekatte['ekatte'].count()


for i in range(broi_oblasti):
	oblasti_result = oblasti_result + "('%s','%s'),"%(oblasti['oblast'][i],oblasti['name'][i])
oblasti_result = oblasti_result[:-1]
	

for i in range(broi_obshtini):
	temp = obshtini['obstina'][i][:3]
	obshtini_result = obshtini_result + "('%s','%s',(SELECT oblast_id FROM oblasti WHERE oblast_id ='%s')),"%(obshtini['obstina'][i],obshtini['name'][i],temp)
obshtini_result = obshtini_result[:-1]


for i in range(1,broi_ekatte):
	ekatte_result = ekatte_result + "('%s', '%s', '%s','%s'),"%(ekatte['ekatte'][i],ekatte['t_v_m'][i],ekatte['name'][i],ekatte['obstina'][i])
ekatte_result = ekatte_result[:-1]

oblasti_result += ' ON CONFLICT (oblast_id) DO UPDATE SET oblast_id = oblasti.oblast_id'
obshtini_result += ' ON CONFLICT (obshtina_id) DO UPDATE SET obshtina_id = obshtini.obshtina_id'
ekatte_result += ' ON CONFLICT (ekatte) DO UPDATE SET ekatte = selishta.ekatte'

connection = psycopg2.connect(
	database = 'ekatte',
	user = 'ekatte',
	password = 'randompassword1234',
	host = '127.0.0.1',
	port = '5432'
)

sql = connection.cursor()

sql.execute(oblasti_result)
connection.commit()



sql.execute(obshtini_result)
connection.commit()



sql.execute(ekatte_result)
connection.commit()

oblselect = 'SELECT count(*) from oblasti'
sql.execute(oblselect)
obl_stat = sql.fetchone()

obsselect = 'SELECT count(*) from obshtini'
sql.execute(obsselect)
obs_stat = sql.fetchone()

ekselect = 'SELECT count(*) from selishta'
sql.execute(ekselect)
ekt_stat = sql.fetchone()





sql.close()
connection.close()

print("Брой на областите в базата = {:d}".format(obl_stat[0]))

print("Брой на общините в базата = {:d}".format(obs_stat[0]))

print("Брой на населените места в базата = {:d}".format(ekt_stat[0]))
