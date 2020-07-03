import pandas
import psycopg2

oblasti = pandas.read_excel(r'/home/auzunov/Downloads/Ekatte/Ekatte_xlsx/Ek_obl.xlsx')
obshtini = pandas.read_excel(r'/home/auzunov/Downloads/Ekatte/Ekatte_xlsx/Ek_obst.xlsx')
ekatte = pandas.read_excel(r'/home/auzunov/Downloads/Ekatte/Ekatte_xlsx/Ek_atte.xlsx')

oblasti_result = 'INSERT INTO oblasti VALUES '
obshtini_result = 'INSERT INTO obshtini VALUES '
ekatte_result = 'INSERT INTO ekatte VALUES '

broi_oblasti = oblasti['oblast'].count()
broi_obshtini = obshtini['obstina'].count()
broi_ekatte = ekatte['ekatte'].count()


for i in range(broi_oblasti):
	oblasti_result = oblasti_result + "('%s','%s'),"%(oblasti['oblast'][i],oblasti['name'][i])
oblasti_result = oblasti_result[:-1]
	

for i in range(broi_obshtini):
	temp = obshtini['obstina'][i][:3]
	obshtini_result = obshtini_result + "('%s','%s',(SELECT oblast FROM oblasti WHERE oblast ='%s')),"%(obshtini['obstina'][i],obshtini['name'][i],temp)
obshtini_result = obshtini_result[:-1]


for i in range(1,broi_ekatte):
	ekatte_result = ekatte_result + "('%s', '%s', '%s','%s'),"%(ekatte['ekatte'][i],ekatte['t_v_m'][i],ekatte['name'][i],ekatte['obstina'][i])
ekatte_result = ekatte_result[:-1]


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

sql.close()
connection.close()

